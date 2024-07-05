-- -----------------------------------------------------------------------------------	
-- Description: Undo Tablespace Usage for NON-CDB databases
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col con_id for 999
col tablespace_name for a30
col status for a15
col mb_usage for 99999999.99
col perc for 999.99

SELECT
    a.tablespace_name,
    a.status,
    round(a.sum_bytes /(1024 * 1024), 0)        AS mb_usage, --a.sum_bytes/1024/1024 M_bytes, b.undo_size/1024/1024 M_undo,
    round((a.sum_bytes / b.undo_size) * 100, 0) AS perc
FROM
    (
        SELECT
            tablespace_name,
            status,
            SUM(bytes) sum_bytes
        FROM
            dba_undo_extents
        GROUP BY
            tablespace_name,
            status
    ) a,
    (
        SELECT
            c.tablespace_name,
            SUM(a.bytes) undo_size
        FROM
                 dba_tablespaces c
            JOIN v$tablespace b ON b.name = c.tablespace_name
            JOIN v$datafile   a ON a.ts# = b.ts#
        WHERE
                c.contents = 'UNDO'
            AND c.status = 'ONLINE'
        GROUP BY
            c.tablespace_name
    ) b
WHERE
    a.tablespace_name = b.tablespace_name;