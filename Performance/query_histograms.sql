-- -----------------------------------------------------------------------------------
-- Querying histograms
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 200
SET COLSEP '|'

COL TABLE_NAME FOR A40
COL COLUMN_NAME FOR A40
COL HISTOGRAM FOR A15
COL ENDPOINT_NUMBER FOR 99999999
COL ENDPOINT_ACTUAL_VALUE FOR a20

SELECT
    h.table_name,
    h.column_name,
    c.histogram,
    h.endpoint_number,
    h.endpoint_actual_value,
    h.endpoint_repeat_count
FROM
    user_tab_histograms h,
    user_tab_columns    c
WHERE
        h.table_name = c.table_name
    AND h.column_name = c.column_name
    AND histogram <> 'NONE'
    AND h.table_name = '&table_name'
ORDER BY
    1,
    2,
    4;