/*
 * Inserts the default user.  This user is typically associated with last year's data.
 */
insert into user (id) values (2023);

/*Theme inserts*/
INSERT INTO theme VALUES (1, "Cloud Computing", "All things Cloud, from IaaS, PaaS, DaaS, SaaS, to hosting providers, brokers, and cloud-enabling appliances", 2023, "2013", true, true, NULL);
INSERT INTO theme VALUES (2, "Development Frameworks", "Any type of development framework, regardless of language", 2023, "2013", true, true, NULL);
INSERT INTO theme VALUES (3, "Software Process/Lifecycle", "Waterfall, Agile, Scrum, Kanban, process improvements, new techniques", 2023, "2013", true, true, NULL);
INSERT INTO theme VALUES (4, "Mobility", "Topics related to mobile computing in the enterprise, including mobile apps, phones, tablets, and other devices", 2023, "2013", true, true, NULL);
INSERT INTO theme VALUES (5, "Social and Collaboration", "Tools and Techniques that make the enterprise more social and allow people to better communicate and collaborate when they are not in the same room, floor, building, city, state, or country", 2023, "2013", true, true, NULL);
INSERT INTO theme VALUES (6, "Show and Tell", "Show and Tell (Description)", 2023, "2013", true, true, NULL);

/*
 * Inserts the speakers from 2012
 * Notice that the first attirbute, id, is NULL. This is because it is an auto-increment.
*/
insert into speaker values (NULL, "Ian", "Ratner", 2023, TRUE, TRUE);
insert into speaker values (NULL, "Ram", "Karra", 2023, TRUE, TRUE);
insert into speaker values (NULL,"Deborah","Cliburn",2023, TRUE, TRUE);
insert into speaker values (NULL,"Prashanth","Chakrapani",2023, TRUE, TRUE);
insert into speaker values (NULL,"Scott","Cruze",2023, TRUE, TRUE);
insert into speaker values (NULL,"Mark","Kelly",2023, TRUE, TRUE);
insert into speaker values (NULL,"Jim","Senter",2023, TRUE, TRUE);
insert into speaker values (NULL,"Phil","Spann",2023, TRUE, TRUE);
insert into speaker values (NULL,"Jeffrey","Allen",2023, TRUE, TRUE);
insert into speaker  values (NULL,"Bhaumik","Shah",2023, TRUE, TRUE);
insert into speaker  values (NULL,"Panagiotis","Tzerefos",2023, TRUE, TRUE);
insert into speaker values (NULL,"Ben","Pack",2023, TRUE, TRUE);
insert into speaker values (NULL,"David","Tucker",2023, TRUE, TRUE);
insert into speaker values (NULL,"Matt","Peter",2023, TRUE, TRUE);
insert into speaker values (NULL,"Pedro","Lopez",2023, TRUE, TRUE);
insert into speaker values (NULL,"John","Hills",2023, TRUE, TRUE);
insert into speaker values (NULL,"Bryan","Fails",2023, TRUE, TRUE);
insert into speaker values (NULL,"Glen","Wright",2023, TRUE, TRUE);
insert into speaker values (NULL,"Kevin","Barry",2023, TRUE, TRUE);
insert into speaker values (NULL,"Jeffery","Kissinger",2023, TRUE, TRUE);
insert into speaker values (NULL,"Beth","Jackson",2023, TRUE, TRUE);
insert into speaker values (NULL,"Brian","Hinsley",2023, TRUE, TRUE);
insert into speaker values (NULL,"Drew","Fredrick",2023, TRUE, TRUE);
insert into speaker values (NULL,"Glen","Ireland",2023, TRUE, TRUE);
insert into speaker values (NULL,"Robert","Clarence",2023, TRUE, TRUE);
insert into speaker values (NULL,"Sarah","Cottay",2023, TRUE, TRUE);
insert into speaker values (NULL,"Channing","Dawson",2023, TRUE, TRUE);
insert into speaker values (NULL,"Mike","Campbell",2023, TRUE, TRUE);
insert into speaker values (NULL,"Joshua","Eldridge",2023, TRUE, TRUE);
insert into speaker values (NULL,"Bruce","Parker",2023, TRUE, TRUE);
insert into speaker values (NULL,"Robin","Wilde",2023, TRUE, TRUE);
insert into speaker values (NULL,"Lydia","Cordell",2023, TRUE, TRUE);
insert into speaker values (NULL,"Team","Nirvana",2023, TRUE, TRUE);
insert into speaker values (NULL,"Amy","Thomason",2023, TRUE, TRUE);
insert into speaker values (NULL,"Charles","Lewis",2023, TRUE, TRUE);
insert into speaker values (NULL,"Jonathan","Williams",2023, TRUE, TRUE);
insert into speaker values (NULL,"Scott","Gentry",2023, TRUE, TRUE);
insert into speaker  values (NULL,"Jason","Norton",2023, TRUE, TRUE);
insert into speaker values (NULL,"Michael","Wehrle",2023, TRUE, TRUE);
insert into speaker values (NULL,"Shane","Closser",2023, TRUE, TRUE);
insert into speaker values (NULL,"Selene","Tolbert",2023, TRUE, TRUE);
insert into speaker values (NULL,"Michael","Berger",2023, TRUE, TRUE);
insert into speaker values (NULL,"Kamlesh","Sharma",2023, TRUE, TRUE);
insert into speaker values (NULL,"Kabita","Nayak",2023, TRUE, TRUE);
insert into speaker values (NULL,"Herb","Himes",2023, TRUE, TRUE);
insert into speaker values (NULL,"Stefanie","Edinger",2023, TRUE, TRUE);
insert into speaker values (NULL, "Phil", "Cornell", 2023, TRUE, TRUE);
insert into speaker values (NULL,"Allen", "Shacklock", 2023, TRUE, TRUE);

/*
 * Loads a raw data file of session data from last year
 * into the sessions table so we can analyze last year's data
 * Session has the following fields: ID,Topic,Summary,Track,Date,Time,Duration,Location
 * Without the LOCAL, access may be denied to your statement.
 */
load data LOCAL infile 'raw_data/sessions_2012.csv'
into table session
fields terminated by ','
ignore 1 lines;

/* Inserts the questions */
insert into question values (1, "This session met my expectations:", '2012');
insert into question values (2, "The speaker was knowledgable on the topic:", '2012');
insert into question values (3, "The speaker's presentation skills were good:", '2012');
insert into question values (4, "The facility was appropriate for the presentation:", '2012');

/* 
 * inserts locations
 */
 insert into location values (1, "KXTC Training Room");
 insert into location values (2, "KXOFFICE Training Room");


/*
 * Creates a table to use to process the data from last year
 */
DROP TABLE survey_techtober_12;
create table survey_techtober_12 (
	survey_id				int		 PRIMARY KEY AUTO_INCREMENT
	,session_id			int
	,question1			int
	,question2			int
	,question3			int
	,question4			int
	,comments			varchar(250)
	);
/*
 * Takes the raw data from a comma delimted file and dumps it into that table so we can process it for 
 * making last year's speaker rankings
 */
load data local infile 'raw_data/survey_techtober.csv'
into table survey_techtober_12
fields terminated by ','
ignore 1 lines;
/*
 * Now each record in that table has a record for each survey submitted last year.
 * Next we need to link the speakers from last year to their presentations.
*/
insert into speaker_team values (5 , 0);
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
