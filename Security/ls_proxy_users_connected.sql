-- -----------------------------------------------------------------------------------	
-- Description: List proxy user sessions connected to the database
-- -----------------------------------------------------------------------------------	

SET LINESIZE 500
SET PAGESIZE 1000
SET COLSEP '|'

column username format a20
column osuser format a15
column sid for 999999
column serial# for 999999
column spid format a10
column service_name format a15
column module format a45
column machine format a20
column logon_time format a20
column program for a30
column last_call_sec for 99999999
col module for a20

SELECT DISTINCT
    nvl(s.username, '(oracle)')                     AS username,
    s.osuser,
    s.sid,
    s.serial#,
    p.spid,
    s.lockwait,
    s.status,
    s.service_name,
    s.machine,
    s.program,
    to_char(s.logon_time, 'dd-mon-yyyy hh24:mi:ss') AS logon_time,
    s.last_call_et                                  AS last_call_et_secs,
    s.module
FROM
    gv$session              s,
    gv$process              p,
    gv$session_connect_info sci
WHERE
        s.paddr = p.addr
    AND s.sid = sci.sid
    AND s.serial# = sci.serial#
    AND s.inst_id = p.inst_id
    AND s.inst_id = sci.inst_id
    AND sci.authentication_type = 'PROXY';

set pagesize 14