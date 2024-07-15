-- -----------------------------------------------------------------------------------	
-- Type.......: Display
-- Execute per: Database
-- Description: Check the database size, calculating the datafile sizes.
-- Datatype...: NUMBER (Float)
-- Rules......: Check the datafile size, not the space used by the segments.
-- Threshold..: N/A
-- Frequency..: 30 minutes
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col host_name for a40

SELECT
    d.instance_name,
    f.name                                               dbname,
    e.host_name,
    ( a.bytes + b.bytes + c.bytes ) / 1024 / 1024 / 1024 AS "DATABASE SIZE (GB)"
FROM
    (
        SELECT
            SUM(bytes) AS bytes
        FROM
            dba_data_files
    ) a,
    (
        SELECT
            SUM(bytes) AS bytes
        FROM
            dba_temp_files
    ) b,
    (
        SELECT
            SUM(bytes) AS bytes
        FROM
            v$log
    ) c,
    (
        SELECT
            instance_name
        FROM
            v$instance
    ) d,
    (
        SELECT
            host_name
        FROM
            v$instance
    ) e,
    (
        SELECT
            name
        FROM
            v$database
    ) f;