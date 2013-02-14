load infile 'raw_data/session_data.csv'
into table session
fields terminated by ','
ignore 1 lines;

/*
 * Inserts the themes from 2012
 
insert into session (id, year, name) values (1 , 2012, "Leveraging Technology for Better Deployment");
insert into session (id, year, name) values (2 , 2012, "Cheap and Free Test Tools");
insert into session (id, year, name) values (3 , 2012, "Cloudy with a Chance of Continous Delivery");
insert into session (id, year, name) values (4 , 2012, "Data Visualization");
insert into session (id, year, name) values (5 , 2012, "Kickoff Meeting");
insert into session (id, year, name) values (6 , 2012, "Project Oz Overview");
insert into session (id, year, name) values (7 , 2012, "Cloud Transcoding Pilot");
insert into session (id, year, name) values (8 , 2012, "SQL Tips and Tricks");
insert into session (id, year, name) values (9 , 2012, "Standarizing Frame Rate");
insert into session (id, year, name) values (10 , 2012, "Activating SNIs Customer Data");
insert into session (id, year, name) values (11, , 2012, "TV Everywhere Overview");
insert into session (id, year, name) values (12 , 2012, "Social Media");
insert into session (id, year, name) values (13 , 2012, "Guerilla Usability Testing");
insert into session (id, year, name) values (14 , 2012, "Digital Architecture Committee");
insert into session (id, year, name) values (15 , 2012, "Virtual Desktop as a Service");
insert into session (id, year, name) values (16 , 2012, "Snidbit to pull Show Images");
insert into session (id, year, name) values (17 , 2012, "BPM in Digital");
insert into session (id, year, name) values (18 , 2012, "Digital BI");
insert into session (id, year, name) values (19 , 2012, "Living in the Microsoft Cloud");
insert into session (id, year, name) values (20 , 2012, "Planning Poker");
insert into session (id, year, name) values (21 , 2012, "Using JON to Manage Spring Apps");
insert into session (id, year, name) values (22 , 2012, "Jboss 6 and Arquillian");
insert into session (id, year, name) values (23 , 2012, "ICE Recipe Editor");
insert into session (id, year, name) values (24 , 2012, "Scripps Bootstrap");
insert into session (id, year, name) values (25 , 2012, "ABAC with Axiomatics");
insert into session (id, year, name) values (26 , 2012, "MySQL for the Oracle Professional");
insert into session (id, year, name) values (27 , 2012, "Designing Apps for Multi-Channel Delivery");
insert into session (id, year, name) values (28 , 2012, "AIM Social Login & Registration");
insert into session (id, year, name) values (29 , 2012, "Enterprise Mobile Applications Strategy");
insert into session (id, year, name) values (30 , 2012, "MAM Target State");
insert into session (id, year, name) values (31 , 2012, "Technology Panel");
insert into session (id, year, name) values (32 , 2012, "Network Overview");
insert into session (id, year, name) values (33 , 2012, "Apache Camel & Spring Integration");
*/