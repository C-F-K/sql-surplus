/* Shows all files which have been uploaded to Blackboard by a user */
/* Both through didgital drop box etc */
/* Need to provide USER_ID where shown */

SELECT FILE_NAME, LINK_NAME 
  FROM BB_BB60.FILES
 WHERE PK1 IN (SELECT FILES_PK1 
  	   	 FROM BB_BB60.COURSE_USER_UPLOADS
		WHERE COURSE_USERS_PK1 IN (SELECT PK1 
					     FROM BB_BB60.COURSE_USERS
				            WHERE USERS_PK1 = (SELECT PK1
								 FROM BB_BB60.USERS
							        WHERE USER_ID = 'USER_ID')));

							        
/* You can cross check these files to ensure they were added via digital drop box */
/* by including DTMODIFIED on the select statement */
/* and checking that it matches (within a few seconds due to database writes etc) the date found in */

/* SELECT * 
     FROM BB_BB60.ACTIVITY_ACCUMULATOR
    WHERE USER_PK1 = (SELECT PK1
                        FROM BB_BB60.USERS
		       WHERE USER_ID = 'USER_ID')
      AND DATA = 'Digital Dropbox'