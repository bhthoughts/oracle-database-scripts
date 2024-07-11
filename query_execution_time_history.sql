-- -----------------------------------------------------------------------------------
-- Query execution time history
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 250
SET COLSEP '|'

COL begin_interval_time FOR A20
COL end_interval_time FOR A20
COL instance_number FOR 9
COL plan_hash_value FOR 999999999999
COL optimizer_cost FOR 999999999
COL executions_delta FOR 999999999
COL disk_reads_delta FOR 999999999
COL elapsed_time_delta FOR 999999999
COL avg_per_exec FOR 999999999
COL avg_io_per_exec FOR 999999999
COL iowait_delta FOR 999999999
COL clwait_delta FOR 999999999
COL physical_read_mbytes_delta FOR 999999999

SELECT
    to_char(b.begin_interval_time, 'YYYY-MM-DD HH24:mi:SS')   begin_interval_time,
    to_char(b.end_interval_time, 'YYYY-MM-DD HH24:mi:SS')     end_interval_time,
    a.instance_number,
    a.plan_hash_value,
    a.optimizer_cost,
    a.executions_delta,
    a.disk_reads_delta,
    round(a.elapsed_time_delta / 1000000)                     AS elapsed_time_delta,
    round((a.elapsed_time_delta / 1000) / a.executions_delta) AS avg_per_exec,
    round((a.iowait_delta / 1000000) / a.executions_delta)    AS avg_io_per_exec,
    round(a.iowait_delta / 1000000)                           AS iowait_delta,
    round(a.clwait_delta / 10000000)                          AS clwait_delta,
    round(physical_read_bytes_delta / 1024 / 1024)            physical_read_mbytes_delta
FROM
         dba_hist_sqlstat a
    JOIN dba_hist_snapshot b ON ( a.snap_id = b.snap_id
                                  AND a.instance_number = b.instance_number )
WHERE
        a.executions_delta != 0
    AND a.sql_id = &sql_id
ORDER BY
    2 DESC;