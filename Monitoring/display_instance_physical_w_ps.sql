-- -----------------------------------------------------------------------------------
-- Type.......: Display
-- Execute per: Instance
-- Description: Check the physical writes per second
-- Datatype...: NUMBER (Float) 
-- Rules......: Oracle gathers this metric from the last hour
-- Threshold..: N/A
-- Frequency..: Each 5 minutes.
-- -----------------------------------------------------------------------------------

SET LINESIZE 200

col standard_deviation for 999,999,999.99

SELECT
    standard_deviation
FROM
    v$sysmetric_summary
WHERE
    metric_name = 'Physical Writes Per Sec';