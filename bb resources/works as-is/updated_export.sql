 /* To prevent Oracle running out of temp tablespace, you must first run the ALTER SESSION command */ 
 
 ALTER SESSION
   SET HASH_MULTIBLOCK_IO_COUNT=8;
   
   
 /* These 2 queries are the same apart from the initial select statement */
 /* They determine whether there have been any changes made to any of the follwing tables: */
 /* bb_bb60.COURSE_MAIN
    bb_bb60.GRADEBOOK_MAIN
    bb_bb60.QTI_ASI_DATA
    bb_bb60.CONFERENCE_MAIN
    bb_bb60.CALENDAR
    bb_bb60.COURSE_CONTENTS
    bb_bb60.ANNOUNCEMENTS by checking the DATE_MODIFIED in each table for every module within BLACKBOARD */
 
 /* Note, the WHERE bb_bb60.COURSE_MAIN.COURSE_NAME != 'Personal Test Module' */
 /* This is so we don't include Univeristy of Liverpool's test modules */

  SELECT bb_bb60.COURSE_MAIN.COURSE_ID AS CourseID, ',opt1/archived_modules'
    FROM bb_bb60.COURSE_MAIN, bb_bb60.GRADEBOOK_MAIN, bb_bb60.QTI_ASI_DATA, bb_bb60.CONFERENCE_MAIN, bb_bb60.CALENDAR, bb_bb60.COURSE_CONTENTS, bb_bb60.ANNOUNCEMENTS
   WHERE bb_bb60.COURSE_MAIN.COURSE_NAME != 'Personal Test Module'
     AND bb_bb60.COURSE_MAIN.PK1 = bb_bb60.GRADEBOOK_MAIN.CRSMAIN_PK1 (+)
     AND bb_bb60.COURSE_MAIN.PK1 = bb_bb60.QTI_ASI_DATA.PK1 (+) 
	 AND bb_bb60.COURSE_MAIN.COURSE_ID = bb_bb60.CONFERENCE_MAIN.NAME (+) -- this needed modifying
	 AND bb_bb60.COURSE_MAIN.PK1 = bb_bb60.CALENDAR.CRSMAIN_PK1 (+)
	 AND bb_bb60.COURSE_MAIN.PK1 = bb_bb60.COURSE_CONTENTS.CRSMAIN_PK1 (+)
	 AND bb_bb60.COURSE_MAIN.PK1 = bb_bb60.ANNOUNCEMENTS.CRSMAIN_PK1 (+)
	 AND ((bb_bb60.COURSE_MAIN.DTMODIFIED > TO_DATE('27/07/2014', 'DD/MM/YY') AND bb_bb60.COURSE_MAIN.DTMODIFIED IS NOT NULL)
      OR (bb_bb60.COURSE_CONTENTS.DTMODIFIED > TO_DATE('27/07/2014', 'DD/MM/YY') AND bb_bb60.COURSE_CONTENTS.DTMODIFIED IS NOT NULL)
	  OR (bb_bb60.CONFERENCE_MAIN.DTMODIFIED > TO_DATE('27/07/2014', 'DD/MM/YY') AND bb_bb60.CONFERENCE_MAIN.DTMODIFIED IS NOT NULL)
	  OR (bb_bb60.CALENDAR.DTMODIFIED > TO_DATE('27/07/2014', 'DD/MM/YY') AND bb_bb60.CALENDAR.DTMODIFIED IS NOT NULL)
      OR (bb_bb60.QTI_ASI_DATA.BBMD_DATE_MODIFIED > TO_DATE('27/07/2014', 'DD/MM/YY') AND bb_bb60.QTI_ASI_DATA.BBMD_DATE_MODIFIED IS NOT NULL)
	  OR (bb_bb60.GRADEBOOK_MAIN.DATE_MODIFIED > TO_DATE('27/07/2014', 'DD/MM/YY') AND bb_bb60.GRADEBOOK_MAIN.DATE_MODIFIED IS NOT NULL)
	  OR (bb_bb60.ANNOUNCEMENTS.START_DATE > TO_DATE('27/07/2014', 'DD/MM/YY') AND bb_bb60.ANNOUNCEMENTS.START_DATE IS NOT NULL))
GROUP BY bb_bb60.COURSE_MAIN.COURSE_ID;

 SELECT 'rm -f ExportFile_'||bb_bb60.COURSE_MAIN.COURSE_ID||'.zip '||bb_bb60.COURSE_MAIN.COURSE_ID||'_log_details.txt'
    FROM bb_bb60.COURSE_MAIN, bb_bb60.GRADEBOOK_MAIN, bb_bb60.QTI_ASI_DATA, bb_bb60.CONFERENCE_MAIN, bb_bb60.CALENDAR, bb_bb60.COURSE_CONTENTS, bb_bb60.ANNOUNCEMENTS
   WHERE bb_bb60.COURSE_MAIN.COURSE_NAME != 'Personal Test Module'
     AND bb_bb60.COURSE_MAIN.PK1 = bb_bb60.GRADEBOOK_MAIN.CRSMAIN_PK1 (+)
     AND bb_bb60.COURSE_MAIN.PK1 = bb_bb60.QTI_ASI_DATA.PK1 (+) 
	 AND bb_bb60.COURSE_MAIN.PK1 = bb_bb60.CONFERENCE_MAIN.CRSMAIN_PK1 (+)
	 AND bb_bb60.COURSE_MAIN.PK1 = bb_bb60.CALENDAR.CRSMAIN_PK1 (+)
	 AND bb_bb60.COURSE_MAIN.PK1 = bb_bb60.COURSE_CONTENTS.CRSMAIN_PK1 (+)
	 AND bb_bb60.COURSE_MAIN.PK1 = bb_bb60.ANNOUNCEMENTS.CRSMAIN_PK1 (+)
	 AND ((bb_bb60.COURSE_MAIN.DTMODIFIED > TO_DATE('27/07/2014', 'DD/MM/YY') AND bb_bb60.COURSE_MAIN.DTMODIFIED IS NOT NULL)
      OR (bb_bb60.COURSE_CONTENTS.DTMODIFIED > TO_DATE('27/07/2014', 'DD/MM/YY') AND bb_bb60.COURSE_CONTENTS.DTMODIFIED IS NOT NULL)
	  OR (bb_bb60.CONFERENCE_MAIN.DTMODIFIED > TO_DATE('27/07/2014', 'DD/MM/YY') AND bb_bb60.CONFERENCE_MAIN.DTMODIFIED IS NOT NULL)
	  OR (bb_bb60.CALENDAR.DTMODIFIED > TO_DATE('27/07/2014', 'DD/MM/YY') AND bb_bb60.CALENDAR.DTMODIFIED IS NOT NULL)
      OR (bb_bb60.QTI_ASI_DATA.BBMD_DATE_MODIFIED > TO_DATE('27/07/2014', 'DD/MM/YY') AND bb_bb60.QTI_ASI_DATA.BBMD_DATE_MODIFIED IS NOT NULL)
	  OR (bb_bb60.GRADEBOOK_MAIN.DATE_MODIFIED > TO_DATE('27/07/2014', 'DD/MM/YY') AND bb_bb60.GRADEBOOK_MAIN.DATE_MODIFIED IS NOT NULL)
	  OR (bb_bb60.ANNOUNCEMENTS.START_DATE > TO_DATE('27/07/2014', 'DD/MM/YY') AND bb_bb60.ANNOUNCEMENTS.START_DATE IS NOT NULL))
GROUP BY bb_bb60.COURSE_MAIN.COURSE_ID;
