-- ============================================================
-- FILE: parks_library_query_branch_count.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Answer a simple structural question:
-- "How many library branches do we have?"
-- ============================================================

SELECT
  COUNT(*) AS branch_count
FROM branch;
