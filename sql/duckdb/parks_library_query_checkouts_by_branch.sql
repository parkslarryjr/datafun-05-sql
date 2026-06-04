-- sql/duckdb/parks_library_query_checkouts_by_branch.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Break overall library activity down by branch.
--
-- This query answers:
-- "How many checkouts do we have at each branch?"
--
-- WHY:
-- - Overall totals hide differences between branches.
-- - Grouping helps compare branch performance.
-- - This often reveals:
--   * Which branches are most active?
--   * Which branches are underused?
--
-- IMPORTANT:
-- This query uses GROUP BY but does NOT join tables yet.
-- We are working only with the checkout (child) table.
--
-- ============================================================
-- QUERY
-- ============================================================

SELECT
  branch_id,
  COUNT(*) AS checkout_count
FROM checkout
GROUP BY branch_id
ORDER BY checkout_count DESC;
