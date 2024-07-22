-- -----------------------------------------------------------------------------------
-- Description: Checking missing statistics > 12c
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 200
SET COLSEP '|'

COL STALE_STATS FOR A5
COL LAST_ANALYZED FOR A20
COL STATTYPE_LOCKED FOR A15
COL OWNER FOR A15
COL TABLE_NAME FOR A30
COL OBJECT_TYPE FOR A20
COL PARTITION_NAME FOR A30
COL SUBPARTITION_NAME FOR A30
COL SAPLE_SIZE FOR 999.999.999.999
COL NUM_ROWS FOR 999.999.999.999
COL BLOCKS FOR 999.999.999.999

SELECT
    dba_tables.owner,
    dba_tables.table_name,
    object_type,
    partition_name,
    subpartition_name,
    dba_tables.sample_size,
    dba_tables.num_rows,
    dba_tables.last_analyzed,
    stale_stats
FROM
    dba_tables
    LEFT OUTER JOIN dba_tab_statistics ON dba_tab_statistics.table_name = dba_tables.table_name
                                          AND dba_tab_statistics.owner = dba_tables.owner
WHERE
        coalesce(dba_tables.sample_size, - 1) <> coalesce(dba_tables.num_rows, - 2)
    AND dba_tab_statistics.stattype_locked IS NULL
    AND dba_tables.owner NOT IN ( 'SYS', 'SYSTEM' )
    AND coalesce(dba_tables.external, '') <> 'YES'
    AND coalesce(dba_tables.temporary, '') <> 'Y'
    AND dba_tables.table_name NOT LIKE 'DR$CS%'
    AND ( dba_tab_statistics.stale_stats IS NULL
          OR dba_tab_statistics.stale_stats = 'YES' )
    AND NOT EXISTS (
        SELECT
            1
        FROM
            dba_mview_logs
        WHERE
            dba_mview_logs.log_table = dba_tables.table_name
    )
ORDER BY
    1,
    2;

-- -----------------------------------------------------------------------------------
-- Checking missing statistics <= 12c
-- -----------------------------------------------------------------------------------

-- SELECT
--     dba_tables.owner,
--     dba_tables.table_name,
--     object_type,
--     partition_name,
--     subpartition_name,
--     dba_tables.sample_size,
--     dba_tables.num_rows,
--     dba_tables.last_analyzed,
--     stale_stats
-- FROM
--     dba_tables
--     LEFT OUTER JOIN dba_tab_statistics ON dba_tab_statistics.table_name = dba_tables.table_name
--                                           AND dba_tab_statistics.owner = dba_tables.owner
-- WHERE
--         coalesce(dba_tables.sample_size, - 1) <> coalesce(dba_tables.num_rows, - 2)
--     AND dba_tab_statistics.stattype_locked IS NULL
--     AND dba_tables.owner NOT IN ( 'SYS', 'SYSTEM' )
--     AND coalesce(dba_tables.temporary, '') <> 'Y'
--     AND dba_tables.table_name NOT LIKE 'DR$CS%'
--     AND ( dba_tab_statistics.stale_stats IS NULL
--           OR dba_tab_statistics.stale_stats = 'YES' )
--     AND NOT EXISTS (
--         SELECT
--             table_name
--         FROM
--             dba_external_tables ext
--         WHERE
--                 ext.owner = dba_tables.owner
--             AND ext.table_name = dba_tables.table_name
--     )
-- ORDER BY
--     1,
--     2;
