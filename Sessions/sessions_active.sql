-- -----------------------------------------------------------------------------------
-- Description: Connected active sessions
-- -----------------------------------------------------------------------------------

SET LINESIZE 250
SET PAGESIZE 2000
SET COLSEP '|'

col username format a7
col program format a12
col machine format a15
col module format a10
col event format a10
col osuser format a8
col SERVICE_NAME for a15
col spid format a7
col SEC_WAIT format 999999
col inst_id format 99
col logon_time format 10
col wait_class format a10
col sql_exec_start for a20
col logon_time for a20
col minutes for 999999
col con_id for 999
col sid for 999999
col serial# for 999999
col status for a8

SELECT
    to_char(logon_time, 'dd/MON/yyyy hh24:mi:ss')     "logon_time",
    to_char(sql_exec_start, 'dd/MON/yyyy hh24:mi:ss') sql_exec_start,
    round((sysdate - sql_exec_start) * 24 * 60)       minutes,
    s.con_id,
    s.sid,
    s.serial#,
    p.spid, /*s.inst_id,*/
    s.machine,
    s.osuser,
    s.username,
    s.program,
    s.service_name,
    w.wait_class,
    w.event,
    s.seconds_in_wait SEC_WAIT,
    s.sql_id,
    s.status
FROM
    gv$session      s,
    gv$session_wait w,
    gv$process      p
WHERE
        s.sid = w.sid and s.inst_id = w.inst_id
    AND p.addr = s.paddr and p.inst_id = s.inst_id
    AND s.username IS NOT NULL
    AND s.status = 'ACTIVE'
    AND s.wait_class != 'Idle'
ORDER BY
    2 DESC;
