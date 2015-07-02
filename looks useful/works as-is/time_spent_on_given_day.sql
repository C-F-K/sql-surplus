--[1] Query the first login in a specific day, such as Jan.5,2009

select TO_CHAR(min(TIMESTAMP), 'Month DD, YYYY HH24:MI:SS')
from bb_bb60.activity_accumulator 
where EVENT_TYPE='LOGIN_ATTEMPT' 
and TIMESTAMP like '%%' 
and USER_PK1=(
	select * from (
		select pk1 from bb_bb60.users order by dbms_random.value
	) where rownum = 1
); 

--[2] Query the last logout in the same day.

select TO_CHAR(max(TIMESTAMP), 'Month DD, YYYY HH24:MI:SS')
from bb_bb60.activity_accumulator 
where EVENT_TYPE='LOGOUT' 
and TIMESTAMP like '05-JAN-14' 
and USER_PK1=(
	select pk1 from bb_bb60.users where user_id='uSeRiD'
);