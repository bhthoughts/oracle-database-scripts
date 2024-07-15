-- -----------------------------------------------------------------------------------	
-- Type.......: Display
-- Execute per: Instance
-- Description: Check the average of logons per second.
-- Datatype...: NUMBER (Float)
-- Rules......: Oracle gathers this metric from the last hour
-- Threshold..: N/A
-- Frequency..: Each 5 minutes
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200

col log_avg for 999,999,999.99

SELECT
    round(average, 2) log_avg
FROM
    v$sysmetric_summary
WHERE
    metric_name = 'Logons Per Sec';