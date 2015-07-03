select (success + cleared) as total, cleared, success, cleared /
(success + cleared) as percentage from

  (select count(*) as cleared from bb_bb60.gradebook_log gl

    inner join bb_bb60.gradebook_main gm on gl.gradebook_main_pk1 = gm.pk1

  --  inner join course_main cm on gm.crsmain_pk1 = cm.pk1

  --  inner join users u on gl.user_pk1 = u.pk1

    where grade is null

    and gm.score_provider_handle = 'resource/x-bb-assessment'

    and attempt_creation is not null

    and deletion_event_ind = 'Y'

    and gl.modifier_username is not null),

--    and gl.date_logged > '2 SEP 2014'

--    and gl.date_logged < '12 DEC 2014'),

  (select count(*) as success from bb_bb60.gradebook_log gl

    inner join bb_bb60.gradebook_main gm on gl.gradebook_main_pk1 = gm.pk1

  --  inner join course_main cm on gm.crsmain_pk1 = cm.pk1

  --  inner join users u on gl.user_pk1 = u.pk1

    where attempt_creation is not null

    and gm.score_provider_handle = 'resource/x-bb-assessment'

    and deletion_event_ind = 'N');
-- ermahgerd dates though
--    and gl.date_logged > '2 SEP 2014'

--    and gl.date_logged < '12 DEC 2014');
