-- -----------------------------------------------------------------------------------	
-- Description: Find the segment by using the block id
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col owner for a20
col segment_name for a30
col segment_type for a20

SELECT
    owner
    segment_name,
    segment_type
FROM
    dba_extents
WHERE
        file_id = &__file
    AND &__block BETWEEN block_id AND block_id + blocks - 1
    AND ROWNUM = 1;
    
