-- -----------------------------------------------------------------------------------
-- Type.......: Display 
-- Execute per: Instance
-- Description: Check the logical reads per second.
-- Datatype...: NUMBER (Float) 
-- Rules......: Oracle gathers this metric from the last hour
-- Threshold..: N/A
-- Frequency..: Each 5 minutes.
-- -----------------------------------------------------------------------------------

SET LINESIZE 200

col average for 999999999999.99

SELECT
    average
FROM
    v$sysmetric_summary
WHERE
    metric_name = 'Logical Reads Per Sec';