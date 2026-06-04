-- sql/duckdb/parks_library_clean.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Completely removes library tables from the DuckDB database.
-- This resets the database so the pipeline can be rebuilt cleanly.
--
-- Cleaning is a common step during development and testing.
-- It ensures we start from a known empty state.
--
-- EXPECTED PROJECT PATHS (relative to repo root):
--   SQL:  sql/duckdb/parks_library_clean.sql
--   CSV:  data/raw/library/branch.csv
--   CSV:  data/raw/library/checkout.csv
--   DB:   artifacts/duckdb/library.duckdb
--
-- ============================================================
-- DOMAIN + 1:M RELATIONSHIP
-- ============================================================
-- DOMAIN: library
--
-- Each library branch has many checkouts.
-- This is a one-to-many relationship:
-- - branch = parent (1)
-- - checkout = child (many)
--
-- ============================================================
-- EXECUTION: ATOMIC CLEAN
-- ============================================================
BEGIN TRANSACTION;

-- ============================================================
-- STEP 1: DROP TABLES (CHILD FIRST, THEN PARENT)
-- ============================================================

DROP TABLE IF EXISTS checkout;
DROP TABLE IF EXISTS branch;

-- ============================================================
-- FINISH EXECUTION
-- ============================================================
COMMIT;
