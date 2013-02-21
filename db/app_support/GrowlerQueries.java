/**
 @author Justin Bauguess
 @version 1.0
 @since 02-21-13
*/

public class GrowlerQueries {
	
	/**
	Used for selecting theme names, user story 10329 & 10343
	*/
	String selectThemeName = "select name from theme";
	/**
	Used for selecting theme descriptions, user story 10330
	*/
	String selectThemeDescription = "select name, description from theme";
	/**
	Used for selecting speakers, user story 10344
	*/
	String selectSpeakers = "select first_name, last_name from speaker";
	/**
	Used for selecting default speakers, user story 10334
	*/
	String selectDefaultSpeakers = selectSpeakers + " where suggested_by is null";
	/**
	Used for selecting user suggested speakers(so they can be ranked), user story 10337 & 10338
	*/
	String selectUserSuggestedSpeakers = selectSpeakers + " where suggested_by is not null";
	/**
	Used for selecting user suggested themes (so they can be ranked), user story 10333
	*/
	String selectUserSuggestedThemes = "select name from theme where creator is not null";
	/**
	*/
	String selectSpeakerName = "select first_name, last_name from speaker order by last_name, first_name";
	/**
	Used for displaying speaker ranks from the past, user story 10362
	*/
	String selectSpeakerRanking = null;
	/**
	Used for displaying the number of times a speaker was ranked in the past, user story 10365
	*/
	String selectSpeakerRankingCount = null;
	/**
	Displays theme by rank, user story 10345
	*/
	String selectThemeByRank = null;
	/**
	Displays speaker by rank, user story 10346
	*/
	String selectSpeakerByRank = null;
	/**
	Displays who suggested themes, user story 10353
	*/
	String selectWhoSuggestedTheme = "select creator, name from theme";
	/**
	Displays who suggested speakers, user story 10354
	*/
	String selectWhoSuggestedSpeaker = "select suggested_by, first_name, last_name from speaker";
	/**
	Insert statement into theme, user story 10347
	*/
	String insertTheme = "insert into theme(id, name, description, creator, active, visible) values (?, ?, ?, ?, ?, ?)";
	/**
	Insert statement into theme, user story 10331
	*/
	String insertUserTheme = "insert into theme (name, description, creator, reason, active, visible) values (?, ?, ?, ?, false, false)";
	/**
	Insert statement into speakers, user story 10336 & user story 10348
	*/
	String insertSpeaker = "insert into speaker (first_name, last_name, suggested_by) values (?, ?, ?)";
	/**
	Insert statement into speaker_ranking, user story 10335
	*/
	String insertSpeakerRanking = "insert into speaker_ranking (speaker_id, ranking_id, ranking) values (?, ?, ?)";
	/**
	Insert statement into isolated_theme_ranks table, user story 10332 & 10359
	*/
	String insertIsolatedThemeRanks = "insert into isolated_theme_ranks (theme_id, ranking_id, ranking) values (?, ?, ?)";
	/**
	Updates a theme to be visible, so it is "promoted", user story 10360
	*/
	String promoteTheme = "update theme set visible = true where id = ?";
	/**
	Updates a speaker to be visible, so it is "promoted", user story 10361
	*/
	String promoteSpeaker = "update speaker set visible = true where id = ?";
	/**
	Updates a theme to be inactive, user story 10351
	*/
	String deactivateTheme = "update theme set active = false where id = ?";
	/**
	Updates a speaker to be inactive, user story 10350
	*/
	String deactivateTheme = "update speaker set active = false where id = ?";
}