-- -----------------------------------------------------------------------------------
-- Description: Quantity of session by user, and the limit of the user profile
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 200
SET COLSEP '|'

col username for a15
col limit for a15

SELECT
    t.*,
    (
        SELECT DISTINCT
            pf.limit
        FROM
                 dba_users us
            INNER JOIN dba_profiles pf ON us.profile = pf.profile
        WHERE
                us.username = t.username
            AND pf.resource_name = 'SESSIONS_PER_USER'
    ) limit
FROM
    (
        SELECT
            username,
            status
        FROM
            gv$session
    ) PIVOT (
        COUNT(*)
        FOR status
        IN ( 'ACTIVE',
        'INACTIVE' )
    )
    t;