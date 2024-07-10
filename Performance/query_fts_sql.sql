-- -----------------------------------------------------------------------------------
-- Description: Check SQLs that used FTS - It query the shared pool
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 250
SET COLSEP '|'

col sql_text for a100
col inst_id for 999
col timestamp for a20
col object_owner for a15
col object_name for a30
col operation for a15
col options for a10
col mb for 9999999.99

SELECT
    sp.io_cost,
    sp.sql_id,
    sq.sql_text,
    sp.inst_id,
    sp.object_owner,
    sp.object_name,
    sp.operation,
    sp.options,
    sp.bytes / 1024 / 1024 mb
FROM
         gv$sql_plan sp
    INNER JOIN gv$sql sq ON sq.sql_id = sp.sql_id
                            AND sp.inst_id = sq.inst_id
WHERE
        sp.operation = 'TABLE ACCESS'
    AND sp.options = 'FULL'
    AND bytes IS NOT NULL
ORDER BY
    1 asc, sp.bytes ASC;