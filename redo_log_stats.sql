-- -----------------------------------------------------------------------------------
-- Redo log statistics
-- -----------------------------------------------------------------------------------

SET PAGES 200 LIN 200
SET COLSEP '|'

select 'Days analyzed' as archive_stat
    , round( max(first_time) - min(first_time) )
    as archive_value
    from v$log_history
union all
select 'Block changes' as archive_stat
    , round( max(next_change#) - min(first_change#) )
    as archive_value
    from v$log_history
union all
select 'Avg Block changes' as archive_stat
     , round( ( max(first_change#) - min(first_change#) )
            / ( max(first_time)    - min(first_time)    ) )
    as archive_value
  from v$log_history
union all
select 'Total switches' as archive_stat
     , max(sequence#) - min(sequence#) + 1
    as archive_value
  from v$log_history
union all
select 'Avg Switches' as archive_stat
     , round( ( max(sequence#) - min(sequence#) + 1 )
            / ( max(first_time)    - min(first_time)    ) )
    as archive_value
  from v$log_history
union all
select 'Archivelog (MBytes)'
     , sum(blocks*block_size)/1024/1024
    as archive_value
  from ( select max(blocks) as blocks, max(block_size) as block_size
              , max(first_time) as first_time
         from v$archived_log where ARCHIVED = 'YES' group by SEQUENCE# )
union all
select 'Avg Archivelog (MBytes)'
     , round( sum(blocks*block_size)/1024/1024
            / ( max(first_time) - min(first_time) ) )
    as archive_value
  from ( select max(blocks) as blocks, max(block_size) as block_size
              , max(first_time) as first_time
         from v$archived_log where ARCHIVED = 'YES' group by SEQUENCE# )
union all
select 'Switches in the last 24 hours'
     , max(sequence#) - min(sequence#) + 1
    as archive_value
  from v$log_history
  where (sysdate-first_time) < 1 union all select 'Archivelog (MBytes) in the last 24 hours'      , round( sum(blocks*block_size)/1024/1024             / ( max(first_time) - min(first_time) ) )     as archive_value   from ( select max(blocks) as blocks, max(block_size) as block_size               , max(first_time) as first_time          from v$archived_log          where ARCHIVED = 'YES' and (sysdate-first_time) < 1          group by SEQUENCE# );
