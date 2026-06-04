-- sql/duckdb/parks_library_query_checkout_count.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Answer a basic activity question:
-- "How many checkout events have occurred?"
--
-- This query operates on the dependent/child table.
--
-- WHY:
-- - Total activity is the first thing analysts measure
-- - Helps understand overall system usage
-- - Provides a baseline before deeper analysis (by branch, etc.)
--
-- ============================================================
-- QUERY
-- ============================================================

SELECT
  COUNT(*) AS checkout_count
FROM checkout;
