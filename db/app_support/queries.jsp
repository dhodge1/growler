<%-- This file is for storing the queries and insert statements that will be commonly used for the Growler Application -->
<%!
	String selectThemeName = "select name from theme";
	String selectThemeDescription = "select name, description from theme";
	String selectUserSuggestedSpeakers = "select first_name, last_name from speaker where suggested_by is not null";
	String selectUserSuggestedThemes = "select name from theme where creator is not null";
	String selectSpeakerName = "select first_name, last_name from speaker order by last_name, first_name";
	
	String insertSpeaker = "insert into speaker (first_name, last_name, suggested_by) values (?, ?, ?)";
	String insertSpeakerRanking = "insert into speaker_ranking (speaker_id, ranking_id, ranking) values (?, ?, ?)";
	String insertIsolatedThemeRanks = "insert into isolated_theme_ranks (theme_id, ranking_id, ranking) values (?, ?, ?)";
%>