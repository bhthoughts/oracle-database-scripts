-- -----------------------------------------------------------------------------------	
-- Type.......: Alert
-- Execute per: Instance
-- Description: Monitoring of usage of the redo logs. 
-- Datatype...: NUMBER (Float)
-- Rules......: N/A
-- Threshold..: 80 %
-- Frequency..: Each 10 minutes
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col pct_used for 999.99

SELECT
    round(((active * 100) / percent), 2) pct_used
FROM
    (
        SELECT
            (
                SELECT
                    COUNT(*)
                FROM
                    v$log
                WHERE
                    status = 'ACTIVE'
            ) AS "ACTIVE",
            (
                SELECT
                    COUNT(*) - 1
                FROM
                    v$log
            ) AS "PERCENT" -- 100%;
        FROM
            dual
    );