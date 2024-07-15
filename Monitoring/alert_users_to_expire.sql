-- -----------------------------------------------------------------------------------	
-- Type.......: Alert
-- Execute per: Database
-- Description: Monitoring the users that are about to expire. It will list the number of users that will expire in the next 30 days. You can change the threshold in the commented line.
-- Datatype...: NUMBER (Int)
-- Rules......: Opened accounts that will expire in the next 30 days.
-- Threshold..: 1
-- Frequency..: Each 24 hours
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

COL users FOR 999999

SELECT
    COUNT(*) users
FROM
    dba_users
WHERE
        account_status = 'OPEN'
    AND expiry_date BETWEEN sysdate AND sysdate + 30 -- Threshold 
	;