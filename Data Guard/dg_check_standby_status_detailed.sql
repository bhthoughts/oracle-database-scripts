-- -----------------------------------------------------------------------------------
-- Description: Check the standby status - Detailed view.
-- Can be executed on Primary 
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 200
SET COLSEP '|'

col Thread for 999
col Last_Sequence_Received heading 'Last Sequence|Received' format 9999999999
col Last_Sequence_Transported heading 'Last Sequence|Transported' format 9999999999
col Last_Sequence_Applied heading 'Last Sequence|Applied' format 9999999999
col Transport-Gap heading 'Transport|Gap' format 9999999999
col Apply-Gap heading 'Apply|Gap' format 9999999999

SELECT distinct
    arch.thread#                          "Thread",
    arch.sequence#                        "Last_Sequence_Received",
    transp.sequence#                      "Last_Sequence_Transported",
    appl.sequence#                        "Last_Sequence_Applied",
    ( arch.sequence# - transp.sequence# ) "Transport-Gap",
    ( arch.sequence# - appl.sequence# )   "Apply-Gap"
FROM
    (
        SELECT
            thread#,
            sequence#
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
        SELECT
            thread#,
            sequence#
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
    ) transp
    ,
    (
        SELECT
            thread#,
            sequence#
        FROM
            v$archived_log
        WHERE
            ( thread#, first_time ) IN (
                SELECT
                    thread#, min(first_time)
                FROM
                    v$archived_log
                WHERE 
                    applied = 'NO'
                GROUP BY
                    thread#
            )
    ) appl
WHERE
    arch.thread# = appl.thread#
    and appl.thread# = transp.thread#
ORDER BY
    1;
				