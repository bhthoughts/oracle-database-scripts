-- -----------------------------------------------------------------------------------	
-- Description: Tablespace size and free space
-- -----------------------------------------------------------------------------------	

SET LINESIZE 400
SET COLSEP '|'

col tablespace_name format a15
col file_size_mb format 99999999.99
col file_name format a70
col used_mb format 99999999.99
col can_save_mb format 99999999.99

SELECT
    tablespace_name,
    file_name,
    file_size       file_size_mb,
    hwm             used_mb,
    file_size - hwm can_save_mb
FROM
    (
        SELECT /*+ RULE */
            ddf.tablespace_name,
            ddf.file_name                                                 file_name,
            ddf.bytes / 1048576                                           file_size,
            ( ebf.maximum + de.blocks - 1 ) * dbs.db_block_size / 1048576 hwm
        FROM
            dba_data_files ddf,
            (
                SELECT
                    file_id,
                    MAX(block_id) maximum
                FROM
                    dba_extents
                GROUP BY
                    file_id
            )              ebf,
            dba_extents    de,
            (
                SELECT
                    value db_block_size
                FROM
                    v$parameter
                WHERE
                    name = 'db_block_size'
            )              dbs
        WHERE
                ddf.file_id = ebf.file_id
            AND de.file_id = ebf.file_id
            AND de.block_id = ebf.maximum
        ORDER BY
            1,
            2
    );