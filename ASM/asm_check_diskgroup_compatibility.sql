-- -----------------------------------------------------------------------------------	
-- Description: Check asm diskgroup compatibility
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col diskgroup for a10
col asm_compat for a20
col db_compat for a20

SELECT
    name                                  AS diskgroup,
    substr(compatibility, 1, 12)          AS asm_compat,
    substr(database_compatibility, 1, 12) AS db_compat
FROM
    v$asm_diskgroup;