/* Gives number of announcemnets made on Blackboard for a given user's modules in the last week */
/* To change between Staff and Student use ROLE='P' (Staff) and ROLE='S' (Student) */

SELECT COUNT(*) FROM (
    SELECT CM.COURSE_ID, 
               CM.COURSE_NAME, 
                A.SUBJECT, 
                A.ANNOUNCEMENT, 
                NVL(TO_DATE(A.END_DATE, 'DD-MM-YYYY'), TO_DATE(SYSDATE, 'DD-MM-YYYY')) END_DATE 
          FROM BB_BB60.COURSE_MAIN CM, 
	       BB_BB60.ANNOUNCEMENTS A,
              (SELECT CRSMAIN_PK1 
	         FROM BB_BB60.COURSE_USERS 
                WHERE ROLE='P' 
		  AND USERS_PK1 = (SELECT PK1 
                                     FROM BB_BB60.USERS 
				    WHERE USER_ID = 'dbrown')) ID 
 WHERE TO_DATE(SYSDATE, 'DD-MM-YYYY') >= TO_DATE(SYSDATE - 7, 'DD-MM-YYYY') 
   AND CM.PK1 = ID.CRSMAIN_PK1 AND A.CRSMAIN_PK1 = ID.CRSMAIN_PK1
)
;
 
 
 /* Remove the COUNT(*) to determime the actual announcements given */
 
 SELECT CM.COURSE_ID, 
        CM.COURSE_NAME, 
         A.SUBJECT,
         A.ANNOUNCEMENT,
        NVL(TO_DATE(A.END_DATE, 'DD-MM-YYYY'), TO_DATE(SYSDATE, 'DD-MM-YYYY')) END_DATE 
   FROM BB_BB60.COURSE_MAIN CM, 
        BB_BB60.ANNOUNCEMENTS A,
       (SELECT CRSMAIN_PK1 
          FROM BB_BB60.COURSE_USERS 
         WHERE ROLE='S' 
           AND USERS_PK1 = (SELECT PK1 
 		              FROM BB_BB60.USERS WHERE USER_ID = 'dbrown')) ID 
   WHERE TO_DATE(SYSDATE, 'DD-MM-YYYY') >= TO_DATE(SYSDATE - 7, 'DD-MM-YYYY') 
    AND CM.PK1 = ID.CRSMAIN_PK1 
   AND A.CRSMAIN_PK1 = ID.CRSMAIN_PK1;