-- -----------------------------------------------------------------------------------
-- Description: SGA Advisor
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 200
SET COLSEP '|'

col sga_size for 99999999
col sga_size_factor for 999.99
col db_time for 99999999
col db_time_factor for 999.99
col physical_reads for 99999999
col buffer_cache_size for 99999999
col shared_pool_size for 99999999

SELECT
    sga_size,
    sga_size_factor,
    estd_db_time           db_time,
    estd_db_time_factor    db_time_factor,
    estd_physical_reads    physical_reads,
    estd_buffer_cache_size buffer_cache_size,
    estd_shared_pool_size  shared_pool_size
FROM
    v$sga_target_advice
ORDER BY
    sga_size ASC;