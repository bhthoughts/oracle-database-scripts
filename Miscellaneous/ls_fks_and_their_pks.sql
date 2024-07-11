-- -----------------------------------------------------------------------------------
-- Description: Check FKs and the PKs related to it
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 200 
SET COLSEP '|'

col fk_owner for a10
col fk_table_name for a30 
col fk_column_name for a30
col fk_name for a30
col pk_owner for a10
col pk_table_name for a30
col pk_name for a30

SELECT
    c.owner fk_owner, 
    a.table_name fk_table_name,
    a.column_name fk_column_name,
    a.constraint_name fk_name,
       -- referenced pk
    c.r_owner pk_owner,
    c_pk.table_name      pk_table_name,
    c_pk.constraint_name pk_name
FROM
         all_cons_columns a
    JOIN all_constraints c ON a.owner = c.owner
                              AND a.constraint_name = c.constraint_name
    JOIN all_constraints c_pk ON c.r_owner = c_pk.owner
                                 AND c.r_constraint_name = c_pk.constraint_name
WHERE
        c.constraint_type = 'R' -- FK
    --AND a.constraint_name = :fk_name;