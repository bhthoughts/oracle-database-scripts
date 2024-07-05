-- -----------------------------------------------------------------------------------	
-- Description: List tablespaces
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col tablespace_name for a30
col allocated_mb for 99999999.99
col max_mb for 99999999.99
col free_mb for 99999999.99
col "%_USED" for 999.99

SELECT
    tablespace_name,
    SUM(bytes / 1024 / 1024)                                   allocated_mb,
    SUM(maxbytes / 1024 / 1024)                                max_mb,
    ( SUM(maxbytes / 1024 / 1024) - SUM(bytes / 1024 / 1024) ) free_mb,
    round((SUM(bytes / 1024 / 1024) / SUM(maxbytes / 1024 / 1024)) * 100,
          2)                                                   "%_USED"
FROM
    dba_data_files
GROUP BY
    tablespace_name
ORDER BY
    5 asc;