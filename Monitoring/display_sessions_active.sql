-- -----------------------------------------------------------------------------------
-- Type.......: Display
-- Execute per: Instance
-- Description: Check the number of active sessions.
-- Datatype...: NUMBER (Int)
-- Rules......: Do not consider Idle sessions
-- Threshold..: N/A
-- Frequency..: Each 5 minutes
-- -----------------------------------------------------------------------------------

SET LINESIZE 200

col sessions for 9999999

SELECT
    COUNT(*) sessions
FROM
    v$session
WHERE
    username IS NOT NULL
    AND status = 'ACTIVE'
    AND wait_class <> 'Idle';