-- -----------------------------------------------------------------------------------
-- Description: The the amount of invalid objects of a schema
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 200
SET COLSEP '|'

COL owner for a10
COL object_type for a20
COL status for a15

SELECT
    owner,
    object_type,
    status,
    COUNT(*)
FROM
    dba_objects
WHERE
    owner = '&OWNER'
	and status!='VALID'
GROUP BY
    owner,
    object_type,
    status
ORDER BY
    1,
    2,
    3;