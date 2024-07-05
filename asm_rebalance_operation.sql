-- -----------------------------------------------------------------------------------	
-- Description: Check asm rebalance operation
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col group_number for 99999999
col operation for a5
col state for a5
col power for 99999999
col actual for 99999999
col sofar for 99999999
col est_work for 99999999
col est_rate for 99999999
col est_minutes for 99999999

SELECT
    t.*
FROM
    v$asm_operation t;