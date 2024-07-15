-- -----------------------------------------------------------------------------------	
-- Type.......: Alert
-- Execute per: Database
-- Description: Monitoring of old snapshots from Statspack - It can be useful to make sure your cleanup job is working fine. You can change from 61 days to whatever works better for you
-- Datatype...: NUMBER (Int)
-- Rules......: It will only work if you have statspack installed. It will return if there are snaps older than 60 days. It can get issues with the purge job for example
-- Threshold..: 1
-- Frequency..: Each 24 hours
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col old_snaps for 99999

SELECT
    COUNT(*) old_snaps
FROM
    stats$snapshot
WHERE
    snap_time < sysdate - 61;