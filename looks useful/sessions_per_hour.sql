select to_char(timestamp,'MM/DD/YYYY HH12 AM') "timestamp", count(*)
from bb_bb60.activity_accumulator
where timestamp>to_date('12-16-2008 12:00:00AM', 'MM-DD-YYYY  HH12:MI:SSAM')
	and timestamp<to_date('12-16-2008 11:59:00PM', 'MM-DD-YYYY  HH12:MI:SSAM')
	group by to_char(timestamp,'MM/DD/YYYY HH12 AM');