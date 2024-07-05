-- -----------------------------------------------------------------------------------
-- History of DBA_SCHEDULE_JOB executions with more details
-- -----------------------------------------------------------------------------------

SET LINESIZE 230 PAGES 200
SET COLSEP '|'

COLUMN log_date FORMAT A20
COLUMN owner FORMAT A15
COLUMN job_name FORMAT A30
COLUMN session_id FORMAT a10
COLUMN status FORMAT A12
COLUMN actual_start_date FORMAT a20
COLUMN additional_info FORMAT a100
COLUMN errors FORMAT a15

SELECT
    to_char(log_date, 'DD-MON-YYYY HH24:mi:SS')          log_date,
    owner,
    job_name,
    session_id,
    status,
    to_char(actual_start_date, 'DD-MON-YYYY HH24:mi:SS') actual_start_date,
    run_duration,
    errors
FROM
    dba_scheduler_job_run_details
ORDER BY
    1 ASC;
