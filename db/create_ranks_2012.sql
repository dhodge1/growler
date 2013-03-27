/*
 * This file creates the table based on last year's data
 * which can be modified by the administrator later 
 */
DROP TABLE ranks_2012;
CREATE TABLE ranks_2012 as (
select avg(r.ranking) as rating
,s.id as id
,ceiling(count(r.session_id)/4) as count
FROM session_ranking r, speaker s
WHERE r.session_id IN (select session_id from speaker_team) and s.id IN (select speaker_id from speaker_team) group by s.id);
