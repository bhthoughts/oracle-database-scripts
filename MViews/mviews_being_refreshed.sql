-- -----------------------------------------------------------------------------------	
-- Description: MViews being refreshed
-- Run this script in the database where the mviews are
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col "MVIEW BEING REFRESHED" for a30
col reftype for a15
col state for a15
col inserts for 99999999999
col updates for 99999999999
col deletes for 99999999999

SELECT
    currmvowner_knstmvr
    || '.'
    || currmvname_knstmvr          "MVIEW BEING REFRESHED",
    decode(reftype_knstmvr, 1, 'FAST', 2, 'COMPLETE',
           'UNKNOWN')              reftype,
    decode(groupstate_knstmvr, 1, 'SETUP', 2, 'INSTANTIATE',
           3, 'WRAPUP', 'UNKNOWN') state,
    total_inserts_knstmvr          inserts,
    total_updates_knstmvr          updates,
    total_deletes_knstmvr          deletes
FROM
    x$knstmvr x
WHERE
    EXISTS (
        SELECT
            1
        FROM
            v$session s
        WHERE
                s.sid = x.sid_knst
            AND s.serial# = x.serial_knst
    );