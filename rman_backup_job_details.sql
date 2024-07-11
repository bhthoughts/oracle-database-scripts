-- -----------------------------------------------------------------------------------
-- Description: RMAN job backup details
-- -----------------------------------------------------------------------------------

SET LINES 220
SET PAGES 1000
SET COLSEP '|'

COL cf FOR 9, 999
COL df FOR 9, 999
COL elapsed_seconds HEADING "ELAPSED|SECONDS" for 999,999,999.99
COL i0 FOR 9, 999
COL i1 FOR 9, 999
COL l FOR 9, 999
COL output_mbytes FOR 9, 999, 999 HEADING "OUTPUT|MBYTES"
COL session_recid FOR 999999 HEADING "SESSION|RECID"
COL session_stamp FOR 99999999999 HEADING "SESSION|STAMP"
COL status FOR a10 TRUNC
COL time_taken_display FOR a10 HEADING "TIME|TAKEN"
COL output_instance FOR 9999 HEADING "OUT|INST"

SELECT
    j.session_recid,
    j.session_stamp,
    to_char(j.start_time, 'yyyy-mm-dd hh24:mi:ss') start_time,
    to_char(j.end_time, 'yyyy-mm-dd hh24:mi:ss')   end_time,
    ( j.output_bytes / 1024 / 1024 )               output_mbytes,
    j.status,
    j.input_type,
    decode(to_char(j.start_time, 'd'), 1, 'Sunday', 2, 'Monday',
           3, 'Tuesday', 4, 'Wednesday', 5,
           'Thursday', 6, 'Friday', 7, 'Saturday') dow,
    j.elapsed_seconds,
    j.time_taken_display,
    x.cf,
    x.df,
    x.i0,
    x.i1,
    x.l,
    ro.inst_id                                     output_instance
FROM
    v$rman_backup_job_details j
    LEFT OUTER JOIN (
        SELECT
            d.session_recid,
            d.session_stamp,
            SUM(
                CASE
                    WHEN d.controlfile_included = 'YES' THEN
                        d.pieces
                    ELSE
                        0
                END
            ) cf,
            SUM(
                CASE
                    WHEN d.controlfile_included = 'NO'
                         AND d.backup_type || d.incremental_level = 'D' THEN
                        d.pieces
                    ELSE
                        0
                END
            ) df,
            SUM(
                CASE
                    WHEN d.backup_type || d.incremental_level = 'D0' THEN
                        d.pieces
                    ELSE
                        0
                END
            ) i0,
            SUM(
                CASE
                    WHEN d.backup_type || d.incremental_level = 'I1' THEN
                        d.pieces
                    ELSE
                        0
                END
            ) i1,
            SUM(
                CASE
                    WHEN d.backup_type = 'L' THEN
                        d.pieces
                    ELSE
                        0
                END
            ) l
        FROM
                 v$backup_set_details d
            JOIN v$backup_set s ON s.set_stamp = d.set_stamp
                                   AND s.set_count = d.set_count
        WHERE
            s.input_file_scan_only = 'NO'
        GROUP BY
            d.session_recid,
            d.session_stamp
    )                         x ON x.session_recid = j.session_recid
           AND x.session_stamp = j.session_stamp
    LEFT OUTER JOIN (
        SELECT
            o.session_recid,
            o.session_stamp,
            MIN(inst_id) inst_id
        FROM
            gv$rman_output o
        GROUP BY
            o.session_recid,
            o.session_stamp
    )                         ro ON ro.session_recid = j.session_recid
            AND ro.session_stamp = j.session_stamp
WHERE
    j.start_time > trunc(sysdate) - &number_of_days
ORDER BY
    j.start_time;