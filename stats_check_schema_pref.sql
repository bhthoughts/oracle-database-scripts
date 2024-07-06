-- -----------------------------------------------------------------------------------	
-- Description: Check preference for schema statistics
-- -----------------------------------------------------------------------------------	

SET LINESIZE 450
SET COLSEP '|'

COLUMN username FORMAT A15
COLUMN approximate_ndv_algorithm FORMAT A25
COLUMN auto_stat_extensions FORMAT A20
COLUMN auto_task_status FORMAT A16
COLUMN auto_task_max_run_time FORMAT A22
COLUMN auto_task_interval FORMAT A18
COLUMN cascade FORMAT A23
COLUMN concurrent FORMAT A10
COLUMN degree FORMAT A6
COLUMN estimate_percent FORMAT A27
COLUMN global_temp_table_stats FORMAT A23
COLUMN granularity FORMAT A11
COLUMN incremental FORMAT A11
COLUMN incremental_staleness FORMAT A21
COLUMN incremental_level FORMAT A17
COLUMN method_opt FORMAT A25
COLUMN no_invalidate FORMAT A26
COLUMN options FORMAT A7
COLUMN preference_overrides_parameter FORMAT A30
COLUMN publish FORMAT A7
COLUMN options FORMAT A7
COLUMN stale_percent FORMAT A13
COLUMN stat_category FORMAT A28
COLUMN table_cached_blocks FORMAT A19
COLUMN wait_time_to_update_stats FORMAT A19

SELECT
    username,
    --dbms_stats.get_prefs(ownname => username, pname => 'APPROXIMATE_NDV_ALGORITHM')      AS approximate_ndv_algorithm,
    --dbms_stats.get_prefs(ownname => username, pname => 'AUTO_STAT_EXTENSIONS')           AS auto_stat_extensions,
    --dbms_stats.get_prefs(ownname => username, pname => 'AUTO_TASK_STATUS')               AS auto_task_status,
    --dbms_stats.get_prefs(ownname => username, pname => 'AUTO_TASK_MAX_RUN_TIME')         AS auto_task_max_run_time,
    --dbms_stats.get_prefs(ownname => username, pname => 'AUTO_TASK_INTERVAL')             AS auto_task_interval,
    dbms_stats.get_prefs(ownname => username, pname => 'CASCADE')                        AS cascade,
    --dbms_stats.get_prefs(ownname => username, pname => 'CONCURRENT')                     AS concurrent,
    dbms_stats.get_prefs(ownname => username, pname => 'DEGREE')                         AS degree,
    dbms_stats.get_prefs(ownname => username, pname => 'ESTIMATE_PERCENT')               AS estimate_percent,
    --dbms_stats.get_prefs(ownname => username, pname => 'GLOBAL_TEMP_TABLE_STATS')        AS global_temp_table_stats,
    dbms_stats.get_prefs(ownname => username, pname => 'GRANULARITY')                    AS granularity,
    dbms_stats.get_prefs(ownname => username, pname => 'INCREMENTAL')                    AS incremental,
    --dbms_stats.get_prefs(ownname => username, pname => 'INCREMENTAL_STALENESS')          AS incremental_staleness,
    --dbms_stats.get_prefs(ownname => username, pname => 'INCREMENTAL_LEVEL')              AS incremental_level,
    dbms_stats.get_prefs(ownname => username, pname => 'METHOD_OPT')                     AS method_opt,
    dbms_stats.get_prefs(ownname => username, pname => 'NO_INVALIDATE')                  AS no_invalidate,
    dbms_stats.get_prefs(ownname => username, pname => 'OPTIONS')                        AS options,
    --dbms_stats.get_prefs(ownname => username, pname => 'PREFERENCE_OVERRIDES_PARAMETER') AS preference_overrides_parameter,
    --dbms_stats.get_prefs(ownname => username, pname => 'PUBLISH')                        AS publish,
    dbms_stats.get_prefs(ownname => username, pname => 'STALE_PERCENT')                  AS stale_percent
    --dbms_stats.get_prefs(ownname => username, pname => 'STAT_CATEGORY')                  AS stat_category,
    --dbms_stats.get_prefs(ownname => username, pname => 'TABLE_CACHED_BLOCKS')            AS table_cached_blocks,
    --dbms_stats.get_prefs(ownname => username, pname => 'WAIT_TIME_TO_UPDATE_STATS')      AS wait_time_to_update_stats
FROM
    dba_users
WHERE
    username LIKE '&username'
ORDER BY
    username;