-- -----------------------------------------------------------------------------------	
-- Type.......: Display
-- Execute per: Database
-- Description: Check if the database is in archivelog mode, you can use this to show in a grafana dashboard, or to create some triggers based on this.
-- Datatype...: VARCHAR
-- Rules......: N/A
-- Threshold..: N/A
-- Frequency..: Each 24 hours
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col log_mode for a20

SELECT
    log_mode
FROM
    v$database;