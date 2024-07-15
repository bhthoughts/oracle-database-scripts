-- -----------------------------------------------------------------------------------
-- Type.......: Display
-- Execute per: Instance
-- Description: Check the cpu count parameter
-- Datatype...: NUMBER (Int)
-- Rules......: N/A
-- Threshold..: N/A
-- Frequency..: Each 24 hours
-- -----------------------------------------------------------------------------------

SET LINESIZE 200

col cpu for 999

select
   value cpu
from
   v$parameter
where
   name like '%cpu_count%';