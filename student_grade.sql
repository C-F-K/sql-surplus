/* This script will show you all the tests and grades for a given student on a given module */
/* Place USER_ID and COURSE_ID (twice) where shown */
/* This could be easily adapted to get the grades for all students on a given module, or all modules for a given student */

SELECT COMB.TITLE, ATT.SCORE
  FROM BB_BB60.ATTEMPT ATT, (SELECT A.PK1, B.TITLE TITLE 
			       FROM (SELECT PK1, GRADEBOOK_MAIN_PK1
			  	       FROM BB_BB60.GRADEBOOK_GRADE
				      WHERE COURSE_USERS_PK1 = (SELECT PK1
								  FROM BB_BB60.COURSE_USERS
								 WHERE USERS_PK1 = (SELECT PK1 
										      FROM BB_BB60.USERS
										     WHERE USER_ID = 'USER_ID')
								   AND CRSMAIN_PK1 = (SELECT PK1
								                        FROM BB_BB60.COURSE_MAIN
								                       WHERE COURSE_ID = 'COURSE_ID'))) A,
				    (SELECT PK1, TITLE
					   FROM BB_BB60.GRADEBOOK_MAIN
					  WHERE CRSMAIN_PK1 = (SELECT PK1
								 FROM BB_BB60.COURSE_MAIN
								WHERE COURSE_ID = 'COURSE_ID')) B
			      WHERE A.GRADEBOOK_MAIN_PK1 = B.PK1) COMB
 WHERE ATT.GRADEBOOK_GRADE_PK1 = COMB.PK1