USE MASTER 

GO 

CREATE TABLE #TMPFIXEDDRIVES ( 
  DRIVE  CHAR(1), 
  MBFREE INT) 

INSERT INTO #TMPFIXEDDRIVES 
EXEC xp_FIXEDDRIVES 

CREATE TABLE #TMPSPACEUSED ( 
  DBNAME    VARCHAR(250), 
  FILENME   VARCHAR(250), 
  SPACEUSED FLOAT) 
 
INSERT INTO #TMPSPACEUSED 
EXEC( 'sp_msforeachdb''use [?]; Select ''''?'''' DBName, Name FileNme, 
fileproperty(Name,''''SpaceUsed'''') SpaceUsed from sysfiles where db_id() >4 ''') 

SELECT   C.DRIVE, 
         CASE  
           WHEN (C.MBFREE) > 1000 THEN CAST(CAST(((C.MBFREE) / 1024.0) AS DECIMAL(18,2)) AS VARCHAR(20)) + ' GB' 
           ELSE CAST(CAST((C.MBFREE) AS DECIMAL(18,2)) AS VARCHAR(20)) + ' MB' 
         END AS DISKSPACEFREE, 
         A.NAME AS DATABASENAME, 
         B.NAME AS FILENAME, 
         CASE B.TYPE  
           WHEN 0 THEN 'DATA' 
           ELSE TYPE_DESC 
         END AS FILETYPE, 
         CASE  
           WHEN (B.SIZE * 8 / 1024.0) > 1000 
           THEN CAST(CAST(((B.SIZE * 8 / 1024) / 1024.0) AS DECIMAL(18,2)) AS VARCHAR(20)) + ' GB' 
           ELSE CAST(CAST((B.SIZE * 8 / 1024.0) AS DECIMAL(18,2)) AS VARCHAR(20)) + ' MB' 
         END AS FILESIZE, 
         CAST((B.SIZE * 8 / 1024.0) - (D.SPACEUSED / 128.0) AS DECIMAL(15,2)) SPACEFREE, 
         B.PHYSICAL_NAME,
         'USE ['+A.NAME+']; DBCC SHRINKFILE ('''+B.NAME+''', 100); -- il valore 100 determina lo spazio preallocato sul db '
         
         
FROM     SYS.DATABASES A 
         JOIN SYS.MASTER_FILES B 
           ON A.DATABASE_ID = B.DATABASE_ID 
         JOIN #TMPFIXEDDRIVES C 
           ON LEFT(B.PHYSICAL_NAME,1) = C.DRIVE 
         JOIN #TMPSPACEUSED D 
           ON A.NAME = D.DBNAME 
              AND B.NAME = D.FILENME 
              
 where 
	CAST((B.SIZE * 8 / 1024.0) - (D.SPACEUSED / 128.0) AS DECIMAL(15,2)) >100.0             
              
ORDER BY 
         1,7 DESC
      
DROP TABLE #TMPFIXEDDRIVES 

DROP TABLE #TMPSPACEUSED