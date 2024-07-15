-- -----------------------------------------------------------------------------------
-- Type.......: Display
-- Execute per: Database
-- Description: Check the database role
-- Datatype...: VARCHAR
-- Rules......: N/A
-- Threshold..: N/A
-- Frequency..: Each 24 hours
-- -----------------------------------------------------------------------------------

SET LINESIZE 200

col database_role for a20

SELECT
    database_role
FROM
    v$database;