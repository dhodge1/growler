/*
Creates the table for storing theme information
Justin Bauguess 1/29/13
*/
/* drop table theme; */
create table theme (
	theme_id			varchar(4)
	,theme_name			varchar(30)
	,theme_description	varchar(250)
	,theme_creator		varchar(40)
	,theme_year			year(4)
	,visible			boolean
	,active				boolean
	);
	
alter table theme
add constraint theme_pk primary key (theme_id);

/*
Creates the table for storing user information
Justin Bauguess 1/29/13
*/	
/* drop table users; */
create table users (
	user_id				varchar(40)
	,password			varchar(50)
	);

alter table users
add constraint users_pk primary key (user_id);

/*
Bridge table for the users and themes, designed to help keep track of ranks
Justin Bauguess 1/29/13
*/	
/* drop table theme_ranking; */
create table theme_ranking (
	user_id				varchar(40)
	,theme_id			varchar(4)
	,theme_rank			int
	);

alter table theme_ranking
add constraint theme_ranking_user_pk primary key (user_id, theme_id);

alter table theme_ranking
add constraint theme_ranking_user_fk foreign key (user_id) references users(user_id);

alter table theme_ranking
add constraint theme_ranking_theme_fk foreign key (theme_id) references theme(theme_id);

alter table theme_ranking
add constraint rank_check check (theme_rank >0 and theme_rank <11);

/*
Creates the table for storing speaker information
Justin Bauguess 1/29/13
*/
/* drop table speaker; */
create table speaker (
	speaker_id			varchar(4)
	,speaker_first		varchar(30)
	,speaker_last		varchar(30)
	,suggested_by		varchar(40)
	,speaking_since		year(4)
	);
	
alter table speaker
add constraint speaker_pk primary key (speaker_id);

alter table speaker
add constraint speaker_suggested_fk foreign key (suggested_by) references users(user_id);

