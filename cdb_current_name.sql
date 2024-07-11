-- -----------------------------------------------------------------------------------	
-- Description: List the current container name
-- -----------------------------------------------------------------------------------	

COL CON_NAME for a10

SELECT
    sys_context('USERENV', 'CON_NAME') con_name
FROM
    dual;