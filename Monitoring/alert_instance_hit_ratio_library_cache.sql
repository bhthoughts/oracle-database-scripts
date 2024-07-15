-- -----------------------------------------------------------------------------------	
-- Type.......: Alert 
-- Execute per: Instance
-- Description: Monitor the library cache Hit Ratio metric
-- Datatype...: NUMBER (Float)
-- Rules......: As close to 100, better. It means that the current library cache configuration is handling the workload
-- Threshold..: 95 -- If lower than this, consider to run an library cache advisor
-- Frequency..: Each 1 hour
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200

COL hitratio FOR 999.99

SELECT
    round((SUM(pins) /(SUM(pins) + SUM(reloads))) * 100, 2) hitratio
FROM
    v$librarycache;