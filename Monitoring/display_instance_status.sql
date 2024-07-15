-- -----------------------------------------------------------------------------------	
-- Type.......: Display
-- Execute per: Instance
-- Description: Check the instance status.
-- Datatype...: VARCHAR
-- Rules......: N/A
-- Threshold..: N/A
-- Frequency..: Each 1 hours
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col status for a15

SELECT
    status
FROM
    v$instance;