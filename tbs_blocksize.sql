-- -----------------------------------------------------------------------------------	
-- Description: Check asm griddisks
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col tablespace_name for a30
col block_size for 99999999

SELECT
    tablespace_name,
    block_size
FROM
    dba_tablespaces;