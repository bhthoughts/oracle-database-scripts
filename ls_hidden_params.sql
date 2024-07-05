-- -----------------------------------------------------------------------------------
-- Description: List all the hidden parameters available in the database
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 250
SET COLSEP '|'

COL NAME FOR A60
COL VALUE FOR A30
COL DESCRIPTION FOR A90
COL TYPE FOR A10

SELECT
    a.ksppinm                                 name,
    b.ksppstvl                                value,
    b.ksppstdf                                deflt,
    decode(a.ksppity, 1, 'boolean', 2, 'string',
           3, 'number', 4, 'file', a.ksppity) type,
    a.ksppdesc                                description
FROM
    sys.x$ksppi  a,
    sys.x$ksppcv b
WHERE
        a.indx = b.indx
    AND a.ksppinm LIKE '\_%' ESCAPE '\'
ORDER BY
    name;