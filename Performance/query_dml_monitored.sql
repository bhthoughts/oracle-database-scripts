-- -----------------------------------------------------------------------------------
-- Description: DML Monitoring 
-- Requires Enterprise Edition and Diagnostic Pack option
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 200
SET COLSEP '|'

col table_owner for a15
col table_name for a30
col timestamp for a20

SELECT
    *
FROM
    (
        SELECT
            table_owner,
            tm.table_name,
            inserts,
            updates,
            deletes,
            inserts + updates + deletes                  AS total_dml,
            to_char(TIMESTAMP, 'DD-MON-YYYY HH24:mi:SS') timestamp,
            truncated,
            last_analyzed
        FROM
            dba_tab_modifications tm,
            dba_tables            t
        WHERE
                tm.table_name = t.table_name
            AND tm.table_owner = t.owner
            AND table_owner NOT IN ( 'SYS', 'SYSTEM', 'SYSMAN' )
                   --AND tm.table_name NOT LIKE 'MLOG$_%'
        ORDER BY
            total_dml DESC
    )
WHERE
    ROWNUM < 11
ORDER BY
    6 DESC;