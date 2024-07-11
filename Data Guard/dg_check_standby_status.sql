-- -----------------------------------------------------------------------------------	
-- Description: Check standby status
-- Can be executed on Primary
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col status for a10
col protection_mode for a30
col destination for a15
col synchronized for a5
col gap_status for a15

SELECT
    status,
    protection_mode,
    destination,
    synchronized,
    gap_status
FROM
    v$archive_dest_status t
WHERE
    database_mode LIKE '%STANDBY%';