-- -----------------------------------------------------------------------------------	
-- Description: Check asm griddisks
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col diskgroup for a10
col asmdisk for a15
col mount_status for a10
col state for a10
col failgroup for a15

SELECT
    substr(dg.name, 1, 16)     AS diskgroup,
    substr(d.name, 1, 16)      AS asmdisk,
    d.mount_status,
    d.state,
    substr(d.failgroup, 1, 16) AS failgroup
FROM
    v$asm_diskgroup dg,
    v$asm_disk      d
WHERE
    dg.group_number = d.group_number;