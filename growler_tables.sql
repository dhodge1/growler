/*
Creates the table for storing theme information
Justin Bauguess 1/29/13
edited:
Brandon Foster 02/05/13
*/

--dropping tables before we create them
DROP TABLE theme; 

CREATE TABLE theme (
	theme_id			int			primary key
	,theme_name			varchar(30)
	,theme_description		varchar(250)
	,theme_creator			int		references user(id)
	,theme_year			year(4)
	,visible			boolean
	,active				boolean
	);
	
/*
Creates the table for storing user information
Justin Bauguess 1/29/13
*/	
DROP TABLE user; 
CREATE TABLE user (
	id			int		primary key
	);

/*
Bridge table for the users and themes, designed to help keep track of ranks
Justin Bauguess 1/29/13
*/	
DROP TABLE theme_ranking;
CREATE TABLE theme_ranking (
	user_id				int		REFERENCES user(id)	
	,theme_id			int(4)		REFERENCES theme(id)	
	,theme_rank			int		CHECK (theme_rank > 0 AND theme_rank < 11)
	);

/*
Creates the table for storing speaker information
Justin Bauguess 1/29/13
*/
DROP TABLE speaker; 
CREATE TABLE speaker (
	 id				int			PRIMARY KEY
	,first_name			varchar(30)
	,last_name			varchar(30)
	,suggested_by			int			REFERENCES user(id)		
	);
