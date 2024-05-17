--1.Verifique os logs de erro do SQL.
EXEC sp_readerrorlog


--2.Verifique os JOBS Ativos.
select * from msdb..sysjobs where enabled =1
--ou
Select  * From  
 msdb..sysjobhistory  as sysjobhistory
   Join  msdb..sysjobs as sysjobs on sysjobhistory.job_id=sysjobhistory.job_id
Order By 
 Run_Date Desc, 
 run_time Desc


--3.Verifique o espaço disponível no servidor.
EXECUTE SP_CONFIGURE 'show advanced options', 1
RECONFIGURE WITH OVERRIDE
GO
EXECUTE SP_CONFIGURE 'xp_cmdshell', '1'
RECONFIGURE WITH OVERRIDE
GO
EXECUTE SP_CONFIGURE 'show advanced options', 0
RECONFIGURE WITH OVERRIDE
GO

declare @svrName varchar(255)
declare @sql varchar(400)
set @svrName = @@SERVERNAME
set @sql = 'powershell.exe -c "Get-WmiObject -ComputerName ' + QUOTENAME(@svrName,'''') + ' -Class Win32_Volume -Filter ''DriveType = 3'' | select name,capacity,freespace | foreach{$_.name+''|''+$_.capacity/1048576+''%''+$_.freespace/1048576+''*''}"'
CREATE TABLE #output
(line varchar(255))
insert #output
EXEC xp_cmdshell @sql
--script to retrieve the values in MB from PS Script output
select rtrim(ltrim(SUBSTRING(line,1,CHARINDEX('|',line) -1))) as drivename
      ,round(cast(rtrim(ltrim(SUBSTRING(line,CHARINDEX('|',line)+1,
      (CHARINDEX('%',line) -1)-CHARINDEX('|',line)) )) as Float),0) as 'capacity(MB)'
      ,round(cast(rtrim(ltrim(SUBSTRING(line,CHARINDEX('%',line)+1,
      (CHARINDEX('*',line) -1)-CHARINDEX('%',line)) )) as Float),0) as 'freespace(MB)'
from #output
where line like '[A-Z][:]%'
order by drivename
select rtrim(ltrim(SUBSTRING(line,1,CHARINDEX('|',line) -1))) as drivename
      ,round(cast(rtrim(ltrim(SUBSTRING(line,CHARINDEX('|',line)+1,
      (CHARINDEX('%',line) -1)-CHARINDEX('|',line)) )) as Float)/1024,0) as 'capacity(GB)'
      ,round(cast(rtrim(ltrim(SUBSTRING(line,CHARINDEX('%',line)+1,
      (CHARINDEX('*',line) -1)-CHARINDEX('%',line)) )) as Float) /1024 ,0)as 'freespace(GB)'
from #output
where line like '[A-Z][:]%'
order by drivename
drop table #output


--4. Verifique a execução dos backups
SELECT  
   A.[Server],  
   A.last_db_backup_date,  
   B.backup_start_date,  
   B.expiration_date, 
   B.backup_size,  
   B.logical_device_name,  
   B.physical_device_name,   
   B.backupset_name, 
   B.description 
FROM 
   ( 
   SELECT   
       CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server, 
       msdb.dbo.backupset.database_name,  
       MAX(msdb.dbo.backupset.backup_finish_date) AS last_db_backup_date 
   FROM    msdb.dbo.backupmediafamily  
       INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id 
   WHERE   msdb..backupset.type = 'D' 
   GROUP BY 
       msdb.dbo.backupset.database_name  
   ) AS A    LEFT JOIN  
   ( 
   SELECT   
   CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server, 
   msdb.dbo.backupset.database_name,  
   msdb.dbo.backupset.backup_start_date,  
   msdb.dbo.backupset.backup_finish_date, 
   msdb.dbo.backupset.expiration_date, 
   msdb.dbo.backupset.backup_size,  
   msdb.dbo.backupmediafamily.logical_device_name,  
   msdb.dbo.backupmediafamily.physical_device_name,   
   msdb.dbo.backupset.name AS backupset_name, 
   msdb.dbo.backupset.description 
FROM   msdb.dbo.backupmediafamily  
   INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id  
WHERE  msdb..backupset.type = 'D' 
   ) AS B 
   ON A.[server] = B.[server] AND A.[database_name] = B.[database_name] AND A.[last_db_backup_date] = B.[backup_finish_date] 
ORDER BY  
   A.database_name
