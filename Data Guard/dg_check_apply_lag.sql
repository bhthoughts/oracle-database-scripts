-- -----------------------------------------------------------------------------------	
-- Description: Check apply lag status
-- Can be executed on both Primary and Standby
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col gap_minutes for 99999999

SELECT
    case when max_curlog.seq > max_transplog.seq+1 then 
    round((arch.first_time - appl.first_time) * 24 * 60) else 0 end gap_minutes
-- , ARCH.THREAD# "Thread", ARCH.SEQUENCE# "Last in Sequence", APPL.SEQUENCE# "Last Applied Sequence", (ARCH.SEQUENCE# - APPL.SEQUENCE#) "Difference"
FROM
    -- Last sequence archived in Primary Database
    (
        SELECT
            MAX(first_time) first_time,
            thread#,
            dest_id
        FROM
            v$archived_log a
        WHERE
            dest_id = (
                SELECT
                    dest_id
                FROM
                    v$archive_dest
                WHERE
                        target = 'STANDBY'
                    AND status = 'VALID'
            )
        GROUP BY
            thread#,
            dest_id
    ) arch,
    -- Last sequence applied in Standby
    (
        SELECT
            MAX(first_time) first_time,
            thread#,
            dest_id
        FROM
            v$archived_log a
        WHERE
            dest_id = (
                SELECT
                    dest_id
                FROM
                    v$archive_dest
                WHERE
                        target = 'STANDBY'
                    AND status = 'VALID'
            )
            and applied = 'YES'
        GROUP BY
            thread#,
            dest_id
    ) appl,
(select max(sequence#) seq from v$log) max_curlog ,
(select max(sequence#) seq from v$archived_log where dest_id = (
                SELECT
                    dest_id
                FROM
                    v$archive_dest
                WHERE
                        target = 'STANDBY'
                    AND status = 'VALID'
            )and applied='YES') max_transplog
WHERE
        arch.thread# = appl.thread#
    AND arch.dest_id = appl.dest_id
ORDER BY
    1;
