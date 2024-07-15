-- -----------------------------------------------------------------------------------	
-- Type.......: Alert
-- Execute per: Database
-- Description: Monitoring the usage of tablespace, considering the maxsize of the datafiles (autoextend)
-- Datatype...: NUMBER (Int)
-- Rules......: Check the used space, and to generate the percent, it consider the maxsize of each datafile from the tablespaces
-- ...........: You can configure your alert to the threshold
-- Threshold..: 85 %
-- Frequency..: Each 10 minutes
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col tablespace for a20
col used_mb for 999,999,999,999.99
col usage_pct for 999
col max_bytes_mb for 999,999,999,999.99

select max(Usage_Pct) Usage_Pct from (
SELECT
    -- df.tablespace_name                                      AS "Tablespace",
    -- ( ( bytes - nvl(free_bytes, 0) ) ) / 1024 / 1024        used_mb,
    -- max_bytes / 1024 / 1024                                 max_bytes_mb,
	round(((bytes - nvl(free_bytes, 0)) / max_bytes) * 100) AS Usage_Pct
FROM
    (
        SELECT
            tablespace_name,
            SUM(bytes) bytes,
            SUM(
                CASE
                    WHEN autoextensible = 'YES'
                         AND maxbytes > bytes THEN
                        maxbytes
                    ELSE
                        bytes
                END
            )          max_bytes
        FROM
            dba_data_files
        WHERE
            tablespace_name NOT LIKE '%UNDOTBS%'
        GROUP BY
            tablespace_name
    ) df
    LEFT JOIN (
        SELECT
            tablespace_name,
            SUM(bytes) free_bytes
        FROM
            dba_free_space
        GROUP BY
            tablespace_name
    ) fs ON df.tablespace_name = fs.tablespace_name
) ; 