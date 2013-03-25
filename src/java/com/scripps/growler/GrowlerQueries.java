/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.scripps.growler;

/**
 * Queries for use in the Growler Web Application
 * @author "Justin Bauguess"
 */
public class GrowlerQueries {
        /**
	* @return Used for selecting theme names, user story 10329 & 10343
	*/
	public String selectThemeName() {
		return("select name from theme"); }
	/**
	* @return Used for selecting theme descriptions, user story 10330
	*/
	public String selectThemeDescription() {
		return("select name, description from theme"); }
	/**
	* @return Used selecting speakers, user story 10344
	*/
	public String selectSpeakers() {
		return("select id, first_name, last_name from speaker"); }
	/**
	* @return Used for selecting default speakers, user story 10334
	*/
	public String selectDefaultSpeakers() { 
            return(selectSpeakers() + " where suggested_by is null"); }
	/**
	* @return Used for selecting user suggested speakers(so they can be ranked), user story 10337 & 10338
	*/
	public String selectUserSuggestedSpeakers() { 
            return(selectSpeakers() + " where suggested_by is not null"); }
	/**
	* @return  Used for selecting user suggested themes (so they can be ranked), user story 10333
	*/
	public String selectUserSuggestedThemes() {
		return("select name from theme where creator = 0"); }
	/**
         * @return returns the first and last names of the speaker, as well as the id
	*/
	public String selectSpeakerName() {
		return("select id, first_name, last_name from speaker order by id"); }
	/**
	* @return Used for displaying speaker ranks from the past, user story 10362
	*/
	public String selectSpeakerRanking() { 
		return("select avg(ranking) from session_ranking where session_ranking.session_id in "
                        + "(select id from session where id in (select session_id from speaker_team "
                        + "where speaker_id = ?))"); }
	/**
	* @return Used for displaying the number of times a speaker was ranked in the past, user story 10365
	*/
	public String selectSpeakerRankingCount() { 
		return(null); }
	/**
	* @return Displays theme by rank, user story 10345
	*/
	public String selectThemeByRank() { 
		return(null); }
	/**
	* @return Displays speaker by rank, user story 10346
	*/
	public String selectSpeakerByRank() {
		return(null); }
	/**
	* @return Displays who suggested themes, user story 10353
	*/
	public String selectWhoSuggestedTheme() {
		return("select creator, name from theme"); }
	/**
	* @return Displays who suggested speakers, user story 10354
	*/
	public String selectWhoSuggestedSpeaker() {
		return("select suggested_by, first_name, last_name from speaker"); }
	/**
	* @return insert statement into theme, user story 10347
	*/
	public String insertTheme() {
		return("insert into theme(id, name, description, reason, creator, active, visible) values (?, ?, ?, ?, ?, ?, ?)"); }
	/**
	* @return insert statement into theme, user story 10331
	*/
	public String insertUserTheme() {
		return("insert into theme (name, description, creator, reason, active, visible) values (?, ?, ?, ?, false, false)"); }
	/**
	* @return insert statement into speakers, user story 10336 & user story 10348
	*/
	public String insertSpeaker() {
		return("insert into speaker (first_name, last_name, suggested_by, visible, active) values (?, ?, ?, ?, ?)"); }
	/**
	* @return insert statement into speaker_ranking, user story 10335
	*/
	public String insertSpeakerRanking() {
		return("insert into speaker_ranking (speaker_id, ranking) values (?, ?)"); }
	/**
	* @return insert statement into isolated_theme_ranks table, user story 10332 & 10359
	*/
	public String insertIsolatedThemeRanks() {
		return("insert into isolated_theme_ranking (theme_id, ranking) values (?, ?)"); }
	/**
	* @return updates a theme to be visible, so it is "promoted", user story 10360
	*/
	public String promoteTheme() {
		return("update theme set visible =  true where id =  ?"); }
	/**
	* @return updates a speaker to be visible, so it is "promoted", user story 10361
	*/
	public String promoteSpeaker() {
		return("update speaker set visible =  true where id =  ?"); }
	/**
	* @return updates a theme to be inactive, user story 10351
	*/
	public String deactivateTheme() {
		return("update theme set active =  false where id =  ?"); }
	/**
	* @return updates a speaker to be inactive, user story 10350
	*/
	public String deactivateSpeaker() {
		return("update speaker set active =  false where id =  ?"); }
        /**
         * @return Returns the sum of the rankings for themes
         */
        public String returnThemeRanking(String id) {
            return("select sum(ranking), name from isolated_theme_ranking, theme where theme.id = isolated_theme_ranking.theme_id and theme.id = " + id + " group by theme_id");
        }
        /**
         * @return returns the sum of the speaker rankings
         */
        public String returnSpeakerRanking() {
            return("select sum(speaker_ranking.ranking), speaker.first_name, speaker.last_name from speaker_ranking, speaker where speaker.id = speaker_ranking.speaker_id group by speaker_ranking.speaker_id");
        }
        /**
         * @return returns the 2012 speaker rankings
         */
        public String return2012SpeakerRanking() {
            return("select r.id, r.rating, s.first_name, s.last_name from ranks_2012 r, speaker s where s.id = r.id");
        }
        /**
         * 
         */
        public String return2012SpeakerRatingCount() {
            return("select r.id, r.count, s.first_name, s.last_name from ranks_2012 r, speaker s where s.id = r.id");
        }
        /**
         * 
         * @return Returns the id, name and average ranking given by users (highest to lowest)
         */
        public String returnAverageSpeakerRanking() {
            return("select r.rating, r.id, s.first_name, s.last_name from ranks_2012 r, speaker s where r.id = s.id;");
        }
        /**
         * @return how many times a speaker was ranked 
         */
        public String returnCountofRanks() {
            return("select r.count, r.id, s.first_name, s.last_name from ranks_2012 r, speaker s where r.id = s.id;");
        }
        /**
         * @return Returns those speakers that haven't been ranked
         */
        public String returnUnrankedSpeakers() {
            return("select id from speaker where id NOT IN (select speaker_id from speaker_ranking)");
        }
        
}
