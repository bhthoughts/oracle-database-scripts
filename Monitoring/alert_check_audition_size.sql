-- -----------------------------------------------------------------------------------	
-- Type.......: Alert
-- Execute per: Database
-- Description: Monitoring the audit object size consumption. 
-- Datatype...: NUMBER (Float)
-- Rules......: You can configure a size to alert based on your environment, there is no golden rule for the threshold.
-- Threshold..: Depend on your environment
-- Frequency..: Each 15 minutes
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col size_gb for 999,999,999,999.99

SELECT
    owner,
    round(SUM(bytes) /(1024 * 1024 * 1024), 2) AS size_gb
FROM
    dba_segments
WHERE
    segment_name = 'AUD$'
GROUP BY
    owner;