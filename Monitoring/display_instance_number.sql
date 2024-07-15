-- -----------------------------------------------------------------------------------
-- Type.......: Display
-- Execute per: Instance
-- Description: Check the instance number
-- Datatype...: NUMBER (Int)
-- Rules......: N/A
-- Threshold..: N/A
-- Frequency..: Each 1 day
-- -----------------------------------------------------------------------------------

SET LINESIZE 200

col instance for 99

SELECT
    to_char(instance_number) instance
FROM
    v$instance i