/* Re-enable user to then delete through control panel */
/* First need to determine the row status for a given USER_ID */
/* Row Status of 3 is disabled user, 0 is enabled */

SELECT BATCH_UID,
       ROW_STATUS
  FROM BB_BB60.USERS
 WHERE USER_ID='USER_ID';

/* This update will re-enable the given USER_ID */

UPDATE BB_BB60.USERS
   SET ROW_STATUS=0
 WHERE USER_ID='USER_ID';

 