-- -----------------------------------------------------------------------------------	
-- Type.......: Alert
-- Execute per: Instance
-- Description: Monitoring the database workload based in the archives generated in the last 10 minutes.
-- Datatype...: NUMBER (Int)
-- Rules......: N/A
-- Threshold..: Depending on your environment
-- Frequency..: Each 5 minutes
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col bytes for 999,999,999,999,999,999

SELECT
    SUM(total_bytes) bytes
FROM
    (
        SELECT
            trunc(completion_time, 'MI') - mod(CAST(to_char(completion_time, 'mi') AS INT), 10) / 1440 periodo,
            COUNT(*)                                                                                   quantidade,
            round(SUM(blocks * block_size))                                                            total_bytes
        FROM
            v$archived_log
        WHERE
            to_char(completion_time, 'YYYY/MM/DD') = to_char(sysdate, 'YYYY/MM/DD')
        GROUP BY
            trunc(completion_time, 'MI') - mod(CAST(to_char(completion_time, 'mi') AS INT), 10) / 1440
        ORDER BY
            1
    ) t1
GROUP BY
    to_char(periodo, 'DD/MM/YYYY');