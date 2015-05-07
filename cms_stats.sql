/* number of unique users with eportfolios */

  SELECT COUNT(*) 
    FROM (SELECT OWNER_USERS_PK1
  	    FROM BB_BB60.PFLIO
GROUP BY OWNER_USERS_PK1)


/* number of eportfolios */

SELECT COUNT(*) 
  FROM BB_BB60.PFLIO


/* number of files in CMS in users and courses area (not directories) */

SELECT COUNT(*) 
  FROM CMS_FILES_USERS.XYF_FILES
 WHERE FILE_TYPE_CODE = 'F'

SELECT COUNT(*) 
  FROM CMS_FILES_COURSES.XYF_FILES
 WHERE FILE_TYPE_CODE = 'F'


/* number of users using CMS */

  SELECT COUNT(*) 
    FROM (SELECT * 
            FROM CMS_FILES_USERS.XYF_FILES
           WHERE FILE_TYPE_CODE = 'F'
GROUP BY CREATED_BY)


/* number of courses using CMS */

  SELECT COUNT(*) 
    FROM (SELECT * 
            FROM CMS_FILES_COURSES.XYF_FILES
   WHERE FILE_TYPE_CODE = 'F'
GROUP BY CREATED_BY)