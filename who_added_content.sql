/* First we search for the file which has been added, giving it the full name as is shown in Blackboard */

SELECT * FROM BB_BB60.COURSE_CONTENTS_FILES
 WHERE FILES_PK1 = (SELECT PK1 
 		      FROM BB_BB60.FILES
		     WHERE FILE_NAME LIKE '%Liverpool_Handout.doc%')


/* We take the pk1 from the above query and use it in this query to determine the USER_ID #
   of the person who added that content to Blackboard */

SELECT USER_ID
  FROM BB_BB60.USERS
 WHERE PK1 IN (SELECT USER_PK1 
 	         FROM BB_BB60.ACTIVITY_ACCUMULATOR
	        WHERE CONTENT_PK1 = 11111)