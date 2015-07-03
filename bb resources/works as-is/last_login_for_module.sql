/* You need to place the COURSE_PK1 into this query 3 times as shown */
/* This will provide you with a list of all users for that module and the last time they logged
   into that module, note this is not the last time they logged into Blackboard but that specific module */

SELECT D.LASTNAME LASTNAME, D.FIRSTNAME FIRSTNAME, D.USER_ID USERNAME, E.ROLE, C.TS LAST_LOGIN 
  FROM (SELECT USERS_PK1, MAX(TIMESTAMP) TS 
          FROM (SELECT USER_PK1, TIMESTAMP 
		          FROM BB_BB60.ACTIVITY_ACCUMULATOR 
                 WHERE COURSE_PK1 = 54367 ) A, 
               (SELECT USERS_PK1
			      FROM BB_BB60.COURSE_USERS 
				 WHERE CRSMAIN_PK1 = 54367 ) B 
          WHERE A.USER_PK1 (+) = B.USERS_PK1 
	   GROUP BY USERS_PK1) C, 
       (SELECT PK1, LASTNAME, FIRSTNAME, USER_ID 
	     FROM BB_BB60.USERS) D,
		 (SELECT ROLE, USERS_PK1
		    FROM BB_BB60.COURSE_USERS 
		   WHERE CRSMAIN_PK1 = 54367) E
 WHERE C.USERS_PK1 = D.PK1 
 AND D.PK1 = E.USERS_PK1;