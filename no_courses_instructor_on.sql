/* Note the ROLE='P' which determines this user is an instructor */
/* The other roles you can check are:
   S - Student
   P - Instructor
   T - Teaching Assistant
   B - Course Builder
   G - Grader
   U - Guest */

SELECT COUNT(*) 
  FROM BB_BB60.COURSE_MAIN 
 WHERE PK1 IN (SELECT CRSMAIN_PK1 
                 FROM BB_BB60.COURSE_USERS 
	        WHERE ROLE='P' 
                  AND USERS_PK1 = (SELECT PK1 
				     FROM BB_BB60.USERS 
				    WHERE USER_ID ='dbrown'))