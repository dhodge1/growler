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
drop database if exists growler_db;
create database growler_db;
use growler_db;
/*
* Ensures the database uses Eastern time
*/
SET time_zone = 'America/New_York';
/*
 * Creates the table for storing theme information
 */

/*dropping tables before we create them*/
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
 */	
DROP TABLE IF EXISTS user; 
CREATE TABLE user (
	id			int		primary key auto_increment
	,name			varchar(41)	UNIQUE	
	,password		varchar(60)
	,corporate_id		varchar(6)
	,email			varchar(50)
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
	user_id		int			REFERENCES user(id)
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
 * Survey key is a short, unique number allowing survey-takers to register their session
 */

DROP TABLE IF EXISTS session;
CREATE TABLE session (
	id			int		PRIMARY KEY auto_increment
	,name			varchar(70)
	,description		text
	,track			varchar(20)
	,session_date		date
	,start_time		time
	,duration		time
	,location		int		REFERENCES location(id)
	,session_key	varchar(4) unique
	);
	
/*
 * Creates the table for attending a session
 * Final field is for keeping the integrity of survey-taking
 * 	(each user can only take one survey)
 * We don't want to know which users filled out which surveys,
 * 	but we have to enforce them taking just one survey.
 * Hence, when a person submits a survey, there is a condition 
 * 	where, if isSurveyTaken is false for that given user_id and session_id,
 *	the attribute is made true and records are submitted to session_ranking
 *	if isSurveyTaken is true, however, there page redirects to explain
 *	that they've already submitted a survey for that session, and no	 
 *	records are inserted into session_ranking.
 */	
DROP TABLE IF EXISTS attendance;
CREATE TABLE attendance (
	user_id		int	REFERENCES user(id)
	,session_id	int	REFERENCES session(id)
	,isSurveyTaken	boolean	DEFAULT '0'
	,surveySubmitTime datetime
	,CONSTRAINT pk_attendance PRIMARY KEY(user_id, session_id)
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
	id				varchar(10)			PRIMARY KEY
	,description	varchar(30)
	,capacity		int
	,building		varchar(20)
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
 * Also represents an assignment for a single speaker.  Each record must be unique,
 * otherwise there would be the chance of having the same speaker assigned to the same 
 * session multiple times.
 */

DROP TABLE IF EXISTS speaker_team;
CREATE TABLE speaker_team (
	session_id		int			REFERENCES session(id)
	,speaker_id		int			REFERENCES speaker(id)
	,constraint pk_speaker_team primary key (session_id, speaker_id)
	);


/*
 * Inserts the default user.  This user is typically associated with last year's data.
 */
insert into user values (202300, "Default User", sha1('password'), NULL, NULL);
insert into user values (808300, "Administrator", sha1('password'), NULL, NULL);


/*Theme inserts*/
INSERT INTO theme VALUES (1, "Cloud Computing", "All things Cloud, from IaaS, PaaS, DaaS, SaaS, to hosting providers, brokers, and cloud-enabling appliances", 202300, "2013", true, NULL);
INSERT INTO theme VALUES (2, "Development Frameworks", "Any type of development framework, regardless of language", 202300, "2013", true, NULL);
INSERT INTO theme VALUES (3, "Software Process/Lifecycle", "Waterfall, Agile, Scrum, Kanban, process improvements, new techniques", 202300, "2013", true, NULL);
INSERT INTO theme VALUES (4, "Mobility", "Topics related to mobile computing in the enterprise, including mobile apps, phones, tablets, and other devices", 202300, "2013", true, NULL);
INSERT INTO theme VALUES (5, "Social and Collaboration", "Tools and Techniques that make the enterprise more social and allow people to better communicate and collaborate when they are not in the same room, floor, building, city, state, or country", 202300, "2013", true, NULL);
INSERT INTO theme VALUES (6, "Show and Tell", "Show and Tell (Description)", 202300, "2013", true, NULL);

/*
 * Inserts the speakers from 2012
*/
insert into speaker (id, first_name, last_name, suggested_by, visible) values (49, "Ian", "Ratner", 202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (1, "Ram", "Karra", 202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (2,"Deborah","Cliburn",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (3,"Prashanth","Chakrapani",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (4,"Scott","Cruze",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (5,"Mark","Kelly",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (6,"Jim","Senter",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (7,"Phil","Spann",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (8,"Jeffrey","Allen",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (9,"Bhaumik","Shah",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (10,"Panagiotis","Tzerefos",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (11,"Ben","Pack",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (12,"David","Tucker",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (13,"Matt","Peter",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (14,"Pedro","Lopez",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (15,"John","Hills",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (16,"Bryan","Fails",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (17,"Glen","Wright",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (18,"Kevin","Barry",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (19,"Jeffery","Kissinger",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (20,"Beth","Jackson",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (21,"Brian","Hinsley",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (22,"Drew","Fredrick",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (23,"Glen","Ireland",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (24,"Robert","Clarence",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (25,"Sarah","Cottay",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (26,"Channing","Dawson",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (27,"Mike","Campbell",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (28,"Joshua","Eldridge",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (29,"Bruce","Parker",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (30,"Robin","Wilde",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (31,"Lydia","Cordell",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (32,"Team","Nirvana",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (33,"Amy","Thomason",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (34,"Charles","Lewis",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (35,"Jonathan","Williams",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (36,"Scott","Gentry",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (37,"Jason","Norton",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (38,"Michael","Wehrle",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (39,"Shane","Closser",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (40,"Selene","Tolbert",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (41,"Michael","Berger",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (42,"Kamlesh","Sharma",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (43,"Kabita","Nayak",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (44,"Herb","Himes",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (45,"Stefanie","Edinger",202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (46, "Phil", "Cornell", 202300, TRUE);
insert into speaker (id, first_name, last_name, suggested_by, visible) values (47,"Allen", "Shacklock", 202300, TRUE);

/*
 * Loads a raw data file of session data from last year
 * into the sessions table so we can analyze last year's data
 * Session has the following fields: ID,Topic,Summary,Track,Date,Time,Duration,Location
 * Without the LOCAL, access may be denied to your statement.
 */
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('1', 'Leveraging Technology for Better Deployment Collaboration', 'The ServiceNow team is planning to implement new features that provide improvements in communication,collaboration and knowledge retention around and during deployments.', 'Business Friendly', '2012-10-17', '13:00:00', '0:25:00', '1', '356a');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('2', 'Cheap and Free Test Tools', 'This presentation will provide an overview and demonstration of open source or inexpensive tools for test design,test management,defect tracking,test data creation,test automation,test evaluation and web-based load testing.', 'Technical', '2012-10-17', '13:30:00', '0:25:00', '1', '5a3b');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('3', 'Cloudy with a Chance of Continuous Delivery', 'Discussion of advantages,disadvantages,and adoption of continuous deployment and delivery as well as business benefits and pain points as they are in the current (in-house) environment and as we move portions into Amazon AWS (specifically the VPC,Virtual Private Cloud),which involves multiple technologies and services with the goal to save time and money maintaining the CD/CI environment.', 'Technical', '2012-10-17', '14:00:00', '0:55:00', '1', '77de');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('4', 'Data Visualization', 'An overview of data visualization tools with a demo of two and a discussion of how they can be used with MAM data.', 'Technical', '2012-10-17', '9:30:00', '0:25:00', '1', '1b64');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('5', 'Kickoff Meeting', 'A kickoff meeting', 'Business Friendly', '2012-10-18', '16:00:00', '0:10:00', '1', 'ac34');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('6', 'Project OZ - The File-Based Workflow Initiative', 'An overview of how the file-based workflow initiative is impacting SNI,and why it is important to the core businesses. The presentation will help explain SNI\'s evolution from a videotape to a file-based media infrastructure. A snapshot of the current project status,and a view into the future objectives of the project will be described.', 'Business Friendly', '2012-10-17', '10:00:00', '0:25:00', '2', 'c1df');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('7', 'Cloud Transcoding Pilot', 'The Solutions Engineering team working with NLV Operations has successfully piloted a cloud transcoding workflow using Zencoder,S3 storage,and Aspera.', 'Technical', '2012-10-17', '10:30:00', '0:25:00', '1', '902b');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('8', 'SQL Tips and Tricks', 'This presentation will show how to enhanced performance and solve some common problems in Oracle using SQL.', 'Technical', '2012-10-17', '11:00:00', '0:55:00', '1', 'fe5d');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('9', 'Standarizing Frame Rate', 'A discussion of standardizing frame rates', 'Technical', '2012-10-18', '16:00:00', '0:10:00', '1', '0ade');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('10', 'Activating SNI\'s Customer Data Portfolio', 'What is SNI\'s customer data footprint? 35MM+ customer records across 15+ databases. Over 26MM unique visitors to our websites. Over 10MM social connections. SNI has a lot of customer data. Find out how we are activating and protecting that data to drive our business.', 'Business Friendly', '2012-10-17', '11:00:00', '0:55:00', '2', 'b1d5');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('11', 'TV Everywhere Overview', 'TV-Everywhere (TV-E),also known as Subscriber Authentication is a significant trend in the pay television business. The concept was launched by Time Warner Cable and Comcast in 2009 and is intended to allow all pay TV subscribers to view content on many platforms. Scripps will be creating TV-E website and mobile apps to allow viewers to watch full episodes online or via mobile devices.', 'Business Friendly', '2012-10-17', '10:30:00', '0:25:00', '2', '17ba');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('12', 'Using Social Media for Team Collaboration', 'In this presentation Lydia will talk about the pros and cons of using social media tools such as Google+,Sococo,Lync and others to improve communication and collaboration among virtual teams.', 'Business Friendly', '2012-10-18', '13:00:00', '0:25:00', '2', '7b52');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('13', 'Homegrown Guerrilla Usability Testing', 'An inside look into the rapid fire low and mid-fidelity usability testing efforts currently being developed and deployed by the SNI IxD department. Questions to be addressed will include: What\'s the aim of the testing? How is it different from our standard usability testing efforts? What are we hoping to accomplish? Are there drawbacks to this kind of testing? What have we learned so far?', 'Business Friendly', '2012-10-18', '13:30:00', '0:25:00', '2', 'bd30');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('14', 'What\'s New with the Digital Software Architecture Committee', 'Come hear what the DSAC has been up to since last year\'s Techtoberfest. The DSAC has been working on recommendations and best practices for timely subject areas including REST services,Object Caching and Spring. Or maybe you didn\'t know that Digital has a Software Architecture Committee? Then stop by to learn about the DSAC and how they can help your development team leverage tribal knowledge around best practices,proven frameworks and technologies.', 'Business Friendly', '2012-10-18', '14:00:00', '0:55:00', '2', 'fa35');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('15', 'Virtual Desktops in the Cloud', 'This presentation will talk to how the IT is utilizing VDI (Virtual Desktop Infrastructure) technology as well as lessons learned. Topics will include: What is Virtual Desktop Infrastructure? What are the benefits of this technology? What are the new areas for discovery/growth? What are the costs?', 'Business Friendly', '2012-10-18', '15:30:00', '0:25:00', '1', 'f1ab');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('16', 'Using SNidbit to Pull Show Images', 'Have you ever needed a show image or logo for a presentation that does not exist? Did you know that you could pull images by watching shows in Snidbit and frame grab the images you need? This presentation will show a technique to do just that. ', 'Business Friendly', '2012-10-17', '9:30:00', '0:25:00', '2', '1574');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('17', 'Business Process Management in Digital', 'This presentation will discuss Digital\'s efforts to introduce BPM and related technology into Digital. We will cover the social aspect and its overall importance to the success of the organization.', 'Business Friendly', '2012-10-18', '9:00:00', '0:25:00', '2', '716');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('18', 'Digital\'s BI Current State and Vision', 'This presentation will provide a definition of Business Intelligence and an assessment of the current and future state of BI in Digital.', 'Business Friendly', '2012-10-17', '9:30:00', '0:25:00', '2', '9e6a');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('19', 'Living in the Microsoft Cloud', 'Come and see how the SharePoint team is looking at using Microsoft\'s cloud infrastructure and tools to develop and host applications and services in the cloud. Microsoft now has in place a host of various cloud-based offerings that allows a company to quite literally virtually replace in-house Information Technology infrastructure. This presentation will cover the major components of Microsoft\'s cloud offerings with real world demonstrations.', 'Technical', '2012-10-18', '10:00:00', '0:55:00', '2', 'b3f0');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('20', 'Agile Estimation Planning Poker Workshop', 'Ever wish you had an estimation technique that could be leveraged both with onsite and remote participants while providing a great framework for collaboration as well? Why not try Estimation Planning Poker with your agile team? Join us for a fun hands on demonstration on how to do planning poker with your team to achieve better estimation results. Want to know more on the Planning Poker technique prior to session,go here: http://planningpoker.com/ ', 'Business Friendly', '2012-10-18', '11:00:00', '0:55:00', '2', '9103');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('21', 'JBoss Operations Network (JON)', 'The presentation will demonstrate exposing Spring entities and some monitoring features.', 'Technical', '2012-10-17', '9:30:00', '0:25:00', '1', '472b');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('22', 'JBoss 6 and Arquillan', 'This presentation will show the benefits of the new lightweight container JBoss container in EAP 6. In addition,we will discuss how Arquillian,an open-source project for testing enterprise Java applications,can help speed up development and testing on EAP 6. ', 'Technical', '2012-10-18', '9:00:00', '0:25:00', '1', '12c6');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('23', 'Using the ICE Framework to Create a Recipe Editor', 'This presentation will cover the feature set used to create the Recipe Editor for the Culinary Staff in NYC. We will include a introduction to the ICE framework and the enhancements made by SNI to meet user\'s requirements. ', 'Technical', '2012-10-18', '10:00:00', '0:55:00', '1', 'd435');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('24', 'Rapid UI Development using Bootstrap', 'This presentation will cover the Scripps Bootstrap UI development framework including the motivation for developing a common UI framework,the capabilities included in Bootstrap and a demo of building a page with Bootstrap.', 'Technical', '2012-10-18', '11:00:00', '0:55:00', '1', '4d13');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('25', 'Attribute-Based Access Control with Axiomatics', 'This presentation will discuss an authorization model that provides dynamic,context-aware access control.', 'Technical', '2012-10-18', '13:00:00', '0:25:00', '1', 'f6e1');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('26', 'MySQL for the Oracle Professional', 'MySQL is becoming more prevalent in IT lately,with an ever-increasing feature set,high availability options,and cost effective deployments. Prepare yourself to be an effective DBA or developer in the MySQL world. This presentation will show you how to translate your Oracle skills to MySQL with live demos of common tools and methods that you will use on a daily basis. Both DBA and developer skills will be covered.', 'Technical', '2012-10-18', '13:30:00', '0:25:00', '1', '8873');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('27', 'Designing Applications for Multi-Platform Delivery', 'This presentation will discuss a framework to manage content across platforms. Topics will include HTML 5,touch interfaces,rich media,behavioral targeting and presentation across web,mobile and email. ', 'Business Friendly', '2012-10-18', '14:00:00', '0:55:00', '1', 'bc33');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('28', 'AIM Social Login and Registration', 'Sit in to get an architectural and functional overview of the new AIM social login and user registration system. AIM is set to be launched on the new cookingchanneltv.com and is slated to eventually replace the current UR3 system. AIM will enhance the social login and registration by supporting more social providers and reducing the barrier to registration. We will discuss functional advantages of AIM and go through the challenges of keeping users synchronized between UR3 and AIM while sites transition from one system to the other.', 'Technical', '2012-10-17', '14:00:00', '0:25:00', '2', '0a57');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('29', 'Enterprise Mobile Apps Strategy', 'With the proliferation of personal devices in the workplace,one may wonder what we as a company are doing about Mobile Applications in the Enterprise. This talk with share the IT Strategy for Enterprise Mobile Apps in the workplace,and what to expect in the future.', 'Business Friendly', '2012-10-17', '13:30:00', '0:25:00', '2', '7719');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('30', 'Media Asset Management Target State', 'The existing Media Asset Management (MAM) infrastructure was put into service over the past seven years and has become foundational for internal processes and mission critical for linear scheduling and digital publishing of content to consumers and partners. In addition to an aging infrastructure upon which we continue to build,the business demands have grown and changed in nature,requiring a new vision for the direction of MAM. This presentation will provide an overview of the business and technical drivers for the next generation of MAM.', 'Business Friendly', '2012-10-17', '13:00:00', '0:25:00', '2', '22d2');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('31', 'Technology Panel', 'A panel to discuss technology', 'Technical', '2012-10-18', '16:00:00', '0:10:00', '1', '6326');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('32', 'Network Current and Future State', 'This session will provide an overview of the company\'s network infrastructure,current and future state. Jason Norton,Director of Telecommunications,will discuss the LAN,WAN,data center and wireless infrastructure that supports our users and applications. Jason will also discuss future trends in networking and take questions from the audience.', 'Business Friendly', '2012-10-18', '16:00:00', '0:55:00', '2', 'cb4e');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('33', 'Integration Frameworks - Apache Camel and Spring Integration', 'Apache Camel and Spring Integration are integration frameworks based on Enterprise Integration Patterns. Both provide a simple model to develop integration solutions.', 'Technical', '2012-10-18', '16:00:00', '0:55:00', '1', 'b669');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('34', 'Agile Data Modeling', 'Traditionally,data modeling has been a very time intensive exercise that involves significant effort from the data modeler and the members of the application development team. To make the process a lot more interesting the views expressed by certain sections of the data modeling community have not always been in alignment with those expressed by the agile community. However,over the past few years quite a few data practitioners have been experimenting with the concept of agile data modeling and have been sharing their lessons from the trenches. A more recent development in the concept of agile data modeling has been the use of universal patterns in data modeling.', 'Technical', '2012-10-17', '10:00:00', '0:25:00', '1', 'f1f8');
INSERT INTO `growler_db`.`session` (`id`, `name`, `description`, `track`, `session_date`, `start_time`, `duration`, `location`, `session_key`) VALUES ('35', 'Cooking Channel TV Monitoring Strategy', 'This presentation will talk about the monitoring strategy that was developed for the CCTV Relaunch Project. Topics will include architectural design,approach and buildout. ', 'Technical', '2012-10-18', '15:30:00', '0:25:00', '2', '972a');

/* Inserts the questions */
insert into question values (1, "This session met my expectations:", '2012');
insert into question values (2, "The speaker was knowledgable on the topic:", '2012');
insert into question values (3, "The speaker's presentation skills were good:", '2012');
insert into question values (4, "The facility was appropriate for the presentation:", '2012');

/* 
 * inserts locations
 */
 insert into location( id, description, capacity, building) values (1, "KXTC Training Room", 20, 'Knoxville Office');
 insert into location (id, description, capacity, building) values (2, "KXOFFICE Training Room", 20, 'Knoxville Office');
 insert into location (id, description, capacity, building) values ('TBD', "To Be Determined", 20, 'To Be Determined');


/*
 * Now each record in that table has a record for each survey submitted last year.
 * Next we need to link the speakers from last year to their presentations.
*/
insert into speaker_team values (5 , 49);
insert into speaker_team values (9 , 16);
insert into speaker_team values (9 , 17);
insert into speaker_team values (4 , 1);
insert into speaker_team values (4 , 2);
insert into speaker_team values (4 , 3);
insert into speaker_team values (6 , 16);
insert into speaker_team values (11 , 18);
insert into speaker_team values (7 , 4);
insert into speaker_team values (7 , 5);
insert into speaker_team values (7 , 6);
insert into speaker_team values (7 , 7);
insert into speaker_team values (10 , 19);
insert into speaker_team values (8 , 2);
insert into speaker_team values (30 , 20);
insert into speaker_team values (30 , 21);
insert into speaker_team values (1 , 8);
insert into speaker_team values (29 , 22);
insert into speaker_team values (2 , 9);
insert into speaker_team values (28 , 23);
insert into speaker_team values (28 , 24);
insert into speaker_team values (3 , 10);
insert into speaker_team values (3 , 11);
insert into speaker_team values (31 , 25);
insert into speaker_team values (31 , 26);
insert into speaker_team values (31 , 16);
insert into speaker_team values (31 , 19);
insert into speaker_team values (31 , 22);
insert into speaker_team values (17 , 27);
insert into speaker_team values (22 , 12);
insert into speaker_team values (18 , 28);
insert into speaker_team values (21 , 13);
insert into speaker_team values (20 , 30);
insert into speaker_team values (19 , 29);
insert into speaker_team values (23 , 14);
insert into speaker_team values (24 , 15);
insert into speaker_team values (25 , 32);
insert into speaker_team values (12 , 31);
insert into speaker_team values (13 , 44);
insert into speaker_team values (26 , 38);
insert into speaker_team values (14 , 33);
insert into speaker_team values (14 , 23);
insert into speaker_team values (14 , 34);
insert into speaker_team values (14 , 35);
insert into speaker_team values (14 , 36);
insert into speaker_team values (27 , 39);
insert into speaker_team values (16 , 45);
insert into speaker_team values (15 , 40);
insert into speaker_team values (34 , 7);
insert into speaker_team values (35 , 46);
insert into speaker_team values (35 , 47);
insert into speaker_team values (15 , 41);
insert into speaker_team values (32 , 37);
insert into speaker_team values (33 , 42);
insert into speaker_team values (33 , 43);


/* 
 * This file creates the table based on last year's data
 * which can be modified by the administrator later 
 */
DROP TABLE IF EXISTS ranks_2012;
CREATE TABLE ranks_2012 (
rating	DECIMAL(3, 2)
,speaker_id	int	REFERENCES speaker(id)
,count	int
);

/*
 * Loads a raw data file of session ranking data from last year
 * into the ranks_2012 table
 * ranks_2012: speaker_id, rating, and count
 */
load data LOCAL infile 'C:/Users/162107/Documents/GitHub/growler/db/raw_data/ranks_2012_out.csv'
into table ranks_2012
fields terminated by ',';

alter table session 
add column session_key varchar(4) UNIQUE;

/*
 * The Comments table is to store comments made after a survey.
 * We don't want to know who made the comment so it's anonymous, we just want the text and the session.
 */
create table comments(
	session_id	int		references session(id)
	,comment	varchar(250)
);
/*
 * The registration table is there to allow users to pick what sessions they are interested in attending.
 */
create table registration (
	user_id				int		references user(id)
	,session_id			int		references session(id)
	,date_registered	date
	,time_registered	time
	,reason				varchar(250)
	,constraint pk_registration primary key (user_id, session_id)
);