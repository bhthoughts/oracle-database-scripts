-- -----------------------------------------------------------------------------------
-- Type.......: Alert
-- Execute per: Database
-- Description: Monitoring the jobs that failed today.
-- Datatype...: NUMBER (Int)
-- Rules......: N/A
-- Threshold..: N/A
-- Frequency..: Each 5 minutes
-- -----------------------------------------------------------------------------------

SET LINESIZE 200

COL jobs for 999999999

SELECT
    COUNT(*) jobs
FROM
    dba_scheduler_job_run_details
WHERE
        status = 'FAILED'
    -- AND EXTRACT(YEAR FROM LOG_DATE)=2020
    -- AND EXTRACT(MONTH FROM LOG_DATE) = 1
    AND to_char(log_date, 'DD-MM-YYYY') = to_char(sysdate, 'DD-MM-YYYY');