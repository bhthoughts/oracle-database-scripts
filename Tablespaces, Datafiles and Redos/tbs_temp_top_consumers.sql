-- -----------------------------------------------------------------------------------	
-- Description: Top sessions consuming the temp tablespace
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col sid for 999999
col status for a15
col username for a20
col tablespace for a15
col sql_id for a20
col mb_used for 99999999.99
col num_exts for 99999999
col proginfo for a20
col lastcallet for a20

CURSOR bigtemp_sids IS
SELECT
    *
FROM
    (
        SELECT
            s.sid,
            s.status,
            s.username,
            u.tablespace,
            s.sql_id                              sql_id,
            SUM(u.blocks * p.value / 1024 / 1024) mb_used,
            SUM(u.extents)                        num_exts,
            nvl(s.module, s.program)              proginfo,
            floor(last_call_et / 3600)
            || ':'
               || floor(mod(last_call_et, 3600) / 60)
                  || ':'
                     || mod(mod(last_call_et, 3600),
                            60)                                   lastcallet
        FROM
            v$sort_usage u,
            v$session    s,
            v$parameter  p
        WHERE
                u.session_addr = s.saddr
            AND p.name = 'db_block_size'
        GROUP BY
            s.sid,
            s.status,
            s.sql_id,
            s.username,
            u.tablespace,
            nvl(s.module, s.program),
            floor(last_call_et / 3600)
            || ':'
               || floor(mod(last_call_et, 3600) / 60)
                  || ':'
                     || mod(mod(last_call_et, 3600),
                            60)
        ORDER BY
            7 DESC,
            3
    )
WHERE
    ROWNUM < 11;