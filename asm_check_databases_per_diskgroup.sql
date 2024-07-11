-- -----------------------------------------------------------------------------------	
-- Description: Check asm databases per diskgroup
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col diskgroup for a15
col instance for a10
col dbname for a10
col software for a10
col compatible for a10

SELECT
    dg.name                             AS diskgroup,
    substr(c.instance_name, 1, 12)      AS instance,
    substr(c.db_name, 1, 12)            AS dbname,
    substr(c.software_version, 1, 12)   AS software,
    substr(c.compatible_version, 1, 12) AS compatible
FROM
    v$asm_diskgroup dg,
    v$asm_client    c
WHERE
    dg.group_number = c.group_number;