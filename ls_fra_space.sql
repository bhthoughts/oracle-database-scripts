-- -----------------------------------------------------------------------------------	
-- Description: Check FRA space
-- -----------------------------------------------------------------------------------	

SET LINESIZE 500
SET COLSEP '|'

col NAME for a50

SELECT
    name,
    round(space_limit / 1024 / 1024 / 1024, 2)       "Allocated Space(GB)",
    round(space_used / 1024 / 1024 / 1024, 2)        "Used Space(GB)",
    round(space_reclaimable / 1024 / 1024 / 1024, 2) "SPACE_RECLAIMABLE (GB)",
    (
        SELECT
            round(estimated_flashback_size / 1024 / 1024 / 1024, 2)
        FROM
            v$flashback_database_log
    )                                                "Estimated Space (GB)"
FROM
    v$recovery_file_dest;