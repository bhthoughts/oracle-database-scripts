-- -----------------------------------------------------------------------------------	
-- Description: MViews Mlogs
-- Run this script in the source database where the mlogs are, not mviews
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 250
SET COLSEP '|'

COL mlog_owner FOR a20
COL table_name FOR a30
COL log_name FOR a35
COL mview_id FOR 99999999
col young_mlog_rec heading 'Youngest|Mlog Refresh' format a20
col oldest_mlog_rec heading 'Oldest|Mlog Refresh' format a20
col LAST_MVIEW_REF heading 'Last Mview|Refresh' format a20
col mindiff for 99999999
col mviewowner for a20
col mviewname for a30
col hostdestino for a30

SELECT
    m.mowner                                mlog_owner,
    m.master                                table_name,
    m.log                                   log_name,
    s.snapid                                "MVIEW_ID",
    to_char(m.youngest,'DD-MON-YYYY')                              young_mlog_rec,
    to_char(m.oldest,'DD-MON-YYYY')                                oldest_mlog_rec,
    to_char(s.snaptime,'DD-MON-YYYY')                              "LAST_MVIEW_REF",
    round((sysdate - s.snaptime) * 24 * 60) mindiff,
    rs.owner                                mviewowner,
    rs.name                                 mviewname,
    rs.snapshot_site                        hostdestino
FROM
         sys.mlog$ m
    INNER JOIN sys.slog$                s ON s.mowner (+) = m.mowner
                              AND s.master (+) = m.master
    LEFT JOIN dba_registered_snapshots rs ON s.snapid = rs.snapshot_id
WHERE
        m.oldest < sysdate
    AND ( s.snaptime < oldest
          OR s.snaptime IS NULL )
ORDER BY
    s.snaptime DESC;