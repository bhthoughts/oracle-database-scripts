-- -----------------------------------------------------------------------------------
-- Description: Check blocking and blocked sessions
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 200
SET COLSEP '|'

column sess_blocking format A28;
column sess_blocked format A28;
column sess_blk_event format a30;
column sess_blking_event format a30;
column lock_type format A20;
column LOCKED_MODE format a40;
column db_object format a30;
column desc_rowid format a20;

SELECT
    tbaux.sess_blocking,
    tbaux.sess_blocked,
    tbaux.sess_blk_event,
    tbaux.sess_blking_event,
    tbaux.lock_type,
    tbaux.db_object,
    tbaux.desc_rowid,
    dbms_rowid.rowid_row_number(tbaux.desc_rowid) AS row_number
FROM
    (
        SELECT
            '( SID='
            || s2.sid
            || ' SERIAL='
            || s2.serial#
            || ' )'                                                                                               AS sess_blocked,
            '( SID='
            || s1.sid
            || ' SERIAL='
            || s1.serial#
            || ' )'                                                                                               AS sess_blocking,
            s2.event                                                                                              AS sess_blk_event,
            s1.event                                                                                              AS sess_blking_event
            ,
            lt.name                                                                                               AS lock_type,
            do.owner
            || '.'
            || do.object_name                                                                                     AS db_object,
            dbms_rowid.rowid_create(1, s2.row_wait_obj#, s2.row_wait_file#, s2.row_wait_block#, s2.row_wait_row#) AS desc_rowid
        FROM
            v$lock      l1,
            v$session   s1,
            v$lock      l2,
            v$session   s2,
            v$lock_type lt,
            dba_objects do
        WHERE
                s1.sid = l1.sid
            AND s2.sid = l2.sid
            AND l1.block = 1
            AND l2.request > 0
            AND l1.id1 = l2.id1
            AND l1.type = lt.type
            AND s2.row_wait_obj# = do.object_id
        ORDER BY
            s1.sid
    ) tbaux;