-- -----------------------------------------------------------------------------------	
-- Type.......: Alert
-- Execute per: Instance
-- Description: Monitoring of database performance degradation. It will return the number of session waiting for something. It will alert considering the number of the CPUs the database has.
-- Datatype...: NUMBER (Int)
-- Rules......: If the count of sessions waiting for something is bigger than  the CPU count, then it will return the number of sessions.
-- Threshold..: 1
-- Frequency..: Each 5 minutes
-- -----------------------------------------------------------------------------------	

SET PAGES 200 LIN 200
SET COLSEP '|'

col status for 9999

select case when qnt >= (select value from v$parameter where name like '%cpu_count%') then qnt else 0 end status from 
(select sum(count) qnt from 
(SELECT
    coalesce(COUNT(qnt), 0) count,
    wait_class
FROM
    (
        SELECT DISTINCT
            wait_class,
            (
                SELECT
                    COUNT(*) count
                FROM
                    v$session ses
                WHERE
                    ses.username IS NOT NULL
                    AND ses.wait_class != 'Idle'
                    --AND ses.status = 'ACTIVE'
                    AND ses.state = 'WAITING'
                    AND ses.event = eve.name
                    AND ses.wait_class = eve.wait_class
                GROUP BY
                    wait_class
            ) qnt
        FROM
            v$event_name eve
    ) GROUP BY wait_class
union
select     coalesce(( 
SELECT
    count(*) qnt
FROM
    v$session ses
WHERE
    ses.username IS NOT NULL
    AND ses.wait_class != 'Idle'
    --AND ses.status = 'ACTIVE'
    AND ses.state != 'WAITING'),0) qnt,
    'ON CPU' wait_class
    from dual));