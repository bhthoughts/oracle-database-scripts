-- -----------------------------------------------------------------------------------
-- Description: Check the PDBs details
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 200
SET COLSEP '|'

column name format a30

SELECT
    p.name,
    p.open_mode,
    d.status,
    to_char(p.open_time, 'DD/MM/YYYY HH24:MI:SS') open_time,
    p.total_size / 1024 / 1024                    total_mb,
    p.local_undo
FROM
    v$pdbs   p,
    dba_pdbs d
WHERE
    p.name = d.pdb_name
ORDER BY
    1;