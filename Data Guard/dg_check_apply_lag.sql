-- -----------------------------------------------------------------------------------	
-- Description: Check apply lag status
-- Can be executed on both Primary and Standby
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col gap_minutes for 99999999

SELECT
    round((arch.first_time - appl.first_time) * 24 * 60) gap_minutes
-- , ARCH.THREAD# "Thread", ARCH.SEQUENCE# "Last in Sequence", APPL.SEQUENCE# "Last Applied Sequence", (ARCH.SEQUENCE# - APPL.SEQUENCE#) "Difference"
FROM
    (
        SELECT DISTINCT
            thread#,
            sequence#,
            first_time
        FROM
            v$archived_log
        WHERE
            ( thread#, first_time ) IN (
                SELECT
                    thread#, MAX(first_time)
                FROM
                    v$archived_log
                GROUP BY
                    thread#
            )
    ) arch,
    (
        SELECT DISTINCT
            thread#,
            sequence#,
            first_time
        FROM
            v$log_history
        WHERE
            ( thread#, first_time ) IN (
                SELECT
                    thread#, MAX(first_time)
                FROM
                    v$log_history
                GROUP BY
                    thread#
            )
    ) appl
WHERE
    arch.thread# = appl.thread#
ORDER BY
    1;