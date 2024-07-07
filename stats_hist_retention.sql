-- -----------------------------------------------------------------------------------	
-- Description: Check statistics history retention
-- -----------------------------------------------------------------------------------	

SET LINESIZE 200

SELECT
    dbms_stats.get_stats_history_retention
FROM
    dual;