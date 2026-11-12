# =====================================================================
# A SPECIAL FIX FOR WINDOWS COMPUTERS TO PREVENT ERRORS
# =====================================================================
try:
    # Try to load a backup helper tool called 'pysqlite3'
    __import__('pysqlite3')
    import sys
    # Swap out the broken standard tool with our backup helper tool
    sys.modules['sqlite3'] = sys.modules.pop('pysqlite3')
except ImportError:
    # If the helper tool isn't there, don't crash, just skip this fix
    pass

# =====================================================================
# LOADING THE TOOLS OUR PROGRAM NEEDS TO RUN
# =====================================================================
import mysql.connector                      # Tool to talk to our MySQL database where cafe data is stored
import ollama                               # Tool to talk to the AI brain (Llama 3.1) running on our computer
import streamlit as st                      # Tool to build the beautiful website interface and chat box
import chromadb                             # A smart folder to store and search through our text files (RAG)
from sklearn.linear_model import LinearRegression  # A simple math model that draws a line to guess future trends
from prophet import Prophet                 # A smart model made by Meta/Facebook to guess future sales using calendar patterns
import numpy as np                          # Tool to help with heavy number crunching and math lists
from datetime import datetime, timedelta    # Tools to help our code understand calendar dates and look into tomorrow
import pandas as pd                         # Tool to organize data into clean, readable spreadsheet tables
import json                                 # Tool to safely read organized data lists from the AI brain
import sqlparse                             # Tool to inspect AI-generated SQL before running it
import os
from pathlib import Path                  # Tool to locate files beside sales.py
from dotenv import load_dotenv             # pip install python-dotenv

# Find the folder containing this Python script, even when launched elsewhere
BASE_DIR = Path(__file__).resolve().parent

# Load database settings from the .env file in the same folder as sales.py
load_dotenv(dotenv_path=BASE_DIR / ".env")

# =====================================================================
# 1. SETTING UP HOW THE WEB PAGE LOOKS
# =====================================================================
# Set the browser tab title and add a Boba Tea emoji as the icon
st.set_page_config(page_title="Sales Overview Chatbot", page_icon="🧋") 
# Show a big main title at the top of our website page
st.title("🧋 My Local Database Chatbot")
# Write a helpful subtitle explaining what our website can do
st.write("Ask me data questions, trigger machine learning predictions, or chat with me casually!")

# Check if this is the user's first time opening the page
if "messages" not in st.session_state:
    # Create an empty memory bank to remember the chat history so far
    st.session_state.messages = []

# =====================================================================
# 2. SETTING UP OUR DATABASE CONNECTION
# =====================================================================
# The secret login details to access our local cafe data files


db_config = {        
    'host': os.getenv('DB_HOST', 'localhost'),
    'user': os.getenv('DB_USER'),
    'password': os.getenv('DB_PASSWORD'),
    'database': os.getenv('DB_NAME'),
}

if not all(db_config.values()):
    st.error("Missing database settings. Copy .env.example to .env and fill it in.")
    st.stop()

def run_mysql_query(sql_query, params=None):
    """Execute a database query and safely close resources."""

    conn = None
    cursor = None

    try:
        # Open MySQL connection
        conn = mysql.connector.connect(
            **db_config,
            connection_timeout=10
        )

        cursor = conn.cursor()

        # Execute query with optional parameters
        cursor.execute(
            sql_query,
            params if params is not None else ()
        )

        # Get column names
        columns = (
            [desc[0] for desc in cursor.description]
            if cursor.description else []
        )

        # Fetch query results
        results = (
            cursor.fetchall()
            if cursor.with_rows else []
        )

        return {
            "status": "success",
            "data": results,
            "columns": columns
        }

    except mysql.connector.Error as e:
        print(f"MySQL error: {e}")

        return {
            "status": "error",
            "message": "Database query failed.",
            "columns": []
        }

    finally:
        # Always close cursor and connection
        if cursor is not None:
            cursor.close()

        if conn is not None and conn.is_connected():
            conn.close()
        
# Use a separate restricted connection for AI-generated SQL questions.
# The original db_config and run_mysql_query remain unchanged for forecasts.
# =====================================================================
# SETTING UP A SAFE READ-ONLY CONNECTION FOR AI-GENERATED SQL
# =====================================================================

sql_reader_config = {
    "host": os.getenv("DB_HOST", "localhost"),
    "user": os.getenv("SQL_READER_USER"),
    "password": os.getenv("SQL_READER_PASSWORD"),
    "database": os.getenv("DB_NAME")
}


def run_ai_readonly_query(sql_query):
    """Run a validated SELECT using a dedicated restricted MySQL account."""
    if not sql_reader_config["user"] or not sql_reader_config["password"]:
        return {"status": "error", "message": "Configure SQL_READER_USER and SQL_READER_PASSWORD in .env."}
    if sql_reader_config["user"].lower() == "root":
        return {"status": "error", "message": "Use a dedicated read-only account for AI-generated SQL."}

    conn = None
    cursor = None
    try:
        conn = mysql.connector.connect(**sql_reader_config, connection_timeout=10)
        cursor = conn.cursor()
        cursor.execute("SET SESSION MAX_EXECUTION_TIME=5000")
        cursor.execute(sql_query)
        if not cursor.with_rows:
            raise ValueError("Only read-only result sets are supported")
        columns = [col[0] for col in cursor.description]
        rows = cursor.fetchmany(201)
        return {"status": "success", "columns": columns,
                "data": rows[:200], "truncated": len(rows) > 200}
    except (mysql.connector.Error, ValueError) as e:
        print(f"SQL reader error: {e}")
        return {"status": "error", "message": "SQL query failed; check the query or read-only permissions."}
    finally:
        if cursor is not None:
            try:
                cursor.close()
            except Exception:
                pass
        if conn is not None:
            try:
                conn.close()
            except Exception:
                pass


# =====================================================================
# 3. SETTING UP THE AI TEXT-SEARCH MEMORY BANK (RAG)
# =====================================================================

import hashlib

# Keep the RAG storage folder beside sales.py
chroma_client = chromadb.PersistentClient(
    path=str(BASE_DIR / "rag_storage")
)

collection = chroma_client.get_or_create_collection(
    name="galaxy_cafe_context"
)


def seed_rag_knowledge():
    """Update ChromaDB when the cheat sheet changes."""

    # CHEATSHEET_PATH in .env is optional; relative paths use this script's folder
    configured_path = os.getenv("CHEATSHEET_PATH", "database_cheat_sheet.txt")
    file_path = Path(configured_path)
    if not file_path.is_absolute():
        file_path = BASE_DIR / file_path

    try:
        with open(file_path, "r", encoding="utf-8") as file:
            content = file.read()

    except FileNotFoundError:
        st.error(f"Database cheat sheet not found at: {file_path}")
        return False

    file_hash = hashlib.sha256(
        content.encode("utf-8")
    ).hexdigest()

    # Check the previously indexed version
    stored_hash = (
        (collection.metadata or {}).get("schema_hash")
    )

    if stored_hash == file_hash and collection.count() > 0:
        return True

    knowledge_base = [
        line.strip()
        for line in content.splitlines()
        if line.strip()
        and not line.strip().startswith("# ==")
    ]

    if not knowledge_base:
        st.error("Database cheat sheet is empty.")
        return False

    # Create stable document identifiers
    document_ids = [
        f"doc_table_{i}"
        for i in range(len(knowledge_base))
    ]

    # Insert or update knowledge documents
    collection.upsert(
        ids=document_ids,
        documents=knowledge_base
    )

    # Remove obsolete documents
    existing_ids = collection.get()["ids"]

    obsolete_ids = [
        doc_id
        for doc_id in existing_ids
        if doc_id not in document_ids
    ]

    if obsolete_ids:
        collection.delete(ids=obsolete_ids)

    # Save the current file version in metadata
    metadata = dict(collection.metadata or {})
    metadata["schema_hash"] = file_hash

    collection.modify(metadata=metadata)

    return True


# Initialize RAG
with st.spinner("Checking AI knowledge bank..."):
    st.session_state.rag_seeded = seed_rag_knowledge()


def retrieve_rag_context(user_query):
    """Retrieve relevant database schema information."""

    count = collection.count()

    if count == 0:
        return "No database schema available."

    results = collection.query(
        query_texts=[user_query],
        n_results=min(10, count)
    )

    documents = results.get("documents", [[]])

    return "\n".join(documents[0])

# =====================================================================
# 4. SMART MATH ENGINES (MACHINE LEARNING EXPERIMENTS)
# =====================================================================


def get_cafe_sales_dates():
    """Retrieve dates with paid transactions (proxy for open days, not a verified calendar)."""

    query = """
        SELECT DISTINCT
            DATE(INVOICE_DATE) AS sales_date
        FROM sales_invoice
        WHERE order_fulfilled = 'paid'
        ORDER BY sales_date ASC;
    """

    result = run_mysql_query(query)

    if result["status"] != "success" or not result["data"]:
        return None

    dates = pd.to_datetime(
        [row[0] for row in result["data"]]
    )

    return pd.DatetimeIndex(dates)


def prepare_daily_item_sales(raw_rows):
    """Prepare daily demand using observed cafe sales dates."""

    df = pd.DataFrame(
        raw_rows,
        columns=["sales_date", "units_sold"]
    )

    if df.empty:
        return None

    df["sales_date"] = pd.to_datetime(
        df["sales_date"],
        errors="coerce"
    )

    df["units_sold"] = pd.to_numeric(
        df["units_sold"],
        errors="coerce"
    )

    df = df.dropna(subset=["sales_date", "units_sold"])

    if df.empty:
        return None

    # Combine beverage sales by date
    df = df.groupby(
        "sales_date"
    )["units_sold"].sum()

    # Retrieve dates when the cafe recorded transactions
    cafe_dates = get_cafe_sales_dates()

    if cafe_dates is None or len(cafe_dates) == 0:
        return None

    # Add zero units on cafe transaction dates
    df = (
        df.reindex(cafe_dates, fill_value=0)
        .rename_axis("sales_date")
        .reset_index()
    )

    # Calculate actual elapsed calendar days
    start_date = df["sales_date"].min()

    df["day_index"] = (
        df["sales_date"] - start_date
    ).dt.days

    # MySQL weekday numbering
    df["day_of_week"] = (
        (df["sales_date"].dt.dayofweek + 1) % 7
    ) + 1

    return df

def prepare_daily_revenue(raw_rows):
    """Prepare daily revenue data with continuous calendar dates."""

    df = pd.DataFrame(
        raw_rows,
        columns=["sales_date", "daily_revenue"]
    )

    if df.empty:
        return None

    df["sales_date"] = pd.to_datetime(df["sales_date"])

    df["daily_revenue"] = pd.to_numeric(
        df["daily_revenue"]
    )

    all_dates = pd.date_range(
        start=df["sales_date"].min(),
        end=df["sales_date"].max(),
        freq="D"
    )

    df = (
        df.groupby("sales_date")["daily_revenue"]
        .sum()
        .reindex(all_dates, fill_value=0)
        .rename_axis("sales_date")
        .reset_index()
    )

    return df


def run_galaxy_cafe_ml_forecast():
    """Predicts next-day revenue using historical daily sales."""

    # 1. Retrieve historical revenue from paid invoices
    query = """
        SELECT
            DATE(si.INVOICE_DATE) AS sales_date,
            COALESCE(
                SUM(sd.QUANTITY * sd.SELLING_PRICE),
                0
            ) AS daily_revenue
        FROM sales_invoice si
        LEFT JOIN sales_details sd
            ON si.SIID = sd.SIID
        WHERE si.order_fulfilled = 'paid'
        GROUP BY DATE(si.INVOICE_DATE)
        ORDER BY sales_date ASC;
    """

    db_result = run_mysql_query(query)

    # 2. Check if the database returned valid data
    if db_result["status"] != "success" or not db_result["data"]:
        return {
            "target_period": "No sales history",
            "predicted_revenue": None
        }

    
    # 3. Prepare continuous daily revenue history
    df = prepare_daily_revenue(db_result["data"])

    # 4. Check that enough historical data exists
    if df is None or len(df) < 7:
        return {
            "target_period": "Insufficient sales history",
            "predicted_revenue": None
        }

    # 5. Use actual elapsed calendar days
    start_date = df["sales_date"].min()

    df["day_index"] = (
        df["sales_date"] - start_date
    ).dt.days

    # 6. Prepare training data
    X = df[["day_index"]].values
    y = df["daily_revenue"].astype(float).values

    # 7. Train Linear Regression
    model = LinearRegression()
    model.fit(X, y)

    # 8. Predict the day after historical data
    last_date = df["sales_date"].max()
    next_date = last_date + timedelta(days=1)

    next_day_index = (
        next_date - start_date
    ).days

    # 9. Predict revenue
    prediction = model.predict(
        [[next_day_index]]
    )[0]

    # 10. Prevent negative revenue predictions
    prediction = max(0, float(prediction))

    # 11. Return the prediction
    return {
        "target_period": (
            f"Next Day After Historical Data "
            f"({next_date.strftime('%B %d, %Y')})"
        ),
        "predicted_revenue": round(prediction, 2)
    }

def run_item_demand_forecast(item_name):
    """Predict item demand for the day after the last recorded sale."""

    query = """
        SELECT
            DATE(si.INVOICE_DATE) AS sales_date,
            COALESCE(SUM(sd.QUANTITY), 0) AS units_sold
        FROM sales_invoice si
        JOIN sales_details sd ON si.SIID = sd.SIID
        JOIN menu_variant mv ON sd.MVID = mv.MVID
        JOIN beverage b ON mv.BID = b.BID
        WHERE LOWER(b.B_NAME) LIKE %s
          AND si.order_fulfilled = 'paid'
        GROUP BY DATE(si.INVOICE_DATE)
        ORDER BY sales_date ASC;
    """

    db_result = run_mysql_query(
        query, (f"%{item_name.lower()}%",)
    )

    if db_result["status"] != "success" or not db_result["data"]:
        return {
            "target_period": "No matching sales history",
            "predicted_quantity": None
        }

    df = prepare_daily_item_sales(db_result["data"])

    if df is None or len(df) < 7:
        return {
            "target_period": "Insufficient sales history",
            "predicted_quantity": None
        }

    X = df[["day_index"]].values
    y = df["units_sold"].astype(float).values

    model = LinearRegression()
    model.fit(X, y)

    last_date = df["sales_date"].max()
    next_date = last_date + timedelta(days=1)

    next_day_index = int(df["day_index"].max()) + 1

    prediction = model.predict([[next_day_index]])[0]

    return {
        "target_period": (
            f"Next Day After Historical Data ({next_date.strftime('%B %d, %Y')})"
        ),
        "predicted_quantity": round(
            max(0, float(prediction)), 1
        )
    }


def run_multi_day_item_forecast(item_name, horizon_days=10):
    """Predict multiple days using regression and weekday scaling."""

    if type(horizon_days) is not int or not 1 <= horizon_days <= 30:
        return None

    query = """
        SELECT
            DATE(si.INVOICE_DATE) AS sales_date,
            COALESCE(SUM(sd.QUANTITY), 0) AS units_sold
        FROM sales_invoice si
        JOIN sales_details sd ON si.SIID = sd.SIID
        JOIN menu_variant mv ON sd.MVID = mv.MVID
        JOIN beverage b ON mv.BID = b.BID
        WHERE LOWER(b.B_NAME) LIKE %s
          AND si.order_fulfilled = 'paid'
        GROUP BY DATE(si.INVOICE_DATE)
        ORDER BY sales_date ASC;
    """

    db_result = run_mysql_query(
        query, (f"%{item_name.lower()}%",)
    )

    if db_result["status"] != "success" or not db_result["data"]:
        return None

    df = prepare_daily_item_sales(db_result["data"])

    if df is None or len(df) < 14:
        return None

    X = df[["day_index"]].values
    y = df["units_sold"].astype(float).values

    model = LinearRegression()
    model.fit(X, y)

    overall_avg = df["units_sold"].mean()

    if overall_avg <= 0:
        return None

    day_weights = (
        df.groupby("day_of_week")["units_sold"].mean()
        / overall_avg
    )

    last_date = df["sales_date"].max()
    last_index = int(df["day_index"].max())

    future_records = []

    for i in range(1, horizon_days + 1):
        future_date = last_date + timedelta(days=i)
        future_index = last_index + i

        day_num = future_date.isoweekday() % 7 + 1

        base_pred = model.predict([[future_index]])[0]
        weight = day_weights.get(day_num, 1.0)

        final_prediction = max(
            0, float(base_pred * weight)
        )

        future_records.append({
            "Date": future_date.strftime("%Y-%m-%d"),
            "Day": future_date.strftime("%A"),
            "Linear Regression Demand": round(
                final_prediction, 1
            )
        })

    return pd.DataFrame(future_records)


def run_prophet_item_forecast(item_name, horizon_days=10):
    """Forecast item demand with Prophet using the cafe's historical sales dates."""

    # Reject invalid horizons before asking the forecasting model to work
    if type(horizon_days) is not int or not 1 <= horizon_days <= 30:
        print("PROPHET: Forecast duration must be between 1 and 30 days.")
        return None

    # Retrieve the quantity of this beverage sold on each recorded date
    query = """
        SELECT
            DATE(si.INVOICE_DATE) AS sales_date,
            COALESCE(SUM(sd.QUANTITY), 0) AS units_sold
        FROM sales_invoice si
        JOIN sales_details sd ON si.SIID = sd.SIID
        JOIN menu_variant mv ON sd.MVID = mv.MVID
        JOIN beverage b ON mv.BID = b.BID
        WHERE LOWER(b.B_NAME) LIKE %s
          AND si.order_fulfilled = 'paid'
        GROUP BY DATE(si.INVOICE_DATE)
        ORDER BY sales_date ASC;
    """

    # Use a parameter for the requested beverage instead of inserting raw SQL
    db_result = run_mysql_query(query, (f"%{item_name.lower()}%",))

    if db_result["status"] != "success" or not db_result["data"]:
        print(f"PROPHET: No recorded paid sales for {item_name}.")
        return None

    # Build daily demand on dates with cafe transactions; zero means
    # no sales of this beverage on those dates, assuming it was available
    df = prepare_daily_item_sales(db_result["data"])

    if df is None or df.empty:
        print(f"PROPHET: Could not prepare daily sales for {item_name}.")
        return None

    # Rename the columns to the exact names required by Prophet
    df = df.rename(columns={"sales_date": "ds", "units_sold": "y"})
    df["ds"] = pd.to_datetime(df["ds"], errors="coerce")
    df["y"] = pd.to_numeric(df["y"], errors="coerce")
    df = df.dropna(subset=["ds", "y"])
    df = df[["ds", "y"]].sort_values("ds").drop_duplicates("ds")

    # A shorter minimum than the old 28-observation rule lets us TRY
    # Prophet on this small historical demonstration dataset.
    # It does not mean the resulting forecast has been validated.
    history_days = (df["ds"].max() - df["ds"].min()).days if not df.empty else 0
    if len(df) < 7 or history_days < 7:
        print(
            f"PROPHET: Not enough historical coverage for {item_name}: "
            f"{len(df)} observations across {history_days} days."
        )
        return None

    # Prophet needs meaningful changes in demand to learn a trend.
    if df["y"].nunique() < 2:
        print(f"PROPHET: Demand is constant for {item_name}; no useful pattern to fit.")
        return None

    # Weekly seasonality needs several weeks of observations to be useful.
    # Disable it when the history is too short or sparse.
    use_weekly = len(df) >= 21 and history_days >= 21

    try:
        model = Prophet(
            yearly_seasonality=False,
            weekly_seasonality=use_weekly,
            daily_seasonality=False,
            uncertainty_samples=0
        )

        # Fit using actual recorded dates rather than invented transactions
        model.fit(df)

        # Forecast the calendar days immediately after the last recorded date
        future_df = model.make_future_dataframe(
            periods=horizon_days,
            freq="D",
            include_history=False
        )
        forecast = model.predict(future_df)

    except Exception as e:
        # Keep Linear Regression available even if Prophet cannot fit
        print(f"PROPHET: Model failed for {item_name}: {type(e).__name__}: {e}")
        return None

    # Format the results in the same structure as the original Streamlit chart
    future_records = []
    for _, row in forecast.iterrows():
        predicted = float(row["yhat"])
        if not np.isfinite(predicted):
            print(f"PROPHET: Non-finite prediction for {item_name}.")
            return None

        future_records.append({
            "Date": row["ds"].strftime("%Y-%m-%d"),
            "Day": row["ds"].strftime("%A"),
            "Prophet Model Demand": round(max(0, predicted), 1)
        })

    print(
        f"PROPHET: Forecast generated for {item_name} using "
        f"{len(df)} observations (weekly seasonality={use_weekly})."
    )
    return pd.DataFrame(future_records)


def run_all_beverages_sales_summary():
    """Generates a complete scoreboard showing total units and money earned for every drink item."""
    # An aggregate search command that calculates total units and money made for every single menu item
    
    query = """
        SELECT
            b.B_NAME AS beverage_name,
            COALESCE(SUM(sd.QUANTITY), 0) AS total_units_sold,
            COALESCE(
                SUM(sd.QUANTITY * sd.SELLING_PRICE),
                0
            ) AS total_revenue_generated
        FROM beverage b
        LEFT JOIN menu_variant mv
            ON b.BID = mv.BID
        LEFT JOIN sales_details sd
            ON mv.MVID = sd.MVID
            AND sd.SIID IN (
                SELECT SIID
                FROM sales_invoice
                WHERE order_fulfilled = 'paid'
            )
        GROUP BY b.BID, b.B_NAME
        ORDER BY total_revenue_generated DESC;
    """

    # Run our comprehensive multi-table total scoreboard search
    db_result = run_mysql_query(query)
    
    # If the scoreboard data was pulled out safely
    if db_result["status"] == "success" and db_result["data"]:
        # Build an organized spreadsheet summary grid table with clean column labels
        df = pd.DataFrame(db_result["data"], columns=['Beverage Name', 'Total Units Sold', 'Total Revenue ($)'])
        # Round the final calculated money totals down to simple cents decimals
        df['Total Revenue ($)'] = df['Total Revenue ($)'].round(2)
        # Send our clean summary dashboard spreadsheet back to the program
        return df
    # Send back nothing if our cafe sales log is empty
    return None

# =====================================================================
# 5. DISPLAYING OLD CONVERSATION HISTORY ON SCREEN
# =====================================================================
# Loop through every message we saved inside our ongoing session chat history memory
for message in st.session_state.messages:
    # Open up a message bubble matching who spoke (the User profile or the Assistant AI)
    with st.chat_message(message["role"]):
        # Put the written chat text on the screen
        st.markdown(message["content"])
        # Check if this old message has a saved spreadsheet table hidden inside it
        if "table_data" in message:
            # Check if this message requires showing an interactive bar chart layout graph
            if "is_bar" in message and message["is_bar"]:
                # Re-draw our beautiful vertical bar chart graph right inside the chat window
                st.bar_chart(data=message["table_data"], x="Beverage Name", y="Total Revenue ($)")
            # Check if this message instead requires an interactive line chart history graph
            elif "is_line" in message and message["is_line"]:
                # Re-draw our chronological day-by-day line graph tracking our guesses
                st.line_chart(data=message["table_data"], x="Date", y="Linear Regression Demand")
            # Re-draw the raw spreadsheet data table right under the graph lines
            st.dataframe(data=message["table_data"], use_container_width=True)
            
        # Check if there is a secondary Facebook Prophet timeline prediction table saved here
        if "table_data_prophet" in message:
            # Re-draw the second line graph showing our advanced AI model guesses
            st.line_chart(data=message["table_data_prophet"], x="Date", y="Prophet Model Demand")
            # Re-draw the raw spreadsheet data numbers matching that advanced graph line
            st.dataframe(data=message["table_data_prophet"], use_container_width=True)


# =====================================================================
# 6. CAPTURING CHAT INPUTS & WORKING OUT USER INTENT
# =====================================================================

import re

# Capture the user's question
if user_question := st.chat_input("Ask something here..."):

    # Display the user's question
    with st.chat_message("user"):
        st.markdown(user_question)

    # Save user message
    st.session_state.messages.append({
        "role": "user",
        "content": user_question
    })

    # Display assistant response
    with st.chat_message("assistant"):
        with st.spinner("Thinking..."):

            bot_reply = ""

            # =========================================================
            # STEP 1: CLASSIFY THE USER'S QUESTION
            # =========================================================

            routing_prompt = f"""
You are an intent classifier for a cafe analytics chatbot.

Classify the user's request into one of these routes:

ML:
- Sales and demand forecasting
- Predictions
- Beverage performance charts

SQL:
- Questions about existing database records
- Historical sales and customer information
- Database lookups

Return ONLY a valid JSON object containing:
- route: "ML" or "SQL"
- item: "ALL_ITEMS", "REVENUE", or a beverage name
- days: integer
- type: "MULTI" or "SINGLE"

Rules:
1. Forecasts and predictions use route "ML".
2. Requests for more than one day use "MULTI".
3. Requests for one day use "SINGLE".
4. Extract the number of requested days.
5. If no duration is specified, use 1 day.
6. Total cafe revenue forecasts use item "REVENUE".
7. All-beverage performance charts use item "ALL_ITEMS".
8. Otherwise, extract the beverage name.
9. Do not invent beverage names.
10. Return JSON only.

Examples:

User: Predict Matcha Latte demand for the next 10 days.
Output:
{{"route":"ML","item":"Matcha Latte","days":10,"type":"MULTI"}}

User: How many Matcha Lattes will sell tomorrow?
Output:
{{"route":"ML","item":"Matcha Latte","days":1,"type":"SINGLE"}}

User: Predict tomorrow's cafe revenue.
Output:
{{"route":"ML","item":"REVENUE","days":1,"type":"SINGLE"}}

User: Show sales performance for all beverages.
Output:
{{"route":"ML","item":"ALL_ITEMS","days":1,"type":"SINGLE"}}

User: What beverages are available?
Output:
{{"route":"SQL","item":"ALL_ITEMS","days":1,"type":"SINGLE"}}

User request:
{user_question}
"""

            # =========================================================
            # STEP 2: GET AND VALIDATE AI ROUTING RESPONSE
            # =========================================================

            # First, recognize clear forecast requests directly from the user's words.
            # This prevents Llama from accidentally treating a 10-day forecast as SINGLE.
            # For less obvious questions, we still use Llama 3.1 as the classifier.
            parsed_meta = None
            question_lower = user_question.lower()

            # Find a duration anywhere in the question, such as "10 days" or "14-day".
            duration_match = re.search(r"\b(\d+)\s*[- ]\s*days?\b", question_lower)
            requested_days = int(duration_match.group(1)) if duration_match else 1
            if "tomorrow" in question_lower or "next day" in question_lower:
                requested_days = 1

            # Get real beverage names from MySQL, rather than inventing a drink name.
            beverage_result = run_mysql_query("SELECT B_NAME FROM beverage ORDER BY B_NAME")
            beverage_names = (
                [row[0] for row in beverage_result["data"]]
                if beverage_result["status"] == "success" else []
            )
            matching_names = [
                name for name in beverage_names
                if name.lower() in question_lower
            ]
            matching_names.sort(key=len, reverse=True)
            matched_beverage = matching_names[0] if matching_names else None

            forecast_words = ("forecast", "predict", "prediction", "demand", "will sell")
            is_forecast = any(word in question_lower for word in forecast_words)
            is_all_items = (
                ("all beverages" in question_lower or "every beverage" in question_lower)
                and any(word in question_lower for word in ("sales", "performance", "chart", "compare"))
            )

            if is_all_items:
                parsed_meta = {"route": "ML", "item": "ALL_ITEMS", "days": 1, "type": "SINGLE"}
            elif is_forecast and matched_beverage:
                parsed_meta = {
                    "route": "ML", "item": matched_beverage,
                    "days": requested_days,
                    "type": "MULTI" if requested_days > 1 else "SINGLE"
                }
            elif is_forecast and any(word in question_lower for word in ("revenue", "total sales", "store sales")):
                parsed_meta = {
                    "route": "ML", "item": "REVENUE",
                    "days": requested_days,
                    "type": "MULTI" if requested_days > 1 else "SINGLE"
                }

            # If direct routing did not recognize the question, ask Llama for JSON.
            if parsed_meta is None:
                try:
                    route_response = ollama.generate(
                        model="llama3.1",
                        prompt=routing_prompt,
                        format="json",
                        options={"temperature": 0}
                    )
                    clean_response = route_response["response"].strip()
                    parsed_meta = json.loads(clean_response)
                    if not isinstance(parsed_meta, dict):
                        raise ValueError("Expected a JSON object")
                    if str(parsed_meta.get("route", "")).upper() not in ("ML", "SQL"):
                        raise ValueError("Unknown route")
                    parsed_meta["route"] = str(parsed_meta["route"]).upper()
                    item = parsed_meta.get("item", "")
                    if not isinstance(item, str) or not item.strip():
                        raise ValueError("Missing item")
                    parsed_meta["item"] = item.strip()
                    if parsed_meta["route"] == "ML":
                        # Match model-generated beverage names against the actual menu.
                        exact = next((n for n in beverage_names if n.lower() == item.strip().lower()), None)
                        if exact:
                            parsed_meta["item"] = exact
                        elif item.upper() not in ("ALL_ITEMS", "REVENUE"):
                            raise ValueError("Beverage not found in menu")
                except (ValueError, TypeError, KeyError, json.JSONDecodeError) as e:
                    # Don't reject the entire chat just because Llama formatted JSON badly.
                    print(f"Routing fallback: {e}")
                    parsed_meta = {"route": "SQL", "item": "ALL_ITEMS", "days": 1, "type": "SINGLE"}
                except Exception as e:
                    # Ollama may be offline; SQL questions can still use the database.
                    print(f"Ollama routing unavailable: {e}")
                    parsed_meta = {"route": "SQL", "item": "ALL_ITEMS", "days": 1, "type": "SINGLE"}

            # Apply the actual number of days from the question whenever it is explicit.
            if parsed_meta["route"] == "ML":
                parsed_meta["days"] = requested_days if duration_match else int(parsed_meta.get("days", 1))
                if not 1 <= parsed_meta["days"] <= 30:
                    bot_reply = "Please choose a forecast between 1 and 30 days."
                    st.warning(bot_reply)
                    st.session_state.messages.append({"role": "assistant", "content": bot_reply})
                    st.stop()
                parsed_meta["type"] = "MULTI" if parsed_meta["days"] > 1 else "SINGLE"

            # Uncomment these lines when testing the router:
            # st.write("DEBUG - AI Routing Decision:")
            # st.json(parsed_meta)

            # =========================================================
            # PATHWAY A: MACHINE LEARNING FORECASTS
            # =========================================================

            if parsed_meta["route"] == "ML":

                # -----------------------------------------------------
                # CONDITION 1: ALL BEVERAGES SALES PERFORMANCE
                # -----------------------------------------------------

                if parsed_meta["item"] == "ALL_ITEMS":

                    summary_df = run_all_beverages_sales_summary()

                    if summary_df is not None:

                        st.markdown(
                            "### General Sales Breakdown "
                            "(Every Beverage)"
                        )

                        st.bar_chart(
                            data=summary_df,
                            x="Beverage Name",
                            y="Total Revenue ($)"
                        )

                        st.dataframe(
                            summary_df,
                            use_container_width=True
                        )

                        bot_reply = (
                            "Here is the sales performance comparison "
                            "for all available beverages."
                        )

                        st.session_state.messages.append({
                            "role": "assistant",
                            "content": bot_reply,
                            "table_data": summary_df,
                            "is_bar": True
                        })

                    else:
                        bot_reply = (
                            "No beverage sales data is available."
                        )

                        st.warning(bot_reply)

                        st.session_state.messages.append({
                            "role": "assistant",
                            "content": bot_reply
                        })

                # -----------------------------------------------------
                # CONDITION 2: MULTI-DAY ITEM DEMAND FORECAST
                # -----------------------------------------------------

                elif (
                    parsed_meta["type"] == "MULTI"
                    and parsed_meta["item"] != "REVENUE"
                ):

                    item_name = parsed_meta["item"]
                    horizon_days = parsed_meta["days"]

                    # Run Linear Regression
                    forecast_df_lr = run_multi_day_item_forecast(
                        item_name,
                        horizon_days=horizon_days
                    )

                    # Run Prophet
                    forecast_df_prophet = run_prophet_item_forecast(
                        item_name,
                        horizon_days=horizon_days
                    )

                    if (
                        forecast_df_lr is not None
                        or forecast_df_prophet is not None
                    ):

                        st.markdown(
                            f"## Historical Demand Forecast: "
                            f"{item_name.title()} "
                            f"({horizon_days} Days)"
                        )

                        saved_message = {
                            "role": "assistant",
                            "content": (
                                f"Historical demand forecasts for "
                                f"{item_name}."
                            )
                        }

                        # Linear Regression results
                        if forecast_df_lr is not None:

                            st.markdown(
                                "### Linear Regression Forecast"
                            )

                            st.line_chart(
                                data=forecast_df_lr,
                                x="Date",
                                y="Linear Regression Demand"
                            )

                            st.dataframe(
                                forecast_df_lr,
                                use_container_width=True
                            )

                            saved_message["table_data"] = (
                                forecast_df_lr
                            )
                            saved_message["is_line"] = True

                        else:
                            st.warning(
                                "Linear Regression forecast unavailable."
                            )

                        # Prophet results
                        if forecast_df_prophet is not None:

                            st.markdown("### Prophet Forecast")

                            st.line_chart(
                                data=forecast_df_prophet,
                                x="Date",
                                y="Prophet Model Demand"
                            )

                            st.dataframe(
                                forecast_df_prophet,
                                use_container_width=True
                            )

                            saved_message["table_data_prophet"] = (
                                forecast_df_prophet
                            )

                        else:
                            st.warning(
                                "Prophet forecast unavailable."
                            )

                        # Save available forecasts
                        st.session_state.messages.append(
                            saved_message
                        )

                    else:
                        bot_reply = (
                            f"No forecast available for '{item_name}'. "
                            "Check the historical sales data."
                        )

                        st.warning(bot_reply)

                        st.session_state.messages.append({
                            "role": "assistant",
                            "content": bot_reply
                        })

                # -----------------------------------------------------
                # CONDITION 3: SINGLE-DAY FORECASTS
                # -----------------------------------------------------

                elif parsed_meta["type"] == "SINGLE":

                    item_name = parsed_meta["item"]

                    if item_name == "REVENUE":

                        ml_results = run_galaxy_cafe_ml_forecast()

                        if ml_results["predicted_revenue"] is None:
                            bot_reply = (
                                "Unable to predict revenue: "
                                f"{ml_results['target_period']}."
                            )

                        else:
                            ml_summary_prompt = (
                                f"The user asked: {user_question}. "
                                f"Historical linear regression predicts "
                                f"revenue of "
                                f"{ml_results['predicted_revenue']} "
                                f"for {ml_results['target_period']}. "
                                "Summarize accurately and briefly. "
                                "Do not change the prediction or date."
                            )

                    else:
                        ml_results = run_item_demand_forecast(
                            item_name
                        )

                        if ml_results["predicted_quantity"] is None:
                            bot_reply = (
                                "Unable to predict demand: "
                                f"{ml_results['target_period']}."
                            )

                        else:
                            ml_summary_prompt = (
                                f"The user asked: {user_question}. "
                                f"Historical linear regression predicts "
                                f"{ml_results['predicted_quantity']} "
                                f"units of {item_name} for "
                                f"{ml_results['target_period']}. "
                                "Summarize accurately and briefly. "
                                "Do not change the prediction or date."
                            )

                    # Generate explanation only for valid predictions
                    if not bot_reply:

                        response = ollama.generate(
                            model="llama3.1",
                            prompt=ml_summary_prompt
                        )

                        bot_reply = response["response"]

                    st.markdown(bot_reply)

                    st.session_state.messages.append({
                        "role": "assistant",
                        "content": bot_reply
                    })

                else:
                    bot_reply = (
                        "Multi-day revenue forecasting is not "
                        "implemented yet. Try a single-day "
                        "revenue forecast."
                    )

                    st.warning(bot_reply)

                    st.session_state.messages.append({
                        "role": "assistant",
                        "content": bot_reply
                    })

            # =========================================================
            # PATHWAY B: NORMAL DATABASE QUESTIONS
            # =========================================================
            else:
                # Retrieve the relevant database table descriptions from ChromaDB
                rag_context = retrieve_rag_context(user_question)

                # Read the complete schema as well, so multi-table joins are not
                # missing important relationships due to RAG's top-10 limit.
                cheat_path = Path(os.getenv("CHEATSHEET_PATH", "database_cheat_sheet.txt"))
                if not cheat_path.is_absolute():
                    cheat_path = BASE_DIR / cheat_path
                full_schema = cheat_path.read_text(encoding="utf-8") if cheat_path.is_file() else rag_context

                # Explain the database structure to our local Llama 3.1 model.
                # Never request personal contact information or password fields.
                sql_generation_prompt = f"""
You are a MySQL expert for the Galaxy Cafe database.
Generate exactly ONE read-only SELECT statement to answer the user's question.
Return raw SQL only; no markdown or explanations.

Complete database schema and relationships:
{full_schema}

Most relevant RAG context:
{rag_context}

Rules:
1. Use ONLY real tables and columns from the schema.
2. Historical sales use sales_details.QUANTITY * sales_details.SELLING_PRICE.
3. For completed sales, filter sales_invoice.order_fulfilled = 'paid'.
4. Join beverage -> menu_variant -> sales_details -> sales_invoice using BID, MVID, SIID.
5. For never-ordered drinks, use NOT EXISTS and paid invoices.
6. For customer lists, select customer.CID and customer.C_NAME only.
7. Never select PASSWORD_, EMAIL, PHONE_NUMBER, DOB, SALARY, or profile_pic.
8. Do not use SELECT *.
9. Use MySQL syntax. Dates must use YYYY-MM-DD.
10. If the user supplies a DD/MM/YYYY date, interpret it as day/month/year.
11. Do not invent values or tables. Return only the SELECT statement.

Question: {user_question}
"""

                try:
                    # Ask Ollama to translate the question into a SQL query
                    sql_response = ollama.generate(
                        model="llama3.1", prompt=sql_generation_prompt,
                        options={"temperature": 0}
                    )
                    generated_sql = (
                        sql_response["response"].strip()
                        .replace("```sql", "").replace("```", "").strip()
                    )

                    # Validate one SELECT statement and block sensitive fields.
                    statements = sqlparse.parse(generated_sql)
                    sql_is_safe = (
                        len(statements) == 1
                        and statements[0].get_type() == "SELECT"
                        and ";" not in generated_sql.rstrip().rstrip(";")
                        and not re.search(
                            r"\b(INTO\s+OUTFILE|INTO\s+DUMPFILE|FOR\s+UPDATE|"
                            r"LOAD_FILE|SLEEP|BENCHMARK|INFORMATION_SCHEMA|"
                            r"PASSWORD_|PHONE_NUMBER|EMAIL|SALARY|DOB|profile_pic|"
                            r"UPDATE|DELETE|INSERT|DROP|ALTER|CREATE|GRANT|REVOKE)\b",
                            generated_sql, re.IGNORECASE
                        )
                        and not re.search(r"\bSELECT\s+\*", generated_sql, re.IGNORECASE)
                    )

                    if not sql_is_safe:
                        bot_reply = "The AI generated an unsupported SQL query. Please rephrase your question."
                        st.warning(bot_reply)
                    else:
                        # Execute using the separate restricted account, not root
                        db_result = run_ai_readonly_query(generated_sql)
                        if db_result["status"] != "success":
                            bot_reply = db_result["message"]
                            st.warning(bot_reply)
                        elif not db_result["data"]:
                            bot_reply = "The query ran successfully, but no matching records were found."
                            st.markdown(bot_reply)
                        else:
                            results_df = pd.DataFrame(
                                db_result["data"], columns=db_result["columns"]
                            )
                            st.dataframe(results_df, use_container_width=True)
                            if db_result.get("truncated"):
                                st.caption("Showing the first 200 records only.")

                            # Summarize only the returned data, without inventing rows
                            summary_prompt = (
                                f"Question: {user_question}\n"
                                f"Columns: {db_result['columns']}\n"
                                f"Rows: {db_result['data'][:20]}\n"
                                "Summarize these results accurately and briefly. "
                                "Do not invent facts or claim these are all records."
                            )
                            try:
                                reply = ollama.generate(model="llama3.1", prompt=summary_prompt)
                                bot_reply = reply["response"]
                            except Exception as e:
                                print(f"SQL summary error: {e}")
                                bot_reply = f"Found {len(results_df)} matching records."
                            st.markdown(bot_reply)
                            st.session_state.messages.append({
                                "role": "assistant", "content": bot_reply,
                                "table_data": results_df
                            })

                    # Save text-only SQL responses in chat history
                    if not (sql_is_safe and db_result["status"] == "success" and db_result["data"]):
                        st.session_state.messages.append({
                            "role": "assistant", "content": bot_reply
                        })
                except Exception as e:
                    print(f"SQL chatbot error: {type(e).__name__}: {e}")
                    bot_reply = "I couldn't complete the database question. Check Ollama and the SQL reader connection."
                    st.error(bot_reply)
                    st.session_state.messages.append({
                        "role": "assistant", "content": bot_reply
                    })
