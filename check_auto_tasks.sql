-- -----------------------------------------------------------------------------------	
-- List the existing Auto Tasks
-- -----------------------------------------------------------------------------------	

SET LINES 180 PAGES 1000
SET COLSEP '|'

COL CLIENT_NAME FOR A40
COL ATTRIBUTES FOR A60

SELECT
    client_name,
    status,
    attributes,
    service_name
FROM
    dba_autotask_client;