-- -----------------------------------------------------------------------------------
-- Description: Parallel queries
-- Requires Enterprise Edition
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 200
SET COLSEP '|'

COL px_qcsid HEAD QC_SID FOR A13

SELECT
    pxs.qcsid
    || ','
    || pxs.qcserial#            px_qcsid,
    pxs.qcinst_id,
    ses.username,
    ses.sql_id,
    pxs.degree,
    pxs.req_degree,
    COUNT(*)                    slaves,
    COUNT(DISTINCT pxs.inst_id) inst_cnt,
    MIN(pxs.inst_id)            min_inst,
    MAX(pxs.inst_id)            max_inst
FROM
    gv$px_session pxs,
    gv$session    ses,
    gv$px_process p
WHERE
        ses.sid = pxs.sid
    AND ses.serial# = pxs.serial#
    AND p.sid = pxs.sid
    AND pxs.inst_id = ses.inst_id
    AND ses.inst_id = p.inst_id
    AND pxs.req_degree IS NOT NULL -- qc
GROUP BY
    pxs.qcsid
    || ','
    || pxs.qcserial#,
    pxs.qcinst_id,
    ses.username,
    ses.sql_id,
    pxs.degree,
    pxs.req_degree
ORDER BY
    pxs.qcinst_id,
    slaves DESC;