-- -----------------------------------------------------------------------------------	
-- Type.......: Display
-- Execute per: Instance
-- Description: Check the last database startup time
-- Datatype...: DATETIME
-- Rules......: N/A
-- Threshold..: N/A
-- Frequency..: Each 30 minutes
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col startup for a20

SELECT
    to_char(startup_time, 'dd/MON/yyyy hh24:mi:ss') startup
FROM
    v$instance i;