/* Note in all 3 queries - search is performed only for students (ROLE='S') */

/* looks through activity_accumulator for any courses where an "Add Item" event 
   has taken place since the specified user last logged in.
   In this way you can search for any event in the acitivity_accumulator. */

SELECT COURSE_NAME
  FROM BB_BB60.COURSE_MAIN
 WHERE PK1 IN (SELECT COURSE_PK1 
                 FROM BB_BB60.ACTIVITY_ACCUMULATOR
                WHERE COURSE_PK1 IN (SELECT CRSMAIN_PK1
                                       FROM BB_BB60.COURSE_USERS 
                                      WHERE ROLE='S'  
                                        AND USERS_PK1 = (SELECT PK1 
                                                           FROM BB_BB60.USERS 
                                                          WHERE USER_ID ='user_id'))
                  AND DATA LIKE '%Add Item%'
                  AND TIMESTAMP > (SELECT TO_DATE(MAX(TIMESTAMP),'DD/MM/YY')
                                     FROM BB_BB60.ACTIVITY_ACCUMULATOR
                                    WHERE USER_PK1 = (SELECT PK1 
                                                        FROM bb_bb60.USERS
                                                       WHERE USER_ID = 'user_id'))
             GROUP BY COURSE_PK1)


/* searches the calendar table for any events where a date modified is greater 
   than the last time the specified user last logged in.
   Shows which modules have new calender entries. */
   
SELECT COURSE_NAME
  FROM BB_BB60.COURSE_MAIN
 WHERE PK1 IN (SELECT CRSMAIN_PK1 FROM BB_BB60.CALENDAR
                WHERE DTMODIFIED > (SELECT TO_DATE(MAX(TIMESTAMP),'DD/MM/YYYY')
                                      FROM BB_BB60.ACTIVITY_ACCUMULATOR
                                     WHERE USER_PK1 = (SELECT PK1 
                                                         FROM bb_bb60.USERS
                                                        WHERE USER_ID = 'user_id'))
                  AND CRSMAIN_PK1 IN (SELECT CRSMAIN_PK1
                                        FROM BB_BB60.COURSE_USERS 
                                       WHERE ROLE='S'  
                                         AND USERS_PK1 = (SELECT PK1 
                                                            FROM BB_BB60.USERS 
                                                           WHERE USER_ID ='user_id')))		
                                                           

/* this looks at the course_contents table and searches to see if any new content
   as specified in the CNTHNDLR_HANDLE LIKE ('%resource/x-bb-assignment%') statement
   has been added to any of the specified user's modules since they last logged in.
   Change this statement to search for any content */
								

SELECT COURSE_NAME
  FROM BB_BB60.COURSE_MAIN
 WHERE PK1 IN (SELECT CRSMAIN_PK1
                 FROM BB_BB60.COURSE_CONTENTS
                WHERE CRSMAIN_PK1 IN (SELECT CRSMAIN_PK1 
                                        FROM BB_BB60.COURSE_USERS 
                                       WHERE ROLE='S'  
                                         AND USERS_PK1 = (SELECT PK1 
                                                            FROM BB_BB60.USERS 
                                                           WHERE USER_ID ='user_id'))
                  AND CNTHNDLR_HANDLE LIKE ('%resource/x-bb-assignment%')
                  AND DTMODIFIED > (SELECT TO_DATE(MAX(TIMESTAMP),'DD/MM/YYYY') 
                                      FROM BB_BB60.ACTIVITY_ACCUMULATOR
                                     WHERE USER_PK1 = (SELECT PK1
                                                         FROM BB_BB60.USERS
                                                        WHERE USER_ID='user_id')))
