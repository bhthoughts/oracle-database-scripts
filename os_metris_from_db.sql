-- -----------------------------------------------------------------------------------
-- Description: Check the Operating System metrics from the database
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 250
SET COLSEP '|'

col inst_id for 999
con begin_time for a20
col end_time for a20
col Physical_Read_Total_Bps heading 'Physical Read|Total Bytes p/s' format 9999999999.99
col Physical_Write_Total_Bps heading 'Physical Write|Total Bytes p/s' format 9999999999.99
col Redo_Bytes_per_sec heading 'Redo Bytes p/s' format 9999999999.99
col Physical_Read_IOPS heading 'Physical Read|IOPS' format 9999999999.99
col Physical_write_IOPS heading 'Physical Write|IOPS' format 9999999999.99
col Physical_redo_IOPS heading 'Physical Redo|IOPS' format 9999999999.99
col OS_LOad heading 'OS Load' format 9999999999.99
col DB_CPU_Usage_per_sec heading 'DB CPU Usage p/s' format 9999999999.99
col Host_CPU_util heading 'Host|CPU Util' format 9999999999.99
col Network_bytes_per_sec heading 'Network Bytes p/s' format 9999999999.99

SELECT
    snap_id,
    to_char(MIN(begin_time),
            'DD-MON-YYYY hh24:mi:ss') begin_time,
    to_char(MAX(end_time),
            'DD-MON-YYYY hh24:mi:ss') end_time,
    instance_number                   inst_id,
    SUM(
        CASE metric_name
            WHEN 'Physical Read Total Bytes Per Sec' THEN
                average
        END
    )                                 physical_read_total_bps,
    SUM(
        CASE metric_name
            WHEN 'Physical Write Total Bytes Per Sec' THEN
                average
        END
    )                                 physical_write_total_bps,
    SUM(
        CASE metric_name
            WHEN 'Redo Generated Per Sec' THEN
                average
        END
    )                                 redo_bytes_per_sec,
    SUM(
        CASE metric_name
            WHEN 'Physical Read Total IO Requests Per Sec' THEN
                average
        END
    )                                 physical_read_iops,
    SUM(
        CASE metric_name
            WHEN 'Physical Write Total IO Requests Per Sec' THEN
                average
        END
    )                                 physical_write_iops,
    SUM(
        CASE metric_name
            WHEN 'Redo Writes Per Sec' THEN
                average
        END
    )                                 physical_redo_iops,
    SUM(
        CASE metric_name
            WHEN 'Current OS Load' THEN
                average
        END
    )                                 os_load,
    SUM(
        CASE metric_name
            WHEN 'CPU Usage Per Sec' THEN
                average
        END
    )                                 db_cpu_usage_per_sec,
    SUM(
        CASE metric_name
            WHEN 'Host CPU Utilization (%)' THEN
                average
        END
    )                                 host_cpu_util, --NOTE 100% = 1 loaded RAC node
    SUM(
        CASE metric_name
            WHEN 'Network Traffic Volume Per Sec' THEN
                average
        END
    )                                 network_bytes_per_sec
FROM
    dba_hist_sysmetric_summary
WHERE
    begin_time >= sysdate - 90
GROUP BY
    snap_id,
    instance_number
ORDER BY
    snap_id,
    instance_number; 

-------------------	