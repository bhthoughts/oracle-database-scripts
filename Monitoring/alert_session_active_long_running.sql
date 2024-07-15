-- -----------------------------------------------------------------------------------
-- Type.......: Alert
-- Execute per: Instance
-- Description: Monitoring of long running sessions. Taking more than 30 minutes.
-- Datatype...: NUMBER (Int)
-- Rules......: Check for Active and running sessions, do not consider Idle sessions.
-- Threshold..: 1
-- Frequency..: Each 5 min
-- -----------------------------------------------------------------------------------

SET LINESIZE 200

col status for 999

SELECT
    COUNT(*) status
FROM
    (
        SELECT
            sid,
            serial#,
            round((sysdate - sql_exec_start) * 24 * 60) mindiff
        FROM
            v$session
        WHERE
            username IS NOT NULL
            AND wait_class != 'Idle'
            AND status = 'ACTIVE'
    )
WHERE
    mindiff > 30;