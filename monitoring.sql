Version information

SELECT * FROM product_component_version ;

--------------------------------------------------------------------------------

List free and used space in database

SELECT sum(bytes)/1024 "free space in KB"
FROM dba_free_space;
SELECT sum(bytes)/1024 "used space in KB"
FROM dba_segments;

--------------------------------------------------------------------------------

List session information

SELECT * FROM V$SESSION ;

--------------------------------------------------------------------------------

List names and default storage parameters for all tablespaces

SELECT TABLESPACE_NAME, INITIAL_EXTENT, NEXT_EXTENT, MAX_EXTENTS,
  PCT_INCREASE, MIN_EXTLEN
FROM DBA_TABLESPACES;

--------------------------------------------------------------------------------

Tablespace types, and availability of data files

SELECT TABLESPACE_NAME, CONTENTS, STATUS
FROM DBA_TABLESPACES;

--------------------------------------------------------------------------------

List information about tablespace to which datafiles belong

SELECT FILE_NAME,TABLESPACE_NAME,BYTES,AUTOEXTENSIBLE,
       MAXBYTES,INCREMENT_BY
FROM DBA_DATA_FILES;

--------------------------------------------------------------------------------

List data file information

SELECT FILE#,T1.NAME,STATUS,ENABLED,BYTES,CREATE_BYTES,T2.NAME
FROM   V$DATAFILE T1, V$TABLESPACE T2
WHERE  T1.TS# = T2.TS# ;

--------------------------------------------------------------------------------

List tablespace fragmentation information

SELECT tablespace_name,COUNT(*) AS fragments,
   SUM(bytes) AS total,
   MAX(bytes) AS largest
FROM dba_free_space
GROUP BY tablespace_name;

--------------------------------------------------------------------------------

Check the current number of extents and blocks allocated to a segment

SELECT SEGMENT_NAME,TABLESPACE_NAME,EXTENTS,BLOCKS
FROM DBA_SEGMENTS;

--------------------------------------------------------------------------------

Check the extents for a given segment

SELECT TABLESPACE_NAME, COUNT(*), MAX(BLOCKS), SUM(BLOCKS)
FROM DBA_FREE_SPACE
GROUP BY TABLESPACE_NUMBER ;

--------------------------------------------------------------------------------

Extent information

SELECT segment_name, extent_id, blocks, bytes
      FROM dba_extents
      WHERE segment_name = TNAME ;

--------------------------------------------------------------------------------

Extent information for a table

SELECT segment_name, extent_id, blocks, bytes
      FROM dba_extents
      WHERE segment_name = TNAME ;

--------------------------------------------------------------------------------

List segments with fewer than 5 extents remaining

SELECT segment_name,segment_type,
       max_extents, extents
FROM dba_segments
WHERE extents+5 > max_extents
AND segment_type<>'CACHE';

--------------------------------------------------------------------------------

List segments reaching extent limits

SELECT s.segment_name,s.segment_type,s.tablespace_name,s.next_extent
FROM dba_segments s
WHERE NOT EXISTS (SELECT 1
   FROM dba_free_space f
   WHERE s.tablespace_name=f.tablespace_name
   HAVING max(f.bytes) > s.next_extent);

--------------------------------------------------------------------------------

List table blocks, empty blocks, extent count, and chain block count

SELECT blocks as BLOCKS_USED, empty_blocks
FROM dba_tables
WHERE table_name=TNAME;

SELECT chain_cnt AS CHAINED_BLOCKS
FROM dba_tables
WHERE table_name=TNAME;

SELECT COUNT(*) AS EXTENT_COUNT
FROM dba_extents
WHERE segment_name=TNAME;

--------------------------------------------------------------------------------

Information about all rollback segments in the database

SELECT SEGMENT_NAME,TABLESPACE_NAME,OWNER,STATUS
FROM DBA_ROLLBACK_SEGS;

/* General Rollback Segment Information */

SELECT t1.name, t2.extents, t2.rssize, t2.optsize, t2.hwmsize, t2.xacts, t2.status
FROM   v$rollname t1, v$rollstat t2
WHERE  t2.usn = t1.usn ;

/* Rollback Segment Information - Active Sessions */

select t2.username, t1.xidusn, t1.ubafil, t1.ubablk, t2.used_ublk
from v$session t2, v$transaction t1
where t2.saddr = t1.ses_addr 

--------------------------------------------------------------------------------

Statistics of the rollback segments currently used by instance

SELECT T1.NAME, T2.EXTENTS, T2.RSSIZE, T2.OPTSIZE, T2.HWMSIZE,
          T2.XACTS, T2.STATUS
FROM   V$ROLLNAME T1, V$ROLLSTAT T2
WHERE  T1.USN = T2.USN AND
       T1.NAME LIKE '%RBS%';

--------------------------------------------------------------------------------

List sessions with active transactions

SELECT s.sid, s.serial#
 FROM v$session s
 WHERE s.saddr in
  (SELECT t.ses_addr
    FROM V$transaction t, dba_rollback_segs r
    WHERE t.xidusn=r.segment_id
    AND r.tablespace_name='RBS');

--------------------------------------------------------------------------------

Active sorts in instance

SELECT T1.USERNAME, T2.TABLESPACE, T2.CONTENTS, T2.EXTENTS, T2.BLOCKS
FROM V$SESSION T1, V$SORT_USAGE T2
WHERE T1.SADDR = T2.SESSION_ADDR ;

--------------------------------------------------------------------------------

Index & constraint information

SELECT index_name,table_name,uniqueness
FROM dba_indexes
WHERE index_name in
  (SELECT constraint_name
   FROM dba_constraints
   WHERE table_name = TNAME
    AND constraint_type in ('P','U')) ;

--------------------------------------------------------------------------------

Updating statistics for a table or schema

EXEC DBMS_STATS.GATHER_TABLE_STATS('SCHEMA1','COMPANY');

EXEC DBMS_STATS.GATHER_SCHEMA_STATS('SCHEMA1');

ANALYZE TABLE COMPANY COMPUTE STATISTICS ;

--------------------------------------------------------------------------------

List tables and synonyms

set pagesize 0;

select 'TABLE:',table_name,'current' from user_tables 
    union
select 'SYNONYM:',synonym_name,table_owner from user_synonyms  
order by 1,2 ;

--------------------------------------------------------------------------------

Constraint columns

SELECT constraint_name,table_name, column_name
FROM dba_cons_columns
WHERE table_name = TNAME
ORDER BY table_name, constraint_name, position
END IF;

--------------------------------------------------------------------------------

Constraint listing

SELECT constraint_name, table_name,
     constraint_type, validated, status
FROM dba_constraints;

--------------------------------------------------------------------------------

Indexed column listing

select 
    b.uniqueness, a.index_name, a.table_name, a.column_name 
from user_ind_columns a, user_indexes b
where a.index_name=b.index_name 
order by a.table_name, a.index_name, a.column_position;

--------------------------------------------------------------------------------

Trigger listing

SELECT trigger_name, status
 FROM dba_triggers ;

-------------------------------------------------------------------------------

Tuning: library cache
Glossary: 
pins = # of time an item in the library cache was executed
reloads = # of library cache misses on execution
Goal: 
get hitratio to be less than 1 
Tuning parm: 
adjust SHARED_POOL_SIZE in the initxx.ora file, increasing by small increments 

SELECT    SUM(PINS) EXECS,
          SUM(RELOADS)MISSES,
          SUM(RELOADS)/SUM(PINS) HITRATIO
FROM      V$LIBRARYCACHE ;

--------------------------------------------------------------------------------

Tuning: data dictionary cache
Glossary: 
gets = # of requests for the item 
getmisses = # of requests for items in cache which missed
Goal: 
get rcratio to be less than 1 
Tuning parm: 
adjust SHARED_POOL_SIZE in the initxx.ora file, increasing by small increments 

SELECT    SUM(GETS) HITS,
          SUM(GETMISSES) LIBMISS,
          SUM(GETMISSES)/SUM(GETS) RCRATIO
FROM      V$ROWCACHE ;

--------------------------------------------------------------------------------

Tuning: buffer cache
Calculation:
buffer cache hit ratio = 1 - (phy reads/(db_block_gets + consistent_gets))
Goal:
get hit ratio in the range 85 - 90%
Tuning parm:
adjust DB_BLOCK_BUFFERS in the initxx.ora file, increasing by small increments 

SELECT NAME, VALUE
FROM   V$SYSSTAT WHERE NAME IN
   ('DB BLOCK GETS','CONSISTENT GETS','PHYSICAL READS');

--------------------------------------------------------------------------------

Tuning: sorts
Goal: 
Increase number of memory sorts vs disk sorts 
Tuning parm:
adjust SORT_AREA_SIZE in the initxx.ora file, increasing by small increments 

SELECT NAME, VALUE
FROM   V$SYSTAT
WHERE NAME LIKE '%SORT%';

--------------------------------------------------------------------------------

Tuning: dynamic extension
An informational query. 

SELECT NAME, VALUE
FROM V$SYSSTAT
WHERE NAME='RECURSIVE CALLS' ;

--------------------------------------------------------------------------------

Tuning: rollback segments
Goal: 
Try to avoid increasing 'undo header' counts
Tuning method: 
Create more rollback segments, try to reduce counts

SELECT CLASS,COUNT
FROM V$WAITSTAT
WHERE CLASS LIKE '%UNDO%' ;

--------------------------------------------------------------------------------

Tuning: physical file placement
Informational in checking relative usages of the physical data files. 

SELECT NAME, PHYRDS,PHYWRTS
FROM V$DATAFILE DF, V$FILESTAT FS
WHERE DF.FILE#=FS.FILE# ;

--------------------------------------------------------------------------------

Killing Sessions
Runaway processes can be killed on the UNIX side, or within server manager. 

/* Kill a session, specified by the returned sess-id / serial number */

SELECT sid, serial#, username from v$session

ALTER SYSTEM KILL SESSION 'sessid,ser#'

--------------------------------------------------------------------------------

Archive Log Mode Status

/* Status of Archive Log Subsystem */

ARCHIVE LOG LIST

/* log mode of databases */

SELECT name, log_mode FROM v$database;

/* log mode of instance */

SELECT archiver FROM v$instance;
