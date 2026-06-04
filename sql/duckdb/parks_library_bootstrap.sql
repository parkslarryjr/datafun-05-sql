-- sql/duckdb/parks_library_bootstrap.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Creates library tables and loads data from CSV files (DuckDB).
--
-- ASSUMPTION:
-- We always run all commands from the project root directory.
--
-- EXPECTED PROJECT PATHS (relative to repo root):
--   SQL:  sql/duckdb/parks_library_bootstrap.sql
--   CSV:  data/raw/library/branch.csv
--   CSV:  data/raw/library/checkout.csv
--   DB:   artifacts/duckdb/library.duckdb
--
-- ============================================================
-- TOPIC DOMAINS + 1:M RELATIONSHIPS
-- ============================================================
-- OUR DOMAIN: LIBRARY
--
-- One library branch can have many checkouts.
--
-- - branch table = parent (1)
-- - checkout table = child (many)
--
-- checkout.branch_id references branch.branch_id
--
-- ============================================================
-- EXECUTION: ATOMIC BOOTSTRAP (ALL OR NOTHING)
-- ============================================================

BEGIN TRANSACTION;

-- ============================================================
-- STEP 1: CREATE TABLES (PARENT FIRST, THEN CHILD)
-- ============================================================

CREATE TABLE IF NOT EXISTS branch (
  branch_id TEXT PRIMARY KEY,
  branch_name TEXT NOT NULL,
  city TEXT NOT NULL,
  system_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS checkout (
  checkout_id TEXT PRIMARY KEY,
  branch_id TEXT NOT NULL,
  material_type TEXT NOT NULL,
  duration_days INTEGER NOT NULL,
  fine_amount DOUBLE NOT NULL,
  checkout_date TEXT NOT NULL
);

-- ============================================================
-- STEP 2: LOAD DATA (PARENT FIRST, THEN CHILD)
-- ============================================================

COPY branch
FROM 'data/raw/library/branch.csv'
(HEADER, DELIMITER ',', QUOTE '"', ESCAPE '"');

COPY checkout
FROM 'data/raw/library/checkout.csv'
(HEADER, DELIMITER ',', QUOTE '"', ESCAPE '"');

-- ============================================================
-- FINISH EXECUTION
-- ============================================================

COMMIT;
