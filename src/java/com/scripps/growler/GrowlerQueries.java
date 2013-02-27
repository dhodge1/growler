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
	Used for return("selecting theme names, user story 10329 & 10343
	*/
	public String selectThemeName() {
		return("select name from theme"); }
	/**
	Used for return("selecting theme descriptions, user story 10330
	*/
	public String selectThemeDescription() {
		return("select name, description from theme"); }
	/**
	Used for return("selecting speakers, user story 10344
	*/
	public String selectSpeakers() {
		return("select first_name, last_name from speaker"); }
	/**
	Used for return("selecting default speakers, user story 10334
	*/
	public String selectDefaultSpeakers() { 
            return(selectSpeakers() + " where suggested_by is null"); }
	/**
	Used for return("selecting user suggested speakers(so they can be ranked), user story 10337 & 10338
	*/
	public String selectUserSuggestedSpeakers() { 
            return(selectSpeakers() + " where suggested_by is not null"); }
	/**
	Used for return("selecting user suggested themes (so they can be ranked), user story 10333
	*/
	public String selectUserSuggestedThemes() {
		return("select name from theme where creator is not null"); }
	/**
	*/
	public String selectSpeakerName() {
		return("select first_name, last_name from speaker order by last_name, first_name"); }
	/**
	Used for displaying speaker ranks from the past, user story 10362
	*/
	public String selectSpeakerRanking() { 
		return(null); }
	/**
	Used for displaying the number of times a speaker was ranked in the past, user story 10365
	*/
	public String selectSpeakerRankingCount() { 
		return(null); }
	/**
	Displays theme by rank, user story 10345
	*/
	public String selectThemeByRank() { 
		return(null); }
	/**
	Displays speaker by rank, user story 10346
	*/
	public String selectSpeakerByRank() {
		return(null); }
	/**
	Displays who suggested themes, user story 10353
	*/
	public String selectWhoSuggestedTheme() {
		return("select creator, name from theme"); }
	/**
	Displays who suggested speakers, user story 10354
	*/
	public String selectWhoSuggestedSpeaker() {
		return("select suggested_by, first_name, last_name from speaker"); }
	/**
	return("insert statement into theme, user story 10347
	*/
	public String insertTheme() {
		return("insert into theme(id, name, description, reason, creator, active, visible) values (?, ?, ?, ?, ?, ?, ?)"); }
	/**
	return("insert statement into theme, user story 10331
	*/
	public String insertUserTheme() {
		return("insert into theme (name, description, creator, reason, active, visible) values (?, ?, ?, ?, false, false)"); }
	/**
	return("insert statement into speakers, user story 10336 & user story 10348
	*/
	public String insertSpeaker() {
		return("insert into speaker (first_name, last_name, suggested_by) values (?, ?, ?)"); }
	/**
	return("insert statement into speaker_ranking, user story 10335
	*/
	public String insertSpeakerRanking() {
		return("insert into speaker_ranking (speaker_id, ranking_id, ranking) values (?, ?, ?)"); }
	/**
	return("insert statement into isolated_theme_ranks table, user story 10332 & 10359
	*/
	public String insertIsolatedThemeRanks() {
		return("insert into isolated_theme_ranks (theme_id, ranking_id, ranking) values (?, ?, ?)"); }
	/**
	return("updates a theme to be visible, so it is "promoted", user story 10360
	*/
	public String promoteTheme() {
		return("update theme set visible =  true where id =  ?"); }
	/**
	return("updates a speaker to be visible, so it is "promoted", user story 10361
	*/
	public String promoteSpeaker() {
		return("update speaker set visible =  true where id =  ?"); }
	/**
	return("updates a theme to be inactive, user story 10351
	*/
	public String deactivateTheme() {
		return("update theme set active =  false where id =  ?"); }
	/**
	return("updates a speaker to be inactive, user story 10350
	*/
	public String deactivateSpeaker() {
		return("update speaker set active =  false where id =  ?"); }
}
