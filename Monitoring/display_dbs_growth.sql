-- -----------------------------------------------------------------------------------
-- Type.......: Display
-- Execute per: Database
-- Description: Check the database size in terms of space used. I use this to calculate the database growth.
-- Datatype...: NUMBER (Float)
-- Rules......: N/A
-- Threshold..: N/A
-- Frequency..: Each 1 hour
-- -----------------------------------------------------------------------------------

SET LINESIZE 200

col gb for 999,999,999.99

SELECT
    SUM(bytes) / 1024 / 1024 / 1024 gb
FROM
    dba_segments;