-- -----------------------------------------------------------------------------------	
-- Type.......: Alert
-- Execute per: Database
-- Description: Monitoring of user sequences hitting the threshold. It already discarts the cycling sequences.
-- Datatype...: NUMBER (Int)
-- Rules......: N/A
-- Threshold..: 1
-- Frequency..: Each 1 hour
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

SELECT
    COUNT(*) qnt
FROM
    (
        SELECT /*+  NO_MERGE  */
            s.sequence_owner
            || '.'
            || s.sequence_name,
            s.last_number,
            s.max_value,
            round(100 *(s.last_number - s.min_value) / greatest((s.max_value - s.min_value), 1),
                  1) percent_used
        FROM
            dba_sequences s
        WHERE
            s.sequence_owner IN (
                SELECT
                    username
                FROM
                    dba_users
                WHERE
                    oracle_maintained = 'N'
            )
            AND s.max_value > 0
            AND cycle_flag = 'N'
            AND round(100 *(s.last_number - s.min_value) / greatest((s.max_value - s.min_value), 1),
                      1) > 85 -- this is the threshold
    );