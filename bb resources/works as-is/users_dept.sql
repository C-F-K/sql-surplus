/* No of users per department for a given month */
/* Note, at the University of Liverpool we only provide department details for staff  */
/* hence the institution_roles_pk1 = 3 */
/* To find students per department you would use institution_roles_pk1 = 1 */

/* Run SELECT PK1, ROLE_ID 
	 FROM BB_BB60.INSTITUTION_ROLES to determine your other institution_roles_pk1 */

  SELECT A.DEPARTMENT DEP, COUNT(*) 
    FROM (SELECT PK1, DEPARTMENT 
            FROM BB_BB60.USERS
		   WHERE INSTITUTION_ROLES_PK1 = 3
		     AND DEPARTMENT IS NOT NULL) A,
  	     (SELECT UNIQUE(USERS_PK1)
	        FROM BB_BB60.COURSE_USERS
		   WHERE USERS_PK1 IN (SELECT USER_PK1 
		 	   		 FROM BB_BB60.ACTIVITY_ACCUMULATOR
				        WHERE TIMESTAMP > TO_DATE('01/01/2014', 'DD/MM/YYYY')
					  AND TIMESTAMP < TO_DATE('01/02/2014', 'DD/MM/YYYY'))) B
   WHERE A.PK1 = B.USERS_PK1
GROUP BY A.DEPARTMENT;