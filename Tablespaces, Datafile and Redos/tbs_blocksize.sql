-- -----------------------------------------------------------------------------------	
-- Description: Check asm griddisks
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col tablespace_name for a30
col blksize for a10
col type for a10

SELECT
    tablespace_name,
    block_size / 1024 || 'k'                             blksize,
    decode(bigfile, 'YES', 'bigfile', 'NO', 'smallfile') type
FROM
    dba_tablespaces;
