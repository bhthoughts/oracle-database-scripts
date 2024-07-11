-------------------
-- Advisor Shared Pool 
-------------------

SET PAGES 200 LIN 200
SET COLSEP '|'

col c1 heading 'Size for|Estimate' format 99999999
col c2 heading 'Size Factor' format 9999.9999
col c3 heading 'Library|Cache Size' format 99999999
col c4 heading 'Objects in|Memory' format 99999999
col c5 heading 'Time (sec)|Saved' format 99999999
col c6 heading 'Time Saved|Factor' format 99999999
col c7 heading 'Libreary| Cache Hits' format 99999999

SELECT
       shared_pool_size_for_estimate  c1,
       shared_pool_size_factor        c2,
       estd_lc_size                   c3,
       estd_lc_memory_objects         c4,
       estd_lc_time_saved                    c5,
       estd_lc_time_saved_factor             c6,
       estd_lc_memory_object_hits            c7
    FROM
      v$shared_pool_advice;
