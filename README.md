# Sales Overview Chatbot

## Galaxy Café — AI Sales Chatbot & Forecasting

Sales Overview Chatbot is a local AI-powered application that lets users ask natural-language questions about a MySQL database, view sales results in Streamlit, and generate historical-data-based forecasts. Galaxy Café is the example database. The application uses Python, Streamlit, MySQL, Ollama (Llama 3.1), ChromaDB, scikit-learn Linear Regression, and Prophet.

## Features

- Ask questions such as “What beverages are available?” or “What was ordered on 14/02/2026?”
- Generate and inspect read-only SQL using schema context from `database_cheat_sheet.txt`.
- Display database results as interactive tables and summarize them with Llama 3.1.
- Compare beverage sales in a bar chart.
- Forecast next-day beverage demand and revenue using Linear Regression.
- Forecast 2–30 days of beverage demand with Linear Regression and Prophet, when sufficient historical data is available.

**Limitations:** This is an educational local prototype, not a production-ready database assistant. `sqlparse` helps inspect generated statements, but is not a complete security boundary. The application uses a separate MySQL read-only account for AI-generated SQL. Additional access controls, privacy protections, and testing are necessary before public deployment.

## 1. Prerequisites

Install Python, MySQL Community Server (MySQL Workbench is helpful), and Ollama. Git is optional.

Download the local model:

```bash
ollama pull llama3.1
```

Make sure MySQL and Ollama are running before starting the chatbot.

## 2. Download and organize the project

Clone your repository or download its ZIP. Your local project should contain:

```text
Sales-Overview-Chatbot/
├── sales.py
├── galaxy_cafe.sql
├── database_cheat_sheet.txt
├── requirements.txt
├── README.md
├── .env.example         # Safe template, if provided
├── .gitignore           # Excludes secrets and local files
├── .env                 # Create locally; never commit
└── rag_storage/         # Created automatically by ChromaDB
```

These filenames are recommended for consistency. If your actual application has another name, use that name in the launch command. The code expects `.env` and, by default, `database_cheat_sheet.txt` beside the Python script.

## 3. Import the MySQL database

The `galaxy_cafe.sql` export contains **both table definitions and inserted records**, not just empty tables. The MySQL database/schema created inside the export is named `galaxy_cafe`.

In MySQL Workbench, connect to your server, choose **File → Open SQL Script**, select `galaxy_cafe.sql`, and execute the script. **Back up any existing `galaxy_cafe` database first**: the export includes statements that can replace tables and their data.

Verify the import:

```sql
USE galaxy_cafe;
SHOW TABLES;
DESCRIBE sales_invoice;
DESCRIBE sales_details;
```

The database has 13 tables:

| Table | Purpose | Primary key |
|---|---|---|
| `customer` | Customer accounts | `CID` |
| `employee` | Staff information | `EID` |
| `beverage` | Drink names and descriptions | `BID` |
| `bev_size` | Drink sizes | `SID` |
| `temperature_type` | Hot/iced options | `TID` |
| `menu_variant` | Drink variants and menu prices | `MVID` |
| `ingredient` | Raw ingredients | `IID` |
| `consumable` | Cups and other supplies | `CNID` |
| `recipe_detail` | Recipe ingredients and supplies | `RID` |
| `sales_invoice` | Invoice headers | `SIID` |
| `sales_details` | Purchased line items | `SDID` |
| `payment_type` | Payment methods | `PTID` |
| `sales_payment` | Invoice payments | `SPID` |

Important relationships:

```text
customer.CID          -> sales_invoice.CID
employee.EID          -> sales_invoice.EID
sales_invoice.SIID    -> sales_details.SIID
sales_details.MVID    -> menu_variant.MVID
menu_variant.BID      -> beverage.BID
menu_variant.SID      -> bev_size.SID
menu_variant.TID      -> temperature_type.TID
sales_invoice.SIID    -> sales_payment.SIID
sales_payment.PTID    -> payment_type.PTID
recipe_detail.MVID    -> menu_variant.MVID
recipe_detail.IID     -> ingredient.IID
recipe_detail.CNID    -> consumable.CNID
recipe_detail.EID     -> employee.EID
```

`SIID` links invoices to line items; `SDID` identifies a line item and should not be used as the invoice join key. These identifiers are character IDs (for example, `B001`), not auto-increment numeric IDs.

## 4. Configure a read-only SQL user

AI-generated SQL uses a separate MySQL account called `reader`. Create it using an administrator connection in MySQL Workbench (replace the placeholder with a strong unique password):

```sql
CREATE USER 'reader'@'localhost' IDENTIFIED BY 'CHOOSE_A_STRONG_PASSWORD';
```

For a local demo, grant `SELECT` only on the tables and columns the chatbot needs. For example:

```sql
GRANT SELECT ON galaxy_cafe.beverage TO 'reader'@'localhost';
GRANT SELECT ON galaxy_cafe.menu_variant TO 'reader'@'localhost';
GRANT SELECT ON galaxy_cafe.sales_invoice TO 'reader'@'localhost';
GRANT SELECT ON galaxy_cafe.sales_details TO 'reader'@'localhost';
GRANT SELECT (CID, C_NAME) ON galaxy_cafe.customer TO 'reader'@'localhost';
SHOW GRANTS FOR 'reader'@'localhost';
```

For other questions, grant access to additional approved reporting tables or, preferably, sanitized reporting views. Do **not** give this user administrative or write permissions. If `reader` already exists, check its grants rather than recreating it.

## 5. Configure `.env`

Create a file named `.env` beside `sales.py`. Use your actual local credentials instead of placeholders:

```dotenv
DB_HOST=localhost
DB_USER=YOUR_EXISTING_DATABASE_USER
DB_PASSWORD=YOUR_EXISTING_DATABASE_PASSWORD
DB_NAME=galaxy_cafe
CHEATSHEET_PATH=database_cheat_sheet.txt

SQL_READER_USER=reader
SQL_READER_PASSWORD=YOUR_ACTUAL_READER_PASSWORD
```

The primary connection (`DB_USER`) is used by predefined queries and forecasting functions. The separate `reader` connection is used for AI-generated SQL. Use least-privilege accounts for both wherever possible; avoid `root` for routine application access.

**Never commit `.env` or actual passwords.** Include `.env` in `.gitignore`. If a password has been exposed, rotate it.

## 6. Install Python dependencies

In the project folder, create and activate a virtual environment if desired:

**Windows PowerShell:**

```powershell
py -m venv .venv
.venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
```

**macOS/Linux:**

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
```

Required libraries include `streamlit`, `mysql-connector-python`, `ollama`, `chromadb`, `scikit-learn`, `prophet`, `numpy`, `pandas`, `python-dotenv`, and `sqlparse`.

## 7. How the database cheat sheet connects to the chatbot

`database_cheat_sheet.txt` describes tables, columns, and joins. The Python application reads the file and indexes its text in persistent ChromaDB storage (`rag_storage/`). For SQL questions, it retrieves relevant schema context and supplies it, along with the complete cheat sheet, to Llama 3.1. Llama generates a query; the application checks the query and executes it through the restricted MySQL reader connection. Streamlit then displays results.

```text
User question
  -> ChromaDB / database_cheat_sheet.txt
  -> Llama 3.1 SQL generation
  -> SQLParse and application checks
  -> read-only MySQL connection
  -> Streamlit table and explanation
```

The cheat sheet contains **schema knowledge**, not live sales transactions. MySQL contains the actual records. If you change the database structure, update the cheat sheet to match.

## 8. Machine learning forecasting

- **Linear Regression:** Estimates overall sales trends using elapsed calendar days; multi-day beverage forecasts also apply weekday adjustments.
- **Prophet:** Fits a time-series model and can use weekly seasonality when enough history exists.
- **Forecast dates:** The next date after the latest historical sales record, not necessarily tomorrow in real life.
- **Limitations:** Missing paid transactions do not always mean the café was open with zero demand; stockouts and availability are not explicitly tracked. Neither model is proven more accurate until backtested against held-out historical sales.

## 9. Run the chatbot

Check syntax and launch:

```bash
python -m py_compile sales.py
python -m streamlit run sales.py
```

Streamlit typically opens at `http://localhost:8501`.

Try these questions:

- What beverages are available?
- Who are my customers? (names and IDs only)
- What was ordered on 14/02/2026?
- Which beverages have never been ordered?
- Show sales performance for all beverages.
- Predict Matcha Latte demand for the next day.
- Predict Matcha Latte demand for the next 10 days.
- Forecast Americano demand for the next 7 days.

AI-generated SQL may be incorrect; verify important answers against MySQL.

## 10. Use another database

The SQL chatbot can be adapted to other MySQL databases, but changing only `.env` is **not enough** for the forecasting functions.

1. Create/import the new database.
2. Update `DB_NAME`, credentials, and reader permissions.
3. Rewrite `database_cheat_sheet.txt` with the new schema and join paths.
4. Update café-specific SQL, menu matching, routing examples, and forecasting functions in `sales.py`.
5. Rebuild the local ChromaDB index when changing datasets, and test queries and forecasts with the new schema.

## 11. Troubleshooting

| Problem | What to check |
|---|---|
| Missing database settings | `.env` is beside `sales.py`; placeholders are replaced |
| Access denied for `reader` | Reader password, MySQL user, and `SELECT` grants |
| Unknown database/table | `DB_NAME`, SQL import, and schema names |
| Cheat sheet not found | `CHEATSHEET_PATH` and exact filename |
| Ollama unavailable | Ollama is running and `ollama list` shows `llama3.1` |
| Prophet unavailable | Historical coverage and terminal error messages |
| Generated SQL rejected | Query structure, permissions, and cheat-sheet accuracy |
| ChromaDB issues | Confirm `rag_storage/` is writable and the index matches the cheat sheet |

## 12. Security and privacy

The original SQL export includes customer and employee records, contact details, and password hashes. **Do not publish that export unchanged.** Remove or replace sensitive records with synthetic demo data before sharing it publicly. Review your Git history as well, because removing a file in a later commit does not erase earlier commits.

Keep `.env` private. Use limited MySQL privileges, avoid exposing sensitive columns through reporting access, and add authentication and authorization before public deployment. `sqlparse` is not a complete SQL security validator.

## Conclusion

Sales Overview Chatbot demonstrates how natural-language database querying, retrieval-augmented generation, and machine-learning forecasting can be combined into one local Streamlit application. The Galaxy Café dataset provides a working example, while the architecture can be adapted to other businesses with appropriate schema and code changes.
