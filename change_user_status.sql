/* A convenient way to change the role of a user across all modules they are enrolled */

UPDATE COURSE_USERS
   SET ROLE='P'
 WHERE USERS_PK1 = (SELECT PK1
 		      FROM USERS
 		     WHERE USER_ID = 'USER_ID')