-- -----------------------------------------------------------------------------------	
-- Type.......: Display
-- Execute per: Instance
-- Description: Check the average of the sessions response time
-- Datatype...: NUMBER (Float)
-- Rules......: Oracle gathers this metric from the last hour
-- Threshold..: N/A
-- Frequency..: Each 10 minutes
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col resp_time for 999,999.99

SELECT
    round(average, 2) resp_time
FROM
    v$sysmetric_summary
WHERE
    metric_name = 'SQL Service Response Time';