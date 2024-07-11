-- -----------------------------------------------------------------------------------
-- Description: PGA Advisor
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 200
SET COLSEP '|'

col target_mb for 99999999
col cache_hit_perc for 999
col estd_overalloc_count for 99999999

SELECT
    round(pga_target_for_estimate / 1024 / 1024) target_mb,
    estd_pga_cache_hit_percentage                cache_hit_perc,
    estd_overalloc_count -- near to zero better
FROM
    v$pga_target_advice;