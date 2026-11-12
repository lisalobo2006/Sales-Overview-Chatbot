# Cafe-Sales-Overview-Chatbot

☕ Galaxy Café — AI Sales Chatbot & Forecasting
This Galaxy cafe contains my data on the Cafe information. The user can create the same MYSQL as shown below for thier own cafe.
Ask questions about café sales in plain English, see SQL results as tables and charts, and forecast revenue or beverage demand. Built with Python + Streamlit + MySQL + Ollama (Llama 3.1) + ChromaDB + scikit-learn + Prophet.
New here? You do not need to know SQL to ask questions, but you do need to create and populate a MySQL database first. This repository includes a starter schema (galaxy_cafe_schema.sql). The schema creates empty tables; it does not contain the author's private business records.

What it can do
- Turn a question such as “What beverages are available?” into a MySQL query using a database schema cheat sheet.
- Show SQL results in a Streamlit table and summarize them using a local Llama 3.1 model.
- Compare beverage sales with a bar chart.
- Forecast next-day café revenue and next-day beverage demand with linear regression.
- Forecast 1–30 days of beverage demand using linear regression and Prophet (if enough sales history exists).
Limitations: This is a local prototype, not a production-secure database assistant. Its AI-generated SQL currently has only a basic SELECT-prefix check. Use a MySQL read-only account and test with non-sensitive/demo data. Do not expose this app publicly without additional SQL validation, authentication, and privacy controls.
1. Install the prerequisites
Install these on your computer:
1. Python (a compatible 3.10–3.11 environment is a reasonable starting point; verify compatibility for your OS).
2. MySQL Community Server and optionally MySQL Workbench.
3. Ollama.
4. Git (optional if downloading the repository ZIP).
Start MySQL and confirm you can connect in MySQL Workbench. Download the local AI model in a terminal:
ollama pull llama3.1
Ollama must be running when you use the app. Depending on your installation, you may need to start it with ollama serve in a separate terminal.

2. Download the project
git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
cd YOUR-REPOSITORY
Replace the example URL with the actual GitHub repository URL. Or click Code → Download ZIP, extract it, and open a terminal in that folder.

Expected files:
galaxy.py                  # Streamlit application
database_cheat_sheet.txt   # Tables, columns, joins and AI guidance
galaxy_cafe_schema.sql     # Starter MySQL schema
.env.example               # Safe example configuration
.gitignore                 # Prevents secrets and local data from being committed
requirements.txt           # Python dependencies
README.md                  # This guide

3. Create your MySQL database — exact café table structure
Easiest method (MySQL Workbench): Open Workbench → connect to your local MySQL server → File → Open SQL Script → select galaxy_cafe_schema.sql → click the lightning-bolt Execute button.

Or use the terminal (you'll be prompted for your MySQL administrator password):
mysql -u root -p < galaxy_cafe_schema.sql
The script creates the database galaxy_cafe and these 13 tables:
Table	What it stores	Primary key
customer	Customer accounts	CID
employee	Staff	EID
beverage	Drink names and descriptions	BID
bev_size	Small/medium/large sizes	SID
temperature_type	Hot/iced	TID
menu_variant	Beverage + size + temperature + price	MVID
ingredient	Raw ingredients	IID
consumable	Cups, lids, etc.	CNID
recipe_detail	Recipe links and quantities	RID
sales_invoice	Order headers	SIID
sales_details	Items purchased in each order	SDID
payment_type	Cash/credit/debit	PTID
sales_payment	Payments per invoice	SPID


How the tables connect (important):
customer.CID ──> sales_invoice.CID
employee.EID ──> sales_invoice.EID
sales_invoice.SIID ──> sales_details.SIID
sales_details.MVID ──> menu_variant.MVID
menu_variant.BID ──> beverage.BID
menu_variant.SID ──> bev_size.SID
menu_variant.TID ──> temperature_type.TID
sales_invoice.SIID ──> sales_payment.SIID
sales_payment.PTID ──> payment_type.PTID
recipe_detail.MVID ──> menu_variant.MVID
recipe_detail.IID ──> ingredient.IID
recipe_detail.CNID ──> consumable.CNID
recipe_detail.EID ──> employee.EID
Critical: SIID connects invoice headers to invoice line items. SDID is only the unique line-item ID; do not join invoices using SDID. The Python app and database_cheat_sheet.txt expect these exact table and column names.

To check that the tables exist, run in Workbench:
USE galaxy_cafe;
SHOW TABLES;
DESCRIBE sales_invoice;
DESCRIBE sales_details;

4. Add some data
The schema starts empty. Add your own demo or business records through Workbench or a SQL import. Insert parent rows before their dependent rows:
1. customer, employee, beverage, bev_size, temperature_type, ingredient, consumable, payment_type.
2. menu_variant (references a beverage, size and temperature).
3. sales_invoice (references customer and employee).
4. sales_details (references invoice and menu variant).
5. sales_payment (references invoice and payment type).
6. recipe_detail (optional, references variants/ingredients/consumables/employees).
For example, these SQL statements create one demo beverage, variant and paid order (assuming you started with an empty database):
USE galaxy_cafe;
INSERT INTO customer (C_NAME) VALUES ('Demo Customer');
INSERT INTO employee (E_NAME, JOB_TITLE) VALUES ('Demo Barista', 'Barista');
INSERT INTO beverage (B_NAME, bev_descr, CATEGORY) VALUES ('Matcha Latte', 'Matcha with milk', 'Tea');
INSERT INTO bev_size (SIZE_NAME, CAPACITY_ml) VALUES ('medium', 350);
INSERT INTO temperature_type (TYPE_NAME) VALUES ('iced');
INSERT INTO menu_variant (BID, TID, SID, SELLING_PRICE)
VALUES (1, 1, 1, 18.00);
INSERT INTO sales_invoice (INVOICE_DATE, EID, CID, order_fulfilled)
VALUES ('2026-01-01 10:00:00', 1, 1, 'paid');
INSERT INTO sales_details (QUANTITY, SELLING_PRICE, SIID, MVID)
VALUES (2, 18.00, 1, 1);
These examples assume the first auto-generated IDs are 1. If your database already contains rows, use the actual IDs instead. For meaningful forecasts, import many days of historical paid invoices and sales details; one order is not enough. The app forecasts the day after the latest date in the data, not necessarily tomorrow's real-world date.

5. Create a safe read-only MySQL user
In MySQL Workbench, connect as an administrator and execute the following, replacing CHOOSE_A_STRONG_UNIQUE_PASSWORD with your own new password:
CREATE USER 'galaxy_reader'@'localhost' IDENTIFIED BY 'CHOOSE_A_STRONG_UNIQUE_PASSWORD';
GRANT SELECT ON galaxy_cafe.* TO 'galaxy_reader'@'localhost';
If the user already exists, don't recreate it; check its grants instead. Do not use your MySQL root account for the chatbot.

6. Configure .env (your database login)
In the same folder as galaxy.py, copy .env.example to a file named .env:

Windows PowerShell:
Copy-Item .env.example .env
macOS / Linux:
cp .env.example .env
Edit .env with your own credentials:
DB_HOST=localhost
DB_USER=galaxy_reader
DB_PASSWORD=YOUR_OWN_PASSWORD_HERE
DB_NAME=galaxy_cafe
- DB_HOST: localhost if MySQL is running on the same computer.
- DB_USER: the read-only MySQL user you created.
- DB_PASSWORD: the password you assigned to that MySQL user (not your GitHub password).
- DB_NAME: must match the database name created in Step 3.
Never upload .env to GitHub, send it in screenshots, or commit a real database password. The provided .gitignore excludes it. If credentials have ever been exposed, rotate them.

7. Install Python libraries
Open a terminal in the project folder:

Windows:
py -m venv .venv
.venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
macOS / Linux:
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
Some systems may need extra build dependencies for Prophet. If installation fails, check the error message and the package's platform-specific installation instructions.
8. Run the chatbot
Make sure MySQL and Ollama are running, then:
streamlit run galaxy.py
Streamlit usually opens http://localhost:8501 in your browser.

Try these questions:
- What beverages are available?
- Show sales performance for all beverages.
- Predict tomorrow's cafe revenue.
- Predict Matcha Latte demand for the next 10 days.
The model may make mistakes when generating SQL. Review results before relying on them for business decisions.

9. How to use your own database instead of the café
You can adapt this app for a store, restaurant, library or another SQL-based project:
1. Create your MySQL database and tables with primary keys and foreign keys.
2. Update DB_NAME in .env (and DB_HOST, DB_USER, DB_PASSWORD if needed).
3. Rewrite database_cheat_sheet.txt to list your real table names, exact columns, primary/foreign keys and join paths. The chatbot uses this file as retrieval context; wrong names will produce wrong SQL.
4. Change the café-specific SQL in galaxy.py (the forecasting functions explicitly use sales_invoice, sales_details, beverage, etc.). Also adjust the routing prompt's café-specific labels and examples.
5. Clear the local rag_storage/ folder if switching databases, then restart the app to rebuild retrieval context.
6. Test read-only questions first; add forecasting only when you have appropriate historical date-and-sales columns.
Example cheat-sheet entry for a different business:
Table: 'orders' | Columns: 'order_id' (Primary Key), 'customer_id' (Foreign Key to customers.customer_id), 'order_date'.
Table: 'customers' | Columns: 'customer_id' (Primary Key), 'customer_name'.
Bridge: customers.customer_id -> orders.customer_id
This is an example for adapting the project, not a table definition from Galaxy Café. Update all affected Python queries as well. Merely changing .env will not make the forecasting code work on an unrelated schema.

Troubleshooting
Problem	What to check
Missing database settings	.env is beside galaxy.py and all four DB_* fields are filled.
Access denied for user	MySQL username/password and GRANT SELECT permissions.
Unknown database or table doesn't exist	Run galaxy_cafe_schema.sql and verify DB_NAME.
Database cheat sheet not found	Keep database_cheat_sheet.txt beside galaxy.py; launch from the project folder.
Ollama connection/model error	Start Ollama and run ollama pull llama3.1.
No forecasts	Import sufficient historical paid orders with sales line items.
AI generates invalid SQL	Confirm cheat sheet names match MySQL and try rephrasing.
ChromaDB issues after schema changes	Stop the app, remove local rag_storage/ if appropriate, restart to rebuild the index.


Safety & privacy
This project is for learning and local experimentation. Avoid using real customer personal information. The sample schema preserves the original café table names (including some sensitive columns), but you should not populate sensitive fields unless necessary and appropriately protected. LLM-generated SQL is not inherently safe; the existing SELECT check is not a security boundary. Before hosting publicly, add a proper SQL parser/allowlist, authentication, row limits, timeouts, privacy controls and server-side authorization.


