-- sql/duckdb/parks_library_kpi_borrowing.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Calculate a Key Performance Indicator (KPI) for the library domain using DuckDB SQL.
--
-- KPI DRIVES THE WORK:
-- In analytics, we do not start with "write a query."
-- We start with a KPI that supports an actionable decision.
--
-- ACTIONABLE OUTCOME (EXAMPLE):
-- We want to understand which library branches are the most active so we can:
-- - allocate more staff during busy periods,
-- - increase book availability at high-demand branches,
-- - identify underused branches,
-- - improve resource planning across the library system.
--
-- In this example, our KPI is checkouts by branch.
--
-- ASSUMPTION:
-- We always run all commands from the project root directory.
--
-- EXPECTED PROJECT PATHS (relative to repo root):
--   SQL:  sql/duckdb/parks_library_kpi_borrowing.sql
--   DB:   artifacts/duckdb/library.duckdb
--
-- ============================================================
-- DOMAIN + 1:M RELATIONSHIP
-- ============================================================
-- DOMAIN: library
--
-- Two tables in a 1-to-many relationship (1:M):
-- - branch (1): independent/parent table
-- - checkout (M): dependent/child table
--
-- HOW THIS RELATES TO OUR KPI:
-- - branch tells us "where" activity happens
-- - checkout contains the measurable activity (checkouts)
-- - To compute activity by branch, we:
--   1) connect checkouts to branches (JOIN on branch_id),
--   2) aggregate checkouts per branch (GROUP BY branch)
--
-- ============================================================
-- KPI DEFINITION
-- ============================================================
-- KPI NAME: Total Checkouts by Branch
--
-- KPI QUESTION:
-- "Which library branches have the most checkouts?"
--
-- MEASURE:
-- - checkout count = COUNT(checkout_id)
--
-- GRAIN:
-- - one row per branch
--
-- OUTPUT:
-- - branch info + checkout activity
--
-- ============================================================
-- QUERY
-- ============================================================

SELECT
  b.branch_id,
  b.branch_name,
  b.city,
  b.system_name,
  COUNT(c.checkout_id) AS checkout_count
FROM branch AS b
JOIN checkout AS c
  ON c.branch_id = b.branch_id
GROUP BY
  b.branch_id,
  b.branch_name,
  b.city,
  b.system_name
ORDER BY checkout_count DESC;
