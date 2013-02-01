/*
Creates the table for storing theme information
Justin Bauguess 1/29/13
*/
/* drop table theme; */
create table theme (
	theme_id			int(4)			primary key
	,theme_name			varchar(30)
	,theme_description		varchar(250)
	,theme_creator			varchar(40)
	,theme_year			year(4)
	,visible			boolean
	,active				boolean
	);
	
/*
Creates the table for storing user information
Justin Bauguess 1/29/13
*/	
/* drop table users; */
create table users (
	user_id				varchar(40)		primary key
	);

/*
Bridge table for the users and themes, designed to help keep track of ranks
Justin Bauguess 1/29/13
*/	
/* drop table theme_ranking; */
create table theme_ranking (
	user_id				varchar(40)		
	,theme_id			int(4)			
	,theme_rank			int			check (theme_rank > 0 and theme_rank < 11)
	,constraint foreign key (user_id) references users(user_id)
	,constraint foreign key (theme_id) references theme(theme_id)
	);

/*
Creates the table for storing speaker information
Justin Bauguess 1/29/13
*/
/* drop table speaker; */
create table speaker (
	speaker_id			int(4)			primary key
	,speaker_first			varchar(30)
	,speaker_last			varchar(30)
	,suggested_by			varchar(40)		
	,constraint foreign key (suggested_by) references users(user_id)
	);
