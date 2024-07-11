-- -----------------------------------------------------------------------------------	
-- Description: MViews refresh timing
-- Run this script in the database where the mviews are
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

COL run_owner FOR a20
COL mviews FOR a50
COL start_time FOR a20
COL method FOR a15
COL refresh_after_errors FOR a5
COL elapsed_time FOR 99999999

SELECT
    run_owner,
    mviews,
    to_char(start_time, 'DD-MON-YYYY hh24:mi:ss') start_time,
    method,
    t.refresh_after_errors,
    elapsed_time
FROM
    dba_mvref_run_stats t
WHERE
    trunc(start_time) > sysdate - 2
ORDER BY
    elapsed_time DESC;