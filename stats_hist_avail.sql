-- -----------------------------------------------------------------------------------	
-- Description: Check statistics history availability
-- -----------------------------------------------------------------------------------	

SET LINESIZE 200

SELECT
    dbms_stats.get_stats_history_availability
FROM
    dual;