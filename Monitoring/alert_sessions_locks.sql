-- -----------------------------------------------------------------------------------	
-- Type.......: Alert
-- Execute per: Instance
-- Description: Monitoring of sessions facing locks for more than 1 minute. 
-- Datatype...: NUMBER (Float)
-- Rules......: Configured to alert after 60 seconds of wait, you can change in the commented line.
-- Threshold..: 1
-- Frequency..: Each 5 minutes
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col locks for 99999

SELECT
    COUNT(*) qnt
FROM
    gv$lock    l1,
    gv$session s1,
    gv$lock    l2,
    gv$session s2
WHERE
        s1.sid = l1.sid
    AND s2.sid = l2.sid
    AND l1.block = 1
    AND l2.request > 0
    AND l1.id1 = l2.id1
    AND l2.id2 = l2.id2
    AND s2.seconds_in_wait > 60;