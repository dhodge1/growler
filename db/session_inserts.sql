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

