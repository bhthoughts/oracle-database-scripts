-- -----------------------------------------------------------------------------------
-- Description: Check ACL rules - Deprecated 12c - Should use ACE now
-- -----------------------------------------------------------------------------------

SET LINESIZE 150
SET COLSEP '|'

COLUMN ACL FORMAT A50
COLUMN PRINCIPAL FORMAT A20
COLUMN PRIVILEGE FORMAT A10
COLUMN IS_GRANT FORMAT A10
COLUMN START_DATE FORMAT A12
COLUMN END_DATE FORMAT A12

SELECT
    acl,
    principal,
    privilege,
    is_grant,
    to_char(start_date, 'DD-MON-YYYY') AS start_date,
    to_char(end_date, 'DD-MON-YYYY')   AS end_date
FROM
    dba_network_acl_privileges
ORDER BY
    acl,
    principal,
    privilege;