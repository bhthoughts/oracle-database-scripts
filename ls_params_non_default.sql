-- -----------------------------------------------------------------------------------
-- Description: Check the non-default parameters configured in the database
-- -----------------------------------------------------------------------------------

SET PAGES 999 LINES 200
SET COLSEP '|'

COL NAME FORMAT A40
COL VALUE FORMAT A90

SELECT
    name,
    value
FROM
    v$parameter
WHERE
        isdefault = 'FALSE'
    AND value IS NOT NULL
ORDER BY
    name;