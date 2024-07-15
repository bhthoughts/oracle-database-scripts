-- -----------------------------------------------------------------------------------	
-- Type.......: Alert
-- Execute per: Database
-- Description: Monitoring of dataguard lag status. It will return how many minutes it`s old than prod.
-- Datatype...: NUMBER (Int)
-- Rules......: N/A
-- Threshold..: 5
-- Frequency..: Each 5 minutes
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col gap_minutes for 9999

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
    arch.thread# = appl.thread#;