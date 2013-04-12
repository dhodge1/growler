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
 * NOTE: MySQL doesn't have boolean type.  Therefore, tinyint is used.  0 = true, 1 = false.
 *	
 */

/*
 * Creates the table for storing theme 
 * Creator references the user table as to who suggested the theme.
 * Visible determines if a theme can be viewed by regular users.
 */
DROP TABLE IF EXISTS theme; 
CREATE TABLE theme (
	 id			int		PRIMARY KEY auto_increment
	,name			varchar(30)
	,description		varchar(250)
	,creator		int		REFERENCES user(id)
	,year			year(4)
	,visible		boolean
	,reason			varchar(250) /*for user-suggested themes*/
	);
/*
 * Creates the table for storing user information
 * Corporate_id is used for leveraging corporate credentials.
 * Email is used to contact a user in case of a lost password.
 */	
DROP TABLE IF EXISTS user; 
CREATE TABLE user (
	id			int		primary key
	,name		varchar(26)
	,password	varchar(60)
	,corporate_id varchar(6)
	,email		varchar(40)
	);
/*
 * Bridge table for the users and themes, designed to help keep track of ranks
 * Notice that theme_rank is storing ranks between 1 and 10, 1 being "best".
 */	
DROP TABLE IF EXISTS theme_ranking;
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
DROP TABLE IF EXISTS isolated_theme_ranking;
CREATE TABLE isolated_theme_ranking (
	ranking_id			int		PRIMARY KEY auto_increment
	,theme_id			int		REFERENCES theme(id)
	,ranking			int
	);
/*
 * Creates the table for storing speaker information
 * Notice: suggested_by attribute is foreign key referencing
 * id attribute in user table
 * Visible is an attribute which determines if regular users can view the speaker.
 */
DROP TABLE IF EXISTS speaker; 
CREATE TABLE speaker (
	 id			int			PRIMARY KEY auto_increment
	,first_name		varchar(30)
	,last_name		varchar(30)
	,suggested_by		int			REFERENCES user(id)
	,visible		boolean
	);
/*
 * Creates the table for storing speaker ranks
 * temporary table to be replaced by session_ranking upon developing 
 * US10362, at which point session_ranking will bridge between
 * speaker_team (which itself bridges session_ranking and speaker tables)
 * and session tables.
 */
DROP TABLE IF EXISTS speaker_ranking;
CREATE TABLE speaker_ranking (
	ranking_id		int			PRIMARY KEY auto_increment
	,speaker_id		int			REFERENCES speaker(id)
	,ranking		int
	);
/*
 * Creates table for session information
 * A session is essentially a presentation given by a speaker_team (which may
 * be one or more speakers), attended by users.
 * A session has a start time, a start date, a duration, a location, 
 * and a track (which is either Technical or Business Friendly).
 * If multiple tracks need to be managed, we might centralize it with its
 * own table as we did with location. If there are only ever two tracks, 
 * and admin never need to add others, we will keep it as an attribute.
 */
DROP TABLE IF EXISTS session;
CREATE TABLE session (
	id			int			PRIMARY KEY auto_increment
	,name			varchar(50)
	,description		text
	,track			varchar(20)
	,session_date		date
	,start_time		time
	,duration		int
	,location		int		REFERENCES location(id)
	,session_key		varchar(3)	UNIQUE
	,isAttendable		boolean
	);
/*
 * Creates the table for attending a session
 * Final field is for keeping the integrity of survey-taking
 * 	(each user can only take one survey)
 * We don't want to know which users filled out which surveys,
 * 	but we have to enforce them taking just one survey.
 * Hence, when a person submits a survey, there is a condition 
 * 	where, if isRegistered is false for that given user_id and session_id,
 *	the attribute is made true and records are sumbitted to session_ranking
 *	if isRegistered is true, however, there page redirects to explain
 *	that they've already submitted a survey for that session, and no	 
 *	records are inserted into session_ranking.
 */	
DROP TABLE IF EXISTS attendance;
CREATE TABLE attendance (
	user_id		int	REFERENCES user(id)
	,session_id	int	REFERENCES session(id)
	,isRegistered	boolean
	);
/*
 * Creates the table for storing the survey questions,
 * which will be tied to session rankings. (Essentially, each rank value has
 * an associated question).
 */
DROP TABLE IF EXISTS question;
CREATE TABLE question (
	id			INT			PRIMARY KEY
	,text			VARCHAR(250)
	,year			YEAR(4) 
	);
/*
 * Creates a table for location information
 * A location is a room (or remote location) where a session is held
 * This is a separate table so that the locations are centralized and
 * sessions cannot all refer to the same place three different ways
 * and thus cause confusion- locations, instead, can be selected from
 * a centralized list produced from this table.
 */	
DROP TABLE IF EXISTS location;
CREATE TABLE location (
	id				int			PRIMARY KEY
	,description	varchar(50)
	);
/*
 * Creates the table for ranking sessions
 * There is no primary key: 
 * there is a high probability of multiple ratings given by different surveys
 * The created_on attribute is a timestamp of when the survey was submitted,
 * which is not a primary key because two records could conceivably be
 * submitted at the same time.
 */
DROP TABLE IF EXISTS session_ranking;
CREATE TABLE session_ranking (
	session_id		int	REFERENCES session(id)
	,question_id		int	REFERENCES question(id)
	,ranking		int	CHECK (ranking > 0 AND ranking < 6)
	);
/*
 * Creates the table for keeping track of speaker teams
 * Speaker teams are a way of allowing multiple speakers for a given session,
 * where a many to many relationship would exist, this bridge table associates
 * sessions and speakers.
 */
DROP TABLE IF EXISTS speaker_team;
CREATE TABLE speaker_team (
	session_id		int			REFERENCES session(id)
	,speaker_id		int			REFERENCES speaker(id)
	);
/* 
 * This file creates the table based on last year's data
 * which can be modified by the administrator later 
 */
DROP TABLE IF EXISTS ranks_2012;
CREATE TABLE ranks_2012(
speaker_id	int	REFERENCES speaker(id)
,rating	cast(double, 2, 1)
,count	int
);
/*
 * Session registration represents a unique session_id that
 * presenters can give to those attending a session.
 * The isAttendable field is a boolean that will allow an event to
 * be registered in the Attendance table only until 15 minutes after
 * the session has ended.
 * Some sort of timer will need to be created in order to ensure the
 * isAttendable field is set correctly based on the current date/time.
 */
DROP TABLE IF EXISTS session_registration;
CREATE TABLE session_registration (
key_id	varchar(3)
,session_id int references session(id)
,isAttendable tinyint
,PRIMARY KEY (key_id, session_id)
);
