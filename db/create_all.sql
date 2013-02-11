/* Authors:
 * 	created by:
 * 	Justin Bauguess 	on 01/29/13
 *			
 *	edited by:
 *	Brandon Foster		from 02/05/13
 *			
 * Purpose:
 *	This script will drop and create every table designed.
 *	
 *	
 */

/*
Creates the table for storing theme information
*/

--dropping tables before we create them
DROP TABLE theme; 

CREATE TABLE theme (
	 id			int		PRIMARY KEY
	,name			varchar(30)
	,description		varchar(250)
	,creator		int		REFERENCES user(id)
	,year			year(4),
	,visible		boolean,
	,active			boolean
	);
	
/*
Creates the table for storing user information
*/	
DROP TABLE user; 
CREATE TABLE user (
	id			int		primary key
	);

/*
 * Bridge table for the users and themes, designed to help keep track of ranks
 * Notice that theme_rank is storing ranks between 1 and 10, 1 being "best".
 */	
DROP TABLE theme_ranking;
CREATE TABLE theme_ranking (
	user_id				int		REFERENCES user(id)	
	,theme_id			int		REFERENCES theme(id)	
	,theme_rank			int		CHECK (theme_rank > 0 AND theme_rank < 11)
	);
/*
 * Temporary Bridge table for ranking themes
 * Supports US10332, which specifies users are not tracked
 * Will be replaced when we start US10331: Exploration: Allow theme suggestion
 */
DROP TABLE isolated_theme_ranking;
CREATE TABLE isolated_theme_ranking (
	ranking_id			int		PRIMARY KEY
	,theme_id			int		REFERENCES theme(id)
	,ranking			int
	);
	
/*
 * Creates the table for storing speaker information
 * Notice: suggested_by attribute is foreign key referencing
 * id attribute in user table
 */
DROP TABLE speaker; 
CREATE TABLE speaker (
	 id			int			PRIMARY KEY
	,first_name		varchar(30)
	,last_name		varchar(30)
	,suggested_by		int			REFERENCES user(id)		
	);

/*
 * Creates the table for storing speaker ranks
 * temporary table to be replaced by session_ranking upon developing 
 * US10362, at which point session_ranking will bridge between
 * speaker_team (which itself bridges session_ranking and speaker tables)
 * and session tables.
 */
DROP TABLE speaker_ranking;
CREATE TABLE speaker_ranking (
	ranking_id		int			PRIMARY KEY
	,speaker_id		int			REFERENCS speaker(id)
	,ranking		int
	);
	
/*
 * Creates the table for storing the survey questions,
 * which will be tied to session rankings. (Essentially, each rank value has
 * an associated question).
 */
	
DROP TABLE question;
CREATE TABLE question (
	id				int			PRIMARY KEY
	,text			varchar(250)
	);
	
/*
 * Creates a table for location information
 * A location is a room (or remote location) where a session is held
 */	

DROP TABLE location;
CREATE TABLE location (
	id				int			PRIMARY KEY
	,description	varchar(50)
	);
	
/*
 * Creates table for session information
 * A session is essentially a presentation given by a speaker_team (which may
 * be one or more speakers), attended by users.  A session has a start time, a start 
 * date, a duration, a location, and a track (which is either Technical or 
 * Business Friendly).
 */

DROP TABLE session;
CREATE TABLE session (
	id					int			PRIMARY KEY
	,name				varchar(50)
	,description		text
	,track				varchar(20)
	,session_date		date
	,start_time			time
	,duration			int
	,location			int			REFERENCES location(id)
	
	);
	
/*
 * Creates the table for ranking sessions
 * 
 */

DROP TABLE session_ranking;
CREATE TABLE session_ranking (
	session_id		int	REFERENCES session(id)
	,user_id		int	REFERENCES user(id)
	,question_id		int	REFERENCES question(id)
	,ranking		int	CHECK (ranking > 0 AND ranking < 6)
	,PRIMARY KEY (session_id, user_id, question_id)
	);

/*
 * Creates the table for keeping track of speaker teams
 * Speaker teams are a way of allowing multiple speakers for a given session,
 * where a many to many relationship would exist, this bridge table associates
 * sessions and speakers.
 */

DROP TABLE speaker_team;
CREATE TABLE speaker_team (
	session_id		int			REFERENCES session(id)
	,speaker_id		int			REFERENCES speaker(id)
	);


