/* This file creates the table based on last year's data which can be modified by the administrator later */
drop table ranks_2012;
create table ranks_2012 as (select avg(r.ranking) as rating, s.id, ceiling(count(r.session_id)/4) as count from session_ranking r, speaker s, speaker_team t where t.session_id = r.session_id and t.speaker_id = s.id group by s.id);