-- -----------------------------------------------------------------------------------
-- Description: SGA Info
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 200
SET COLSEP '|'

col name for a40
col mb for 999999.99
col resizeable for a10

SELECT
    name,
    bytes / 1024 / 1024 mb,
    resizeable
FROM
    v$sgainfo;