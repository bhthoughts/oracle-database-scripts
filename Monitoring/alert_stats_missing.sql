-- -----------------------------------------------------------------------------------
-- Type.......: Alert
-- Execute per: Database
-- Description: Monitoring missing statistics >= 12c, for lower versions you need to specify the schemas you don`t want to check, instead the use of dba_users.oracle_maintained column
-- Datatype...: NUMBER (Int)
-- Rules......: Checking for STALE, or EMPTY stats, considering only tables created from two days behind until now, to not generate alert after an application release/patch
-- ...........: With that information you can know when to create an exception gather stats rules for specific tables
-- Threshold..: 1
-- Frequency..: Each 10 minutes
-- -----------------------------------------------------------------------------------

SET COLSEP '|'

COL stale_stats FOR a5
COL last_analyzed FOR a20
COL stattype_locked FOR a15
COL owner FOR a15
COL table_name FOR a30
COL object_type FOR a20
COL partition_name FOR a30
COL subpartition_name FOR a30
COL num_rows FOR 999.999.999.999
COL BLOCKS FOR 999.999.999.999
COL missing_stats for 99999

select count (*) missing_stats from (
SELECT
    s.stale_stats,
    to_char(s.last_analyzed, 'DD-MON-YYYY HH24:mi:SS') last_analyzed,
    s.stattype_locked,
    s.owner,
    s.table_name,
    s.object_type,
    s.partition_name,
    s.subpartition_name,
    s.num_rows,
    s.blocks
FROM
         dba_tab_statistics s
    JOIN dba_tables  t ON t.owner = s.owner
                         AND t.table_name = s.table_name
    JOIN dba_objects o ON o.owner = t.owner
                          AND o.object_name = t.table_name
WHERE
    ( s.stale_stats = 'YES'
      OR s.last_analyzed IS NULL )
    AND s.owner IN (
        SELECT
            username
        FROM
            dba_users
        WHERE
            oracle_maintained = 'N'
    )
        AND stattype_locked IS NULL
            AND o.created < sysdate - 2 -- Not list recent created tables
                AND s.owner NOT LIKE 'ORA$%'
                    AND s.table_name NOT LIKE '%$%'
                        AND t.duration IS NULL
);