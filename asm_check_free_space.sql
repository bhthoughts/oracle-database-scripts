-- -----------------------------------------------------------------------------------	
-- Description: Check asm diskgroup free space
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col name for a15
col total_mb for 99999999
col free_mb for 99999999
col type for a10
col usable_file_mb for 99999999

SELECT
    name,
    total_mb,
    free_mb,
    type,
    usable_file_mb
FROM
    v$asm_diskgroup_stat;