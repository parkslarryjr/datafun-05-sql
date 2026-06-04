"""app_library_duckdb_parks.py - Library Pipeline Script

Author: Larry Parks
Date: 2026

Purpose:
- Load library CSV data into DuckDB
- Use Python to execute SQL scripts stored in files
- Log pipeline execution steps

Paths (relative to repo root):
   SQL:  sql/duckdb/parks_library_*.sql
   CSV:  data/raw/library/branch.csv
   CSV:  data/raw/library/checkout.csv
   DB:   artifacts/duckdb/library.duckdb
"""

# === IMPORTS ===

import logging
from pathlib import Path
from typing import Final

from datafun_toolkit.logger import get_logger, log_header
import duckdb

# === LOGGER ===

LOG: logging.Logger = get_logger("P05", level="DEBUG")

# === PATHS ===

ROOT_DIR: Final[Path] = Path.cwd()

DATA_RAW_DIR: Final[Path] = ROOT_DIR / "data" / "raw" / "library"
DATA_PROCESSED_DIR: Final[Path] = ROOT_DIR / "data" / "processed" / "library"
ARTIFACTS_DIR: Final[Path] = ROOT_DIR / "artifacts" / "duckdb"
SQL_DIR: Final[Path] = ROOT_DIR / "sql" / "duckdb"

BRANCH_CSV: Final[Path] = DATA_RAW_DIR / "branch.csv"
CHECKOUT_CSV: Final[Path] = DATA_RAW_DIR / "checkout.csv"
DB_PATH: Final[Path] = ARTIFACTS_DIR / "library.duckdb"

# === SQL READER ===


def read_sql(sql_path: Path) -> str:
    return sql_path.read_text(encoding="utf-8")


# === RUN SQL SCRIPT ===


def run_sql_script(con: duckdb.DuckDBPyConnection, sql_path: Path) -> None:
    LOG.info(f"RUN SQL script: {sql_path}")
    con.execute(read_sql(sql_path))
    LOG.info(f"DONE SQL script: {sql_path}")


# === RUN SQL QUERY ===


def run_sql_query(con: duckdb.DuckDBPyConnection, sql_path: Path) -> None:
    LOG.info("")
    LOG.info(f"RUN SQL query: {sql_path}")

    result = con.execute(read_sql(sql_path))
    rows = result.fetchall()
    columns = [col[0] for col in result.description]

    LOG.info("====================================")
    LOG.info(sql_path.name)
    LOG.info("====================================")
    LOG.info(", ".join(columns))

    for row in rows:
        LOG.info(", ".join(str(v) for v in row))


# === MAIN PIPELINE ===


def main() -> None:
    log_header(LOG, "P05 Library Pipeline (DuckDB)")

    LOG.info("START main()")
    LOG.info(f"ROOT_DIR: {ROOT_DIR}")
    LOG.info(f"DATA_RAW_DIR: {DATA_RAW_DIR}")
    LOG.info(f"SQL_DIR: {SQL_DIR}")
    LOG.info(f"DB_PATH: {DB_PATH}")

    ARTIFACTS_DIR.mkdir(parents=True, exist_ok=True)

    con = duckdb.connect(str(DB_PATH))

    try:
        # STEP 1: CLEAN
        run_sql_script(con, SQL_DIR / "parks_library_clean.sql")

        # STEP 2: BOOTSTRAP
        run_sql_script(con, SQL_DIR / "parks_library_bootstrap.sql")

        # STEP 3: BASIC QUERIES
        run_sql_query(con, SQL_DIR / "parks_library_query_branch_count.sql")
        run_sql_query(con, SQL_DIR / "parks_library_query_checkout_count.sql")
        run_sql_query(con, SQL_DIR / "parks_library_query_checkout_aggregate.sql")
        run_sql_query(con, SQL_DIR / "parks_library_query_checkouts_by_branch.sql")

        # STEP 4: KPI QUERY
        run_sql_query(con, SQL_DIR / "parks_library_kpi_borrowing.sql")

        LOG.info("========================")
        LOG.info("Executed successfully!")
        LOG.info("========================")

    finally:
        con.close()

    LOG.info("END main()")


if __name__ == "__main__":
    main()
