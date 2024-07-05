-- -----------------------------------------------------------------------------------	
-- Description: List the connected session details
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col username head USERNAME for a20
col sid head SID for a5 new_value mysid
col serial head SERIAL# for a8 new_value serial
col cpid head CPID for a15 new_value cpid
col spid head SPID for a10 new_value spid
col opid head OPID for a5 new_value opid
col host_name head HOST_NAME for a25 new_value host
col instance_name head INST_NAME for a20 new_value inst
col ver head VERSION for a10
col startup_day head STARTED for a8
col user noprint new_value user
col conn noprint new_value conn
col myoraver noprint new_value myoraver
col con_name for a10
col proxy_user for a20

SELECT
    s.username                           username,
    sys_context('userenv', 'proxy_user') AS proxy_user,
    (
        CASE substr(i.version,
                    1,
                    instr(i.version, '.', 1) - 1)
            WHEN '12' THEN
                (
                    SELECT
                        sys_context('userenv', 'con_name')
                    FROM
                        dual
                )
                || '-'
                || i.instance_name
            ELSE
                i.instance_name
        END
    )                                    instance_name,
    i.host_name                          host_name,
    to_char(s.sid)                       sid,
    to_char(s.serial#)                   serial,
    (
        SELECT
            substr(banner,
                   instr(banner, 'Release ') + 8,
                   10)
        FROM
            v$version
        WHERE
            ROWNUM = 1
    )                                    ver,
    (
        SELECT
            substr(substr(banner,
                          instr(banner, 'Release ') + 8),
                   1,
                   instr(substr(banner,
                                instr(banner, 'Release ') + 8),
                         '.') - 1)
        FROM
            v$version
        WHERE
            ROWNUM = 1
    )                                    myoraver,
    to_char(startup_time, 'YYYYMMDD')    startup_day,
    TRIM(p.spid)                         spid,
    sys_context('USERENV', 'CON_NAME')   con_name
FROM
    v$session  s,
    v$instance i,
    v$process  p
WHERE
        s.paddr = p.addr
    AND sid = (
        SELECT
            sid
        FROM
            v$mystat
        WHERE
            ROWNUM = 1
    );