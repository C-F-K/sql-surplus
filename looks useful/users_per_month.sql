/* No of unique users per month */
/* You may need to use BB_BB60_STATS SCHEMA if searching for old dates */

SELECT COUNT(*) 
  FROM (SELECT USER_PK1 
          FROM BB_BB60.ACTIVITY_ACCUMULATOR
		 WHERE TIMESTAMP > TO_DATE('01/01/2014', 'DD/MM/YYYY')
 		   AND TIMESTAMP < TO_DATE('01/02/2014', 'DD/MM/YYYY')
		   AND USER_PK1 IS NOT NULL
 	  GROUP BY USER_PK1);
 	  
/* No of non unique users per month */
/* You may need to use BB_BB60_STATS SCHEMA if searching for old dates */
 	  
SELECT COUNT(*) 
  FROM (SELECT USER_PK1 
          FROM BB_BB60.ACTIVITY_ACCUMULATOR
		 WHERE TIMESTAMP > TO_DATE('01/01/2006', 'DD/MM/YYYY')
 		   AND TIMESTAMP < TO_DATE('01/02/2006', 'DD/MM/YYYY')
		   AND USER_PK1 IS NOT NULL
 	  GROUP BY SESSION_ID);
