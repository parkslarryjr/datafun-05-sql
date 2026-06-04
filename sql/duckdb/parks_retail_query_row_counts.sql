-- sql/duckdb/parks_retail_query_row_counts.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Verify the number of records loaded into key tables.
--
-- This query counts rows in the core retail tables:
-- - store
-- - sale
--
-- WHY:
-- - Confirms data was loaded correctly
-- - Helps validate ETL pipeline integrity
-- - Provides a quick check on dataset size
-- - Useful for debugging and quality assurance

SELECT 'store' AS table_name, COUNT(*) AS row_count FROM store
UNION ALL
SELECT 'sale' AS table_name, COUNT(*) AS row_count FROM sale;
