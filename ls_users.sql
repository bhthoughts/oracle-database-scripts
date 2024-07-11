-- -----------------------------------------------------------------------------------	
-- Description: List of database users
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col username for a30
col profile for a20

SELECT
    username,
    to_char(lock_date, 'dd/MON/yyyy hh24:mi:ss')   lock_date,
    to_char(expiry_date, 'dd/MON/yyyy hh24:mi:ss') expiry_date,
    profile,
    account_status
FROM
    dba_users
WHERE
    oracle_maintained != 'Y'
ORDER BY
    account_status;