-- -----------------------------------------------------------------------------------	
-- Type.......: Display
-- Execute per: Database
-- Description: Checking the database version
-- Datatype...: VARCHAR
-- Rules......: N/A
-- Threshold..: N/A
-- Frequency..: Each 24 hours
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col db_version for a20

SELECT
    version_full db_version
FROM
    v$instance i;