-- -----------------------------------------------------------------------------------
-- Description: Check ACE rules
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 200
SET COLSEP '|'

COLUMN host FORMAT A15
COLUMN lower_port FORMAT 999999
COLUMN upper_port FORMAT 999999
COLUMN ace_order FORMAT 999
COLUMN start_date FORMAT a12
COLUMN end_date FORMAT a12
COLUMN grant_type FORMAT A10
COLUMN inverted_principal FORMAT A5
COLUMN principal FORMAT A30
COLUMN principal_type FORMAT A30
COLUMN privilege FORMAT A20

SELECT
    host,
    lower_port,
    upper_port,
    ace_order,
    to_char(start_date, 'DD-MON-YYYY') AS start_date,
    to_char(end_date, 'DD-MON-YYYY')   AS end_date,
    grant_type,
    inverted_principal,
    principal,
    principal_type,
    privilege
FROM
    dba_host_aces
ORDER BY
    host,
    ace_order;