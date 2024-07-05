-- -----------------------------------------------------------------------------------	
-- Description: Check asm diskgroup configuration
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col diskgroup for a10
col name for a50
col value for a20
col read_only for a5

SELECT
    substr(dg.name, 1, 12) AS diskgroup,
    substr(a.name, 1, 24)  AS name,
    substr(a.value, 1, 24) AS value,
    read_only
FROM
    v$asm_diskgroup dg,
    v$asm_attribute a
WHERE
        dg.name = 'DATA'
    AND dg.group_number = a.group_number
    AND a.name NOT LIKE '%template%';