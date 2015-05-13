/* Need to obtain the course_id for a given user */
/* In this example role is set to student */

SELECT COURSE_NAME, COURSE_ID
  FROM BB_BB60.COURSE_MAIN
 WHERE PK1 IN (SELECT CRSMAIN_PK1
	         FROM BB_BB60.COURSE_USERS
	        WHERE ROLE='S'
	          AND USERS_PK1 = (SELECT PK1 
  				     FROM BB_BB60.USERS
				    WHERE USER_ID = 'USER_ID'));


/* Need to take the COURSE_ID string from the prvious query */
/* and place it into this query to obtain the assignment names, gradebook_pk1s and qti_pk1s for that assignment */
/* Do not want to include a search for the gradebook Totals and Weighted Totals */

SELECT PK1, TITLE, QTI_ASI_DATA_PK1
  FROM BB_BB60.GRADEBOOK_MAIN
 WHERE CRSMAIN_PK1 = (SELECT PK1
 		        FROM BB_BB60.COURSE_MAIN
		       WHERE COURSE_ID = 'COURSE_ID'
		         AND TITLE NOT IN ('Total', 'Weighted Total'));


/* From the above QTI_ASI_DATA_PK1 you can obtain the username and grade - version 1 without essays etc*/

SELECT TOT.BATCH_UID, NUM.GRADE
  FROM BB_BB60.USERS TOT, (SELECT US.USERS_PK1, CO.COURSE_USERS_PK1, CO.GRADEBOOK_GRADE_PK1, CO.GRADE
			     FROM BB_BB60.COURSE_USERS US, (SELECT GR.COURSE_USERS_PK1, AT.GRADEBOOK_GRADE_PK1, AT.GRADE
							      FROM BB_BB60.GRADEBOOK_GRADE GR, (SELECT GRADEBOOK_GRADE_PK1, GRADE
											          FROM BB_BB60.ATTEMPT
												 WHERE QTI_RESULT_DATA_PK1 IN (SELECT PK1 
															         FROM BB_BB60.QTI_RESULT_DATA
																WHERE QTI_ASI_DATA_PK1 = 'QTI_ASI_DATA_PK1')) AT
							     WHERE GR.PK1 = AT.GRADEBOOK_GRADE_PK1) CO
			    WHERE US.PK1 = CO.COURSE_USERS_PK1
			      AND US.ROLE != 'P') NUM
 WHERE TOT.PK1 = NUM.USERS_PK1;

 
/* From the GRADEBOOK_MAIN_PK1 you can select user_id and grade - version 2 include essays etc */

SELECT TOT.BATCH_UID, NUM.GRADE
  FROM BB_BB60.USERS TOT, (SELECT US.USERS_PK1, CO.COURSE_USERS_PK1, CO.GRADE
			     FROM BB_BB60.COURSE_USERS US, (SELECT ATT.GRADE, GRD.COURSE_USERS_PK1
							      FROM BB_BB60.ATTEMPT ATT, (SELECT PK1, COURSE_USERS_PK1
											   FROM BB_BB60.GRADEBOOK_GRADE
											  WHERE GRADEBOOK_MAIN_PK1 = (SELECT PK1
														        FROM BB_BB60.GRADEBOOK_MAIN
														       WHERE PK1 = 'PK1')) GRD
							     WHERE ATT.GRADEBOOK_GRADE_PK1 = GRD.PK1) CO
			    WHERE US.PK1 = CO.COURSE_USERS_PK1
			      AND US.ROLE != 'P') NUM
 WHERE TOT.PK1 = NUM.USERS_PK1;