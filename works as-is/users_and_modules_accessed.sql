/* a lits of all users and the modules they have accessed */
/* Note, this may take a few minutes to run */
/* Note, this makes use of the BB_BB60_STATS.ACTIVITY_ACCUMULATOR so check you last date in that to see
   what date this query will run upto */

SELECT C.USER_ID, C.FIRSTNAME, C.LASTNAME, B.COURSE_NAME, B.COURSE_ID
  FROM (SELECT USER_PK1, COURSE_PK1 FROM (SELECT USER_PK1, COURSE_PK1, COUNT(*) 
  					    FROM BB_BB60_STATS.ACTIVITY_ACCUMULATOR
					   WHERE USER_PK1 IS NOT NULL 
					     AND COURSE_PK1 IS NOT NULL
					GROUP BY USER_PK1, COURSE_PK1)) A,
       (SELECT PK1, COURSE_NAME, COURSE_ID
       	  FROM BB_BB60.COURSE_MAIN) B,
       (SELECT PK1, USER_ID, FIRSTNAME, LASTNAME FROM BB_BB60.USERS
	 WHERE ROW_STATUS = 0
           AND INSTITUTION_ROLES_PK1 = 3) C
 WHERE A.USER_PK1 = C.PK1
   AND A.COURSE_PK1 = B.PK1;