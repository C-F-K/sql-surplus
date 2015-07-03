/* Re-enable enrollment to then unenrol through Blackboard front end control panel */

UPDATE BB_BB60.COURSE_USERS 
   SET ROW_STATUS=0
 WHERE USERS_PK1 = (SELECT PK1--, USER_ID
		      FROM BB_BB60.USERS
	             WHERE USER_ID = 'USER_ID')
   AND CRSMAIN_PK1 = (SELECT PK1--, COURSE_NAME 
			FROM BB_BB60.COURSE_MAIN
		       WHERE COURSE_ID = 'COURSE_ID');