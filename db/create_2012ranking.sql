/* This file creates the table based on last year's data
 * which can be modified by the administrator later 
 */
DROP TABLE 2012ranking;
CREATE TABLE 2012ranking as (
select avg(r.ranking) as rating
,s.id as speaker_id
,r.session_id as session_id
,ceiling(count(r.session_id)/4) as count
FROM session_ranking r, speaker s, speaker_team t
WHERE r.session_id = t.session_id AND s.id = t.speaker_id
GROUP BY r.session_id, s.id);