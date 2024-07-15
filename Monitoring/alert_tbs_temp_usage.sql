-- -----------------------------------------------------------------------------------	
-- Type.......: Alert
-- Execute per: Instance
-- Description: Monitoring the temp tablespace usage.
-- Datatype...: NUMBER (Float)
-- Rules......: N/A
-- Threshold..: 90 %
-- Frequency..: Each 5 minutes
-- -----------------------------------------------------------------------------------	
SET PAGES 200 LIN 200
SET COLSEP '|'

col perc for 999.99

SELECT
    tablespace,
    round((b_used * 100) / b_total) perc
FROM
    (
        SELECT
            a.tablespace_name                             tablespace,
            d.b_total,
            SUM(a.used_blocks * d.block_size)             b_used,
            d.b_total - SUM(a.used_blocks * d.block_size) b_free
        FROM
            v$sort_segment a,
            (
                SELECT
                    b.name,
                    c.block_size,
                    SUM(c.bytes) b_total
                FROM
                    v$tablespace b,
                    v$tempfile   c
                WHERE
                    b.ts# = c.ts#
                GROUP BY
                    b.name,
                    c.block_size
            )              d
        WHERE
            a.tablespace_name = d.name
        GROUP BY
            a.tablespace_name,
            d.b_total
    ) t1;