/* A convenient way to change the role of a user across all modules they are enrolled */

UPDATE COURSE_USERS
   SET ROLE='P'
 WHERE USER_PK1 = (SELECT PK1
 		      FROM bb_bb60.USERS
 		     WHERE USER_ID = 'USER_ID');