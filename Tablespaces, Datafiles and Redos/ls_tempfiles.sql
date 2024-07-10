-- -----------------------------------------------------------------------------------	
-- Description: List tempfiles
-- -----------------------------------------------------------------------------------	

SET LINESIZE 200
SET COLSEP '|'

col file_id for 999999
col tablespace_name for a15
col file_name for a70
col cur_size_mb for 99999999.99
col max_size_mb for 99999999.99
col autoextensible for a5
col inc_mb for 99999999.99
col status for a15

select 
	file_id,
	tablespace_name, 
	file_name, 
	((bytes/1024)/1024) cur_size_mb, 
	(maxbytes/1024/1024) max_size_mb, 
	autoextensible, 
	((increment_by*8)/1024) inc_mb, 
	status 
from 
	dba_temp_files 
order by 
	1;
