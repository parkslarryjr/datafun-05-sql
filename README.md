# datafun-05-sql

[![Workflow Guide](https://img.shields.io/badge/Pro--Guide-pro--analytics--02-green)](https://denisecase.github.io/pro-analytics-02/workflow-b-apply-example-project/)
[![Python 3.14](https://img.shields.io/badge/python-3.14%2B-blue?logo=python)](./pyproject.toml)
[![MIT](https://img.shields.io/badge/license-see%20LICENSE-yellow.svg)](./LICENSE)

> Professional Python project: relational data and SQL analytics.

Data analytics requires a variety of skills.
This course builds capabilities through working projects.

In the age of generative AI, durable skills are grounded in real work:
setting up a professional environment,
reading and running code,
understanding the logic,
and pushing work to a shared repository.
Each project follows the structure of professional Python projects.
We learn by doing.

## This Project

This project introduces **relational data and SQL** used when storing structured data in tables.
Analysts are typically highly skilled at both SQL and Python.

Sample datasets are provided in the `data/raw` folder
across several topic domains:

- **retail** - a store records many sales (the worked example)
- **library** - a library branch manages many checkouts
- **shelter** - a shelter manages many animal adoptions
- **civic_event** - an event manages many attendees

Each domain has two related tables in a 1-to-many relationship.
You will run the retail example, then implement the same pipeline for a domain you choose.

## Working Files

You'll work with just these areas:

- **data/raw/\*** - raw CSV input files
- **data/processed/** - processed data outputs, if created
- **artifacts/** - generated database files, logs, or reports
- **docs/** - the project narrative and documentation
- **sql/** - SQL query files
- **src/datafun/** - Python orchestration scripts
- **pyproject.toml** - update project metadata
- **zensical.toml** - update documentation site metadata

## Instructions (pro-analytics-02)

Follow the
[step-by-step workflow guide](https://denisecase.github.io/pro-analytics-02/workflow-b-apply-example-project/)
to complete:

1. Phase 1. **Start & Run**
2. Phase 2. **Change Authorship**
3. Phase 3. **Read & Understand**
4. Phase 4. **Modify**
5. Phase 5. **Apply**

## Challenges

Challenges are expected.
Sometimes instructions may not quite match your operating system.
When issues occur, share screenshots, error messages, and details about what you tried.
Working through issues is part of implementing professional projects.

## Success

After completing Phase 1. **Start & Run**, you'll have your own GitHub project,
running on your machine.

Running the examples should create generated database files in `artifacts/`.

A new file `project.log` will appear in the root project folder
and you should see:

```shell
========================
Executed successfully!
========================
```

A new file `project.log` will appear in the root project folder.

## Command Reference

The commands below are used in the workflow guide above.
They are provided here for convenience.

Follow the guide for the **full instructions**.

<details>
<summary>Show command reference</summary>

### In a machine terminal (open in your `Repos` folder)

After you get a copy of this repo in your own GitHub account,
open a machine terminal in your `Repos` folder:

```shell
# Replace username with YOUR GitHub username.
git clone https://github.com/parkslarrjr/datafun-05-sql

cd datafun-05-sql
code .
```

### In a VS Code terminal

These are listed for convenience.
For best results, follow the detailed instructions in
[pro-analytics-02 guide](https://denisecase.github.io/pro-analytics-02/).

```shell
uv self update
uv python pin 3.14
uv lock --upgrade
uv sync --extra dev --extra docs --upgrade

uvx pre-commit install

git add -A
uvx pre-commit run --all-files
# repeat if changes were made
uvx pre-commit run --all-files

# run the example pipelines (duckdb and sqlite)
uv run python -m datafun.app_retail_duckdb_case
uv run python -m datafun.app_retail_sqlite_case

# do chores
uv run ruff format .
uv run ruff check . --fix
uv run python -m pyright
uv run python -m pytest
uv run python -m zensical build

# save progress
git add -A
git commit -m "update"
git push -u origin main
```

</details>

## Notes

- Use the **UP ARROW** and **DOWN ARROW** in the terminal to scroll through past commands.
- Use `CTRL+f` to find (and replace) text within a file.
- You do not need to add to or modify `tests/`. They are provided for example only.
- Many files are silent helpers. Explore as you like, but nothing is required.
- You do NOT not to understand everything; understanding builds naturally over time.

## Troubleshooting >>>

If you see something like this in your terminal: `>>>` or `...`
You accidentally started Python interactive mode.
It happens.
Press `Ctrl+c` (both keys together) or `Ctrl+Z` then `Enter` on Windows.

## DuckDB Example Output (Replace This with Yours and Describe)

```shell
| INFO | P05 | RUN SQL query: C:\Repos\datafun\datafun-05-sql\sql\duckdb\case_retail_query_sales_by_category.sql
| INFO | P05 | ====================================
| INFO | P05 | case_retail_query_sales_by_category.sql
| INFO | P05 | ====================================
| INFO | P05 | product_category, sale_count, total_revenue, avg_sale_amount
| INFO | P05 | Outdoors, 9, 3200.0, 355.56
| INFO | P05 | Clothing, 10, 1375.0, 137.5
| INFO | P05 | Food, 11, 652.0, 59.27
| INFO | P05 |
| INFO | P05 | RUN SQL query: C:\Repos\datafun\datafun-05-sql\sql\duckdb\case_retail_query_kpi_revenue.sql
| INFO | P05 | ====================================
| INFO | P05 | case_retail_query_kpi_revenue.sql
| INFO | P05 | ====================================
| INFO | P05 | store_id, store_name, city, region, sale_count, total_revenue, avg_sale_amount
| INFO | P05 | S003, Central Plaza, Mankato, South, 10, 1868.0, 186.8
| INFO | P05 | S001, North Market, Duluth, North, 10, 1834.0, 183.4
| INFO | P05 | S002, Lakeside Shop, Ely, North, 10, 1525.0, 152.5
| INFO | P05 | ========================
| INFO | P05 | Executed successfully!
| INFO | P05 | ========================
| INFO | P05 | END main()
```
# Technical Modifications

## What I changed
I added a new SQL query file called `parks_retail_query_row_counts.sql` that counts the number of rows in the `store` and `sale` tables.

I also modified the `case_retail_query_sales_by_category.sql` file by changing the ORDER BY clause to sort results in ascending order (`ASC`) instead of descending.

## Why I made the change
I added the row count query to help verify that the data was loaded correctly into the database tables.

I changed the sorting order to better understand the data from lowest to highest values instead of highest to lowest.

## What I observed after running the project
After running the pipeline again, everything executed successfully with no errors.

The new row count query correctly showed the number of records in each table, and the category results were displayed in ascending order as expected.

# Phase 5. Apply the Skills to a New Problem

## 1. Domain Description and Relationship

The chosen domain is a library system with two related entities:

- **branch (parent table)**
  Represents library locations (e.g., Downtown Branch, East Side Branch).

- **checkout (child table)**
  Represents individual material checkouts made by library users.

### Relationship

This is a **one-to-many (1:M)** relationship:

- One branch can have many checkouts.
- Each checkout belongs to exactly one branch through `branch_id`.

---

## 2. SQL Pipeline Overview

The pipeline follows a structured ETL-style process:

- **Clean step**
  Removes existing tables to reset the database.

- **Bootstrap step**
  Creates `branch` and `checkout` tables and loads data from CSV files into DuckDB.

- **Query step**
  Runs multiple analytical SQL queries and logs results using Python.

- **KPI step**
  Calculates checkout activity by branch for decision-making.

---

## 3. SQL Queries Implemented

The project includes multiple meaningful queries:

- Total number of branches
- Total number of checkouts
- Checkout aggregation (total + average values)
- Checkouts grouped by branch
- KPI query: checkouts by branch with full branch details

These queries demonstrate filtering, aggregation, grouping, and joining relational tables.

---

## 4. Custom SQL Query (KPI)

A custom KPI query was created:

> “Which library branches have the most checkouts?”

This query joins `branch` and `checkout`, groups results by branch, and calculates total checkout activity per location.

---

## 5. Observations After Running the Pipeline

After running the pipeline:

- The database successfully created 3 library branches.
- A total of 30 checkout records were loaded.
- Each branch had 10 checkouts, showing balanced sample data.
- All SQL scripts executed successfully without errors.
- Query results were printed and logged through Python.

---

## 6. Insights Gained

This project demonstrated that SQL is very effective for analyzing structured relational data. Once the pipeline is set up, modifying or adding new SQL queries is straightforward and does not require changes to the underlying data loading process.

I also learned how Python can act as an orchestration layer to execute SQL scripts, log outputs, and manage a full analytics workflow. This separation of SQL (logic) and Python (execution) makes the system easier to maintain and scale.

---

## 7. SQL vs Pandas

SQL is often a better tool than pandas when working with relational datasets stored in structured tables. It allows efficient aggregation, filtering, and joins directly at the database level without loading all data into memory.

In this project, SQL was especially effective for grouping checkouts by branch and computing KPIs. These operations are simpler and more readable in SQL than they would be in pandas, particularly as the dataset grows or becomes more relational.
