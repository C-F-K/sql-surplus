/* This allows you to set up guest access across a range of modules similar to
   Manage Tools | Tool Availability */
/* The SELECT statement shows all available Tools for those modules */
/* The UPDATE statement sets Guest Access for the selected Tools */

SELECT DISTINCT(LABEL)
  FROM BB_BB60.COURSE_APPLICATIONS
 WHERE CRSMAIN_PK1 IN (SELECT PK1
 			 FROM BB_BB60.COURSE_MAIN
 			WHERE COURSE_ID LIKE '%MATH%')
 			
UPDATE BB_BB60.COURSE_APPLICATION
   SET ALLOW_GUEST_IND = 'Y'
 WHERE CRSMAIN_PK1 IN (SELECT PK1
 			 FROM BB_BB60.COURSE_MAIN
 			WHERE COURSE_ID LIKE '%MATH%')
   AND LABEL IN ('Content Area', 'Staff Information')


/* This allows you to set up guest access across a range of modules similar to
   Manage Course Menu */
/* The SELECT statement shows all available Content Areas for those modules */
/* The UPDATE statement sets Guest Access for the selected Content Areas */

SELECT DISTINCT(LABEL)
  FROM BB_BB60.COURSE_TOC
 WHERE CRSMAIN_PK1 IN (SELECT PK1 
 			 FROM BB_BB60.COURSE_MAIN
 			WHERE COURSE_ID LIKE '%MATH%')
 	
UPDATE BB_BB60.COURSE_TOC
   SET ALLOW_GUEST_IND = 'Y'
 WHERE CRSMAIN_PK1 IN (SELECT PK1
 			 FROM BB_BB60.COURSE_MAIN
 			WHERE COURSE_ID LIKE '%MATH%')
   AND LABEL IN ('Module Informayion', 'Sessions/Resources')
   
   