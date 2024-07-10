-- -----------------------------------------------------------------------------------	
-- Description: Check statistics history availability
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LINESIZE 200
SET COLSEP '|'

COL TABLE_NAME FOR a30

SELECT
    table_name,
    to_char(stats_update_time, 'YYYY-MM-DD:HH24:MI:SS') AS stats_mod_time
FROM
    dba_tab_stats_history
WHERE
        owner = '&owner'
    AND table_name = '&table_name'
ORDER BY
    stats_update_time DESC;