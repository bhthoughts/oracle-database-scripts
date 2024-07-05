-- -----------------------------------------------------------------------------------
-- Description: The optimizer_index_cost_adj parameter allow us to change the costs related to full-scan and index operations. 
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 200
SET COLSEP '|'

col c1 heading 'Avg Waits|Full Scan Read I/O' format 9999.999
col c2 heading 'Avg Waits|Index Read I/O' format 9999.999
col c3 heading 'Percent of|I/O Waits|to Full Scans' format 9.99
col c4 heading 'Percent of|I/O Waits|to Index Scans' format 9.99
col c5 heading 'Value|start|to|optimizer|index|cost|adj' format 999

SELECT
    a.average_wait                                    c1,
    b.average_wait                                    c2,
    a.total_waits / ( a.total_waits + b.total_waits ) c3,
    b.total_waits / ( a.total_waits + b.total_waits ) c4,
    ( b.average_wait / a.average_wait ) * 100         c5
FROM
    v$system_event a,
    v$system_event b
WHERE
        a.event = 'db file scattered read'
    AND b.event = 'db file sequential read';