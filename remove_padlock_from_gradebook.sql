/* This script will show you all of the grades for each test/assessment item found within the gradebook
   for a specific user on a specific module. 
   An item which has a STATUS=7 is a completed assessment. 
   An item which has a STATUS=3 is a non completed assessment.
   
   You will find that items become padlocked in the gradebook when 
   the most upto date item (LATEST_IND='Y') has a status of 3 instead of 7 */

SELECT * FROM bb_bb60.attempt
 WHERE gradebook_grade_pk1 IN (SELECT pk1 FROM bb_bb60.gradebook_grade
                                WHERE course_users_pk1 IN (SELECT pk1 FROM bb_bb60.course_users
     						            WHERE crsmain_pk1 = 'crsmain_pk1'
                                                              AND users_pk1 = (SELECT pk1 FROM bb_bb60.users
                                                                                WHERE user_id = 'user_id')))
                                                                                
                                                                                
/* Once you have found your attempt_pk1 you can check you are looking at the right assessment by running 
   the following query and inserting the corresponding gradebook_grade_pk1 */

SELECT * 
  FROM bb_bb60.gradebook_main
 WHERE pk1 = (SELECT gradebook_main_pk1 
                FROM bb_bb60.gradebook_grade
               WHERE pk1 = 'gradebook_grade_pk1')
               

/* You now need to update the attempt entry to remove the padlock 
   Note, the entry should have a status = 3 and latest_ind = 'Y' */
   

UPDATE bb_bb60.attempt
   SET status = 7
 WHERE pk1 = 'attempt_pk1'
 
UPDATE bb_bb60.attempt
   SET latest_ind = 'N'
 WHERE pk1 = 'attempt_pk1
 

/* You can delete rogue attempts by running */

DELETE FROM bb_bb60.attempt
 WHERE pk1 = 'attempt_pk1
 
 
/* This query will show you all of the rogue attempts which are present in Blackboard and can be removed */

  SELECT gradebook_grade_pk1, COUNT(*) 
    FROM bb_bb60.attempt
   WHERE status = 3
GROUP BY gradebook_grade_pk1
  HAVING COUNT(*) > 1
 
                                                                                