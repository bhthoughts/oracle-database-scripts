-- -----------------------------------------------------------------------------------
-- Description: SGA Dynamic Components
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 200
SET COLSEP '|'

col component for a20
col min_size_mb for 999999.99
col cur_size_mb for 999999.99

SELECT
    component,
    min_size / 1024 / 1024     AS min_size_mb, -- min size since last startup
    current_size / 1024 / 1024 AS cur_size_mb
FROM
    v$sga_dynamic_components
WHERE
    current_size > 0
ORDER BY
    component;