-- -----------------------------------------------------------------------------------	
-- Description: List sessions to kill
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col cmd for a80
col username for a15
col osuser for a20
col machine for a20
col program for a20
col status for a10

SELECT
    'alter system kill session '''
    || sid
    || ','
    || serial#
    || ''' immediate;' cmd,
    username, osuser, machine, program, status
FROM
    v$session
WHERE
    username = '&username';