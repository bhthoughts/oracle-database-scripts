-- -----------------------------------------------------------------------------------	
-- Type.......: Display
-- Execute per: Instance
-- Description: Check the database compatible parameter.
-- Datatype...: VARCHAR
-- Rules......: N/A
-- Threshold..: N/A
-- Frequency..: Each 24 hours
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200

col compatible for a20

SELECT
    value compatible
FROM
    v$parameter
WHERE
    name = 'compatible';