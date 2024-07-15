-- -----------------------------------------------------------------------------------	
-- Type.......: Display
-- Execute per: Instance
-- Description: Check the number of transactions happening at the database. I usually don`t monitor it, just print in Grafana, so we can understand the workload in peak periods.
-- Datatype...: NUMBER (Int)
-- Rules......: N/A
-- Threshold..: N/A
-- Frequency..: Each 10 minutes
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col transactions for 99999999

SELECT
    COUNT(*) transactions
FROM
    v$transaction;