-- -----------------------------------------------------------------------------------
-- Description: Query DBA_JOBS running now
-- -----------------------------------------------------------------------------------

SET LINE 200
SET PAGESIZE 10000
SET COLSEP '|'

col what format a40
col username format a15
col machine format a15

SELECT
    a.username,
    a.osuser,
    a.machine,
    a.sid,
    a.serial#,
    b.spid,
    c.job,
    c.what
FROM
    v$session        a,
    v$process        b,
    dba_jobs         c,
    dba_jobs_running d
WHERE
        a.paddr = b.addr
    AND c.job = d.job
    AND a.sid IN (
        SELECT
            sid
        FROM
            dba_jobs_running
    );