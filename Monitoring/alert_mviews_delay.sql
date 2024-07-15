-- -----------------------------------------------------------------------------------
-- Type.......: Alert
-- Execute per: Database
-- Description: MOnitoring the MViews with delay. Return the number of MViews with a delay bigger than 24 hours. You can change this number in the query.
-- Datatype...: NUMBER (Int)
-- Rules......: N/A
-- Threshold..: 5
-- Frequency..: Each 5 minutes
-- -----------------------------------------------------------------------------------

SET LINESIZE 200

col delay for 99999

SELECT
    COUNT(*) delay
FROM
    (
        SELECT
            round((sysdate - m.last_refresh_date) * 24 * 60) mindiff
        FROM
            dba_rchild c,
            dba_rgroup g,
            dba_mviews m
        WHERE
                c.refgroup = g.refgroup (+)
            AND c.owner (+) = m.owner
            AND c.name (+) = m.mview_name
            AND m.owner IN (
                SELECT
                    username
                FROM
                    dba_users
                WHERE
                    oracle_maintained = 'N'
            )
    )
WHERE
    mindiff > 1440; -- 24 hours