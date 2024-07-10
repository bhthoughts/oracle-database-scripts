-- -----------------------------------------------------------------------------------
-- Description: List the binds used to run a SQL by a connected session - It queries the shared pool
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 250
SET COLSEP '|'

col inst_id					for 999
col sid                      for 999999
col serial#                  for 999999
col username                 for a15
col status                   for a8
col osuser                   for a15
col machine                  for a20
col program                  for a20
col sql_id                   for a20
col hash_value               for 999999999999
col child_number             for 999999
col name                     for a15
col position                 for 999999
col datatype_string          for a10
col was_captured             for a5
col last_captured            for a20
col value_string             for a15

select se.inst_id,
       se.sid,
       se.serial#,
       se.username,
       se.status,
       se.osuser,
       se.machine,
       se.program,
       sb.sql_id,
       sb.hash_value,
       sb.child_number,
       sb.name,
       sb.position,
       sb.datatype_string,
       sb.was_captured,
       sb.last_captured,
       sb.value_string
from gv$sql_bind_capture sb, gv$session se
where sb.address = se.sql_address
and sb.hash_value = se.sql_hash_value
and sb.inst_id = se.inst_id
--and sb.sql_id=''
--and sb.hash_value = '1737645343'
--and sb.child_number = 0
order by se.sql_exec_id,sb.name,sb.position; 