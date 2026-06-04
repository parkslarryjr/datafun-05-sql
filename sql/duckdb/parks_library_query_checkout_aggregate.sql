-- sql/duckdb/parks_library_query_checkout_aggregate.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Summarize overall activity across ALL library branches.
--
-- This query answers:
-- - "How many total checkouts are there?"
-- - "What is the overall fine revenue?"
-- - "What is the average checkout duration?"
--
-- WHY:
-- - Establishes overall system usage
-- - Provides baseline metrics before grouping by branch
-- - Helps understand overall demand patterns
--
-- ============================================================
-- DOMAIN: library
-- ============================================================
-- We are working with the checkout table only (no joins).
--
-- ============================================================
-- QUERY
-- ============================================================

SELECT
  COUNT(*) AS checkout_count,
  ROUND(SUM(fine_amount), 2) AS total_fines,
  ROUND(AVG(duration_days), 2) AS avg_duration_days
FROM checkout;
