-- -----------------------------------------------------------------------------------	
-- Type.......: Alert
-- Execute per: Instance
-- Description: Monitoring of sessions connected and maximum sessions allowed by the current Oracle configuration. The result will be the percent usage.
-- Datatype...: NUMBER (Float)
-- Rules......: N/A
-- Threshold..: 90 %
-- Frequency..: Each 5 minutes
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col sessions for 999.99

SELECT
    round((current_utilization * 100) / limit_value, 2) sessions
FROM
    v$resource_limit
WHERE
    resource_name = 'sessions';