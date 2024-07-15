-- -----------------------------------------------------------------------------------	
-- Type.......: Alert
-- Execute per: Instance
-- Description: Monitoring of OS load. You can use this in case your monitoring system has only access to DB, not OS.
-- Datatype...: NUMBER (Float)
-- Rules......: Max value from the the last hour
-- Threshold..: Depend on your systems
-- Frequency..: Each 5 minutes
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col maxval for 999,999,999.99

SELECT
    maxval
FROM
    v$sysmetric_summary
WHERE
    metric_name = 'Current OS Load';