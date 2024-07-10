-- -----------------------------------------------------------------------------------
-- Description: Check tablespace quotas used
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 200
SET COLSEP '|'

col TABLESPACE_NAME for a15
col USERNAME for a20
col MB for 9999999,99
col MAX_MB for 9999999,99
col BLOCKS for 9999999
col MAX_BLOCKS for 9999999
col DROPPED for a5

SELECT
    tablespace_name,
    username,
    bytes / 1024 / 1024     mb,
    max_bytes / 1024 / 1024 max_mb,
    blocks,
    max_blocks,
    dropped
FROM
    dba_ts_quotas
WHERE
    username = :username;