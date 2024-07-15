-- -----------------------------------------------------------------------------------
-- Type.......: Display
-- Execute per: Instance
-- Description: Check the physical reads per second
-- Datatype...: NUMBER (Float) 
-- Rules......: Oracle gathers this metric from the last hour
-- Threshold..: Need to be configured according to the workload
-- Frequency..: Each 5 minutes.
-- -----------------------------------------------------------------------------------

SET LINESIZE 200

col standard_deviation for 999999999999.99

SELECT
    standard_deviation
FROM
    v$sysmetric_summary
WHERE
    metric_name = 'Physical Reads Per Sec';