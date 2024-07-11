-- -----------------------------------------------------------------------------------
-- Description: Buffer Cache Advisor
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 200
SET COLSEP '|'

col size_for_estimate for 99999999
col buffers_for_estimate for 99999999
col estd_physical_read_factor for 99999999.99
col estd_physical_reads for 99999999

SELECT
    size_for_estimate,
    buffers_for_estimate,
    estd_physical_read_factor,
    estd_physical_reads
FROM
    v$db_cache_advice
WHERE
    block_size = (
        SELECT
            value
        FROM
            v$parameter
        WHERE
            name = 'db_block_size'
    );