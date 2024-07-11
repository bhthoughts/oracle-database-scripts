-- -----------------------------------------------------------------------------------
-- Description: List current session id
-- -----------------------------------------------------------------------------------

SET COLSEP '|'

col sid for 999999
col serial# for 999999

SELECT
    sid,
    serial#
FROM
    sys.v_$session
WHERE
    sid = (
        SELECT DISTINCT
            sid
        FROM
            sys.v_$mystat
    );
