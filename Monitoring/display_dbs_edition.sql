-- -----------------------------------------------------------------------------------	
-- Type.......: Display
-- Execute per: Database
-- Description: Check the database edition. 
-- Datatype...: VARCHAR
-- Rules......: N/A
-- Threshold..: N/A
-- Frequency..: Each 24 hours
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200

col value for a5

SELECT
    edition value
FROM
    v$instance i;