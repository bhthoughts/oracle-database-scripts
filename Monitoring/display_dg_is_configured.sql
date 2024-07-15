-- -----------------------------------------------------------------------------------	
-- Type.......: Display
-- Execute per: Database
-- Description: Check if the database has a standby configured
-- Datatype...: VARCHAR
-- Rules......: N/A
-- Threshold..: N/A
-- Frequency..: Each 1 hour
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col status for a5

SELECT
    CASE
        WHEN standby_status > 0 THEN
            'YES'
        ELSE
            'NO'
    END status
FROM
    (
        SELECT
            coalesce((
                SELECT
                    1
                FROM
                    v$archive_dest_status t
                WHERE
                    database_mode LIKE '%STANDBY%'
                    AND status = 'VALID'
            ), - 1) standby_status
        FROM
            dual
    );