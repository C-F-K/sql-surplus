/* shows all the information regarding layout on the Home Tab within Blackboard */

SELECT * FROM bb_bb60.module_layout
 WHERE layout_pk1 = (SELECT pk1 FROM bb_bb60.layout
                      WHERE users_pk1 = (SELECT pk1 FROM bb_bb60.users
	  			  	  WHERE user_id = 'user_id'))
				       ORDER BY module_pk1;
				       
				       
/* take the module pk1 and place into this query to match up pk1 with their titles */

SELECT title, pk1 
  FROM bb_bb60.module
 WHERE pk1 IN (SELECT module_pk1 
 		 FROM bb_bb60.module_layout
                WHERE layout_pk1 = (SELECT pk1 FROM bb_bb60.layout
                                     WHERE users_pk1 = (SELECT pk1 
                                     		          FROM bb_bb60.users
	  			  	                 WHERE user_id = 'user_id')));
	  			  	                 
/* you can now delete the content from a/all user's home page if desired */

DELETE FROM bb_bb60.module_layout
      WHERE module_pk1 IN (1);
      

/* having obtained your desired module_pk1s, you can see which users have this content 
   on their blackboard home page */
   
  SELECT user_id, firstname, lastname 
    FROM bb_bb60.users
   WHERE pk1 IN (SELECT users_pk1 
                   FROM bb_bb60.layout
                  WHERE pk1 IN (SELECT layout_pk1 
                   FROM bb_bb60.module_layout
                  WHERE module_pk1 IN (198,201,203)
GROUP BY layout_pk1));