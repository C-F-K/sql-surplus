select co.owner_pk1, count(*) from conference_owner co, conference_main cm,
forum_main fm
                where co.pk1=cm.conference_owner_pk1
                and cm.pk1=fm.confmain_pk1
                group by co.owner_pk1
                having count(*) > 0;