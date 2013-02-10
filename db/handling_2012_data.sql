/*
Creates a table to use to process the data from last year
*/
create table survey_techtober_12 (
	session_id			int
	,question1			int
	,question2			int
	,question3			int
	,question4			int
	,comments			varchar(250)
	);

/*
Takes the raw data from a comma delimted file and dumps it into a table so we can process it for 
making last year's speaker rankings
 */
load data infile 'survey_techtober.csv'
into table 'survey_techtober_12'
fields terminated by ','
ignore 1 lines;

/*
Now each record in that table has a record for each survey submitted last year.
  Next we need to link the speakers from last year to their presentations.
*/

insert into speaker_team (session_id, speaker_id) values (5 , 0);
insert into speaker_team (session_id, speaker_id) values (9 , 16);
insert into speaker_team (session_id, speaker_id) values (9 , 17);
insert into speaker_team (session_id, speaker_id) values (4 , 1);
insert into speaker_team (session_id, speaker_id) values (4 , 2);
insert into speaker_team (session_id, speaker_id) values (4 , 3);
insert into speaker_team (session_id, speaker_id) values (6 , 16);
insert into speaker_team (session_id, speaker_id) values (11 , 18);
insert into speaker_team (session_id, speaker_id) values (7 , 4);
insert into speaker_team (session_id, speaker_id) values (7 , 5);
insert into speaker_team (session_id, speaker_id) values (7 , 6);
insert into speaker_team (session_id, speaker_id) values (7 , 7);
insert into speaker_team (session_id, speaker_id) values (10 , 19);
insert into speaker_team (session_id, speaker_id) values (8 , 2);
insert into speaker_team (session_id, speaker_id) values (30 , 20);
insert into speaker_team (session_id, speaker_id) values (30 , 21);
insert into speaker_team (session_id, speaker_id) values (1 , 8);
insert into speaker_team (session_id, speaker_id) values (29 , 22);
insert into speaker_team (session_id, speaker_id) values (2 , 9);
insert into speaker_team (session_id, speaker_id) values (28 , 23);
insert into speaker_team (session_id, speaker_id) values (28 , 24);
insert into speaker_team (session_id, speaker_id) values (3 , 10);
insert into speaker_team (session_id, speaker_id) values (3 , 11);
insert into speaker_team (session_id, speaker_id) values (31 , 25);
insert into speaker_team (session_id, speaker_id) values (31 , 26);
insert into speaker_team (session_id, speaker_id) values (31 , 16);
insert into speaker_team (session_id, speaker_id) values (31 , 19);
insert into speaker_team (session_id, speaker_id) values (31 , 22);
insert into speaker_team (session_id, speaker_id) values (17 , 27);
insert into speaker_team (session_id, speaker_id) values (22 , 12);
insert into speaker_team (session_id, speaker_id) values (18 , 28);
insert into speaker_team (session_id, speaker_id) values (21 , 13);
insert into speaker_team (session_id, speaker_id) values (20 , 30);
insert into speaker_team (session_id, speaker_id) values (19 , 29);
insert into speaker_team (session_id, speaker_id) values (23 , 14);
insert into speaker_team (session_id, speaker_id) values (24 , 15);
insert into speaker_team (session_id, speaker_id) values (25 , 32);
insert into speaker_team (session_id, speaker_id) values (12 , 31);
insert into speaker_team (session_id, speaker_id) values (13 , 44);
insert into speaker_team (session_id, speaker_id) values (26 , 38);
insert into speaker_team (session_id, speaker_id) values (14 , 33);
insert into speaker_team (session_id, speaker_id) values (14 , 23);
insert into speaker_team (session_id, speaker_id) values (14 , 34);
insert into speaker_team (session_id, speaker_id) values (14 , 35);
insert into speaker_team (session_id, speaker_id) values (14 , 36);
insert into speaker_team (session_id, speaker_id) values (27 , 39);
insert into speaker_team (session_id, speaker_id) values (16 , 45);
insert into speaker_team (session_id, speaker_id) values (15 , 40);
insert into speaker_team (session_id, speaker_id) values (15 , 41);
insert into speaker_team (session_id, speaker_id) values (32 , 37);
insert into speaker_team (session_id, speaker_id) values (33 , 42);
insert into speaker_team (session_id, speaker_id) values (33 , 43);