-- -----------------------------------------------------------------------------------
-- Description: Check session running long operations
-- -----------------------------------------------------------------------------------

SET LINE 200
SET PAGESIZE 100
SET COLSEP '|'

col inst_id format 9999 head 'INST|ID'
col pctdone format a7
col opname format a20
col sofar format 99,999,999,999,999
col totalwork format 99,999,999,999,999
col target format a20
col target_desc format a10
col username format a10
col units format a10
col time_remaining format a10 head 'TIME|REMAIN|MINUTES'
col start_time format a22 head 'START TIME'
col message format a25

select
        -- sid
        inst_id
        , username
        , opname
        , target
        , sofar
        , totalwork
        , to_char((sofar / totalwork) * 100,'90.0')||'%' pctdone
        , units
        , substr('00'||to_char(trunc(time_remaining/60)),-2,2)
                || ':'
                || substr('00'||to_char(mod(time_remaining,60)),-2,2)
                time_remaining
        , start_time
        , message
from gv$session_longops
where time_remaining > 0
order by username
/