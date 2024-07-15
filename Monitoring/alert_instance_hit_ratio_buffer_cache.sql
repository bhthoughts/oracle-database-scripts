-- -----------------------------------------------------------------------------------	
-- Type.......: Alert
-- Execute per: Instance
-- Description: Monitor the database buffer cache Hit Ratio metric
-- Datatype...: NUMBER (Float) 
-- Rules......: As close to 100, better. It means that the current buffer cache configuration is handling the workload
-- Threshold..: 95 -- If lower than this, consider to run an buffer cache advisor
-- Frequency..: Each 1 hour
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200

col hitratio for 999.99

SELECT
    round((congets.value + dbgets.value - physreads.value) * 100 /(congets.value + dbgets.value), 2) hitratio
FROM
    v$sysstat congets,
    v$sysstat dbgets,
    v$sysstat physreads
WHERE
        congets.name = 'consistent gets'
    AND dbgets.name = 'db block gets'
    AND physreads.name = 'physical reads';