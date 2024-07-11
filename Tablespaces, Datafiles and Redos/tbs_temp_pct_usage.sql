-- -----------------------------------------------------------------------------------	
-- Description: Temp percent usage
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col percent_used for 999.99

SELECT
    ( s.tot_used_blocks / f.total_blocks ) * 100 AS "percent_used"
FROM
    (
        SELECT
            SUM(used_blocks) tot_used_blocks
        FROM
            v$sort_segment
        WHERE
            tablespace_name = 'TEMP'
    ) s,
    (
        SELECT
            SUM(blocks) total_blocks
        FROM
            dba_temp_files
        WHERE
            tablespace_name = 'TEMP'
    ) f;