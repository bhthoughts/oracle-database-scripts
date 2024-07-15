-- -----------------------------------------------------------------------------------	
-- Type.......: Alert
-- Execute per: Instance
-- Description: Monitoring the process limit usage percent.
-- Datatype...: NUMBER (Float)
-- Rules......: N/A
-- Threshold..: 90% 
-- Frequency..: Each 5 minutes.
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200

col process for 999.99

SELECT
    round((current_utilization * 100) / limit_value, 2) process
FROM
    v$resource_limit
WHERE
    resource_name = 'processes';