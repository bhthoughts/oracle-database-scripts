-- -----------------------------------------------------------------------------------
-- Description: Checking missing statistics >= 12c
-- -----------------------------------------------------------------------------------

SET COLSEP '|'

COL STALE_STATS FOR A5
COL LAST_ANALYZED FOR A20
COL STATTYPE_LOCKED FOR A15
COL OWNER FOR A15
COL TABLE_NAME FOR A30
COL OBJECT_TYPE FOR A20
COL PARTITION_NAME FOR A30
COL SUBPARTITION_NAME FOR A30
COL NUM_ROWS FOR 999.999.999.999
COL BLOCKS FOR 999.999.999.999

SELECT
    stale_stats,
    to_char(last_analyzed, 'DD-MON-YYYY HH24:mi:SS') last_analyzed,
    stattype_locked,
    owner,
    table_name,
    object_type,
    partition_name,
    subpartition_name,
    num_rows,
    blocks
FROM
    dba_tab_statistics s
WHERE	
    ( stale_stats = 'YES'
      OR last_analyzed IS NULL )
    AND owner IN (
        SELECT
            username
        FROM
            dba_users
        WHERE
            oracle_maintained = 'N'
    )
    AND stattype_locked IS NULL
ORDER BY
    num_rows DESC;

-- -----------------------------------------------------------------------------------
-- Checking missing statistics < 12c
-- -----------------------------------------------------------------------------------
-- 
-- COL STALE_STATS FOR A5
-- COL LAST_ANALYZED FOR A20
-- COL STATTYPE_LOCKED FOR A15
-- COL OWNER FOR A15
-- COL TABLE_NAME FOR A30
-- COL OBJECT_TYPE FOR A20
-- COL PARTITION_NAME FOR A30
-- COL SUBPARTITION_NAME FOR A30
-- COL NUM_ROWS FOR 999.999.999.999
-- COL BLOCKS FOR 999.999.999.999
-- 
-- SELECT
--     stale_stats,
--     to_char(last_analyzed, 'DD-MON-YYYY HH24:mi:SS') last_analyzed,
--     stattype_locked,
--     owner,
--     table_name,
--     object_type,
--     partition_name,
--     subpartition_name,
--     num_rows,
--     blocks
-- FROM
--     dba_tab_statistics s
-- WHERE
--     ( stale_stats = 'YES'
--       OR last_analyzed IS NULL )
--     AND owner NOT IN ( 'QS_CB', 'PERFSTAT', 'QS_ADM', 'PM', 'SH',
--                        'HR', 'OE', 'ODM_MTR', 'WKPROXY', 'ANONYMOUS',
--                        'OWNER', 'SYS', 'SYSTEM', 'SCOTT', 'SYSMAN',
--                        'XDB', 'DBSNMP', 'EXFSYS', 'OLAPSYS', 'MDSYS',
--                        'WMSYS', 'WKSYS', 'DMSYS', 'ODM', 'EXFSYS',
--                        'CTXSYS', 'LBACSYS', 'ORDPLUGINS', 'SQLTXPLAIN', 'OUTLN',
--                        'TSMSYS', 'XS$NULL', 'TOAD', 'STREAM', 'SPATIAL_CSW_ADMIN',
--                        'SPATIAL_WFS_ADMIN', 'SI_INFORMTN_SCHEMA', 'QS', 'QS_CBADM', 'QS_CS',
--                        'QS_ES', 'QS_OS', 'QS_WS', 'PA_AWR_USER', 'OWBSYS_AUDIT',
--                        'OWBSYS', 'ORDSYS', 'ORDDATA', 'ORACLE_OCM', 'MGMT_VIEW',
--                        'MDDATA', 'FLOWS_FILES', 'FLASHBACK', 'AWRUSER', 'APPQOSSYS',
--                        'APEX_PUBLIC_USER', 'APEX_030200', 'FLOWS_020100', 'AUDSYS', 'GSMADMIN_INTERNAL',
--                        'DVSYS', 'OJVMSYS', 'DBSFWUSER' )
--     AND stattype_locked IS NULL
-- ORDER BY
--     num_rows DESC;