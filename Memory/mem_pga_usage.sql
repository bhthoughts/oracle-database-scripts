-- -----------------------------------------------------------------------------------
-- Description: Check PGA Usage by Session
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 200
SET COLSEP '|'

COL SID FOR 99999
COL STATUS FOR A10
COL SQL_ID FOR A20
COL SPID FOR 9999999
COL USER FOR A15
COL PROGRAM FOR A50
COL PGA_ALLOC_MB FOR 999999.99
COL PGA_USED_MB FOR 999999.99
COL PGA_FREEABLE_MB FOR 999999.99
COL PGA_MAX_USED_MB FOR 999999.99

SELECT
    sid,
    status,
    sql_id,
    p.spid,
    substr(p.username, 1, 20)                  "USER",
    p.program,
    round(p.pga_alloc_mem / 1024 / 1024, 2)    pga_alloc_mb,
    round(p.pga_used_mem / 1024 / 1024, 2)     pga_used_mb,
    round(p.pga_freeable_mem / 1024 / 1024, 2) pga_freeable_mb,
    round(p.pga_max_mem / 1024 / 1024, 2)      pga_max_used_mb
FROM
         v$process p
    JOIN v$session s ON s.paddr = p.addr
ORDER BY
    pga_alloc_mem DESC,
    pga_used_mem DESC;