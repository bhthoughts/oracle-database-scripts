-- -----------------------------------------------------------------------------------	
-- Description: Check MViews with delay
-- Run this script in the database where the mviews are
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 250
SET COLSEP '|'

col owner for a15
col mview_name for a30
col refgroup for a25
col group_owner for a25
col group_name for a25
col fast_refreshable for a30
col last_refresh_type for a15
col refresh_mode for a15
col last_refresh_date for a20
col mindiff for 99999999

SELECT
    *
FROM
    (
        SELECT
            m.owner,
            m.mview_name,
            c.refgroup,
            g.owner                                               group_owner,
            g.name                                                group_name,
            m.fast_refreshable,
            m.last_refresh_type,
            m.refresh_mode,
            to_char(m.last_refresh_date, 'dd/mm/yyyy hh24:mi:ss') last_refresh_date,
            round((sysdate - m.last_refresh_date) * 24 * 60)      mindiff
        FROM
            dba_rchild c,
            dba_rgroup g,
            dba_mviews m
        WHERE
                c.refgroup = g.refgroup (+)
            AND c.owner (+) = m.owner
            AND c.name (+) = m.mview_name
    --AND g.name LIKE '%%'
        ORDER BY
            m.last_refresh_date,
            m.last_refresh_type
    )
WHERE
    mindiff > 5;
    