-------------------	
-- Redo log frequency map
-------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

COL object_type FOR a20
COL date FOR a20
COL status FOR a20

SELECT
    *
FROM
    (
        SELECT
            object_type,
            to_char(end_time, 'DD-MON-YYYY hh24:mi:ss') "DATE",
            status
        FROM
            v$rman_status s
        WHERE
                operation = 'BACKUP'
            AND object_type = 'DB INCR'
        ORDER BY
            start_time DESC
    )
WHERE
    ROWNUM = 1
UNION
SELECT
    *
FROM
    (
        SELECT
            object_type,
            to_char(end_time, 'DD-MON-YYYY hh24:mi:ss') "DATE",
            status
        FROM
            v$rman_status s
        WHERE
                operation = 'BACKUP'
            AND object_type = 'ARCHIVELOG'
        ORDER BY
            start_time DESC
    )
WHERE
    ROWNUM = 1
UNION
SELECT
    *
FROM
    (
        SELECT
            object_type,
            to_char(end_time, 'DD-MON-YYYY hh24:mi:ss') "DATE",
            status
        FROM
            v$rman_status s
        WHERE
                operation = 'BACKUP'
            AND object_type = 'DB FULL'
        ORDER BY
            start_time DESC
    )
WHERE
    ROWNUM = 1
UNION
SELECT
    *
FROM
    (
        SELECT
            'CONTROL FILE',
            to_char(end_time, 'DD-MON-YYYY hh24:mi:ss') "DATE",
            status
        FROM
            v$rman_status s
        WHERE
            ( operation = 'BACKUP'
              AND object_type = 'CONTROLFILE' )
            OR operation = 'CONTROL FILE AND SPFILE AUTOBACK'
        ORDER BY
            start_time DESC
    )
WHERE
    ROWNUM = 1;