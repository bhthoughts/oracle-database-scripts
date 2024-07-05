-- -----------------------------------------------------------------------------------	
-- Description: MViews refresh sessions - script to kill the current refresh
-- Run this script in the database where the mviews are
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

COL script FOR a200

SELECT DISTINCT
    script
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
            to_char(m.last_refresh_date, 'dd/mm/yyyy hh24:mi:ss') last_refresh_date,
            j.job_name,
            'alter system kill session '''
            || sid
            || ','
            || serial#
            || ''' immediate; /* '
            || m.owner
            || '.'
            || m.mview_name
            || ' */'                                              script
        FROM
                 dba_rchild c
            INNER JOIN dba_rgroup                 g ON c.refgroup = g.refgroup
            INNER JOIN dba_mviews                 m ON c.owner = m.owner
                                       AND c.name = m.mview_name
            LEFT JOIN dba_scheduler_running_jobs j ON j.job_name = g.job_name
            LEFT JOIN v$session                  s ON s.sid = j.session_id
        WHERE
            round((sysdate - m.last_refresh_date) * 24 * 60) > 5
        ORDER BY
            g.name,
            m.last_refresh_date,
            m.last_refresh_type
    );