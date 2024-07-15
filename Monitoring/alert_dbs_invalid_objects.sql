-- -----------------------------------------------------------------------------------	
-- Type.......: Alert
-- Execute per: Database
-- Description: Monitoring the invalid objects of the user schemas.
-- Datatype...: NUMBER (Int)
-- Rules......: Invalid objects, does not consider Oracle internal schemas
-- Threshold..: 1
-- Frequency..: Each 10 minutes
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col invalid_objs for 999999

SELECT
    COUNT(*) invalid_objs
FROM
    dba_objects
WHERE
        status != 'VALID'
    AND owner IN ( 
        SELECT
            username
        FROM
            dba_users
        WHERE
            oracle_maintained = 'N' );