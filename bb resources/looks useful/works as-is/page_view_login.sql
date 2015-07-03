/*no of page views, logins per day*/
select sum(page_views), sum(course_page_views), sum(login_attempts_success), sum(login_attempts_failure) from bb_bb60_stats.system_tracking
where timestamp > to_date('01/01/2004', 'DD/MM/YYYY')
and timestamp < to_date('01/02/2004', 'DD/MM/YYYY');