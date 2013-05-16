package com.scripps.growler;
/**
 * Represents Themes from the database
 * 
 * @see com.scripps.growler.ThemePersistence
 * @author "Justin Bauguess"
 */
public class Theme {
    /**
     * The ID of the theme
     */
    private int id;
    /**
     * The name of the theme
     */
    private String name;
    /**
     * The description of a theme
     */
    private String description;
    /**
     * The reason a user may have suggested a theme
     */
    private String reason;
    /**
     * Who created a theme
     */
    private int creatorId;
    /**
     * Whether a theme is visible to the average user
     */
    private boolean visible;
    /**
     * What year the theme is from
     */
    private int year;
    /**
     * The numeric rank a theme has received base on votes
     */
    private int rank;
    /**
     * How many times a theme has been ranked
     */
    private int count;
    /**
     * Default constructor
     */
    public Theme(){
    }
    /**
     * Constructs a theme object with all parameters
     * @param i ID
     * @param n Name
     * @param d Description
     * @param r Reason
     * @param c Creator ID
     * @param v Visible
     * @param y Year
     * @param rk Rank
     * @param ct Count
     */
    public Theme(int i, String n, String d, String r, int c, boolean v, int y, int rk, int ct) {
        id = i;
        name = n;
        description = d;
        reason = r;
        creatorId = c;
        visible = v;
        year = y;
        rank = rk;
        count = ct;
    }
    /**
     * Gets the rank of a theme
     * @return The score a theme has received
     */
    public int getRank(){
        return(this.rank);
    }
    /**
     * Sets the rank of a theme
     * @param r The rank value
     */
    public void setRank(int r){
        this.rank = r;
    }
    /**
     * Gets the count of theme ranks
     * @return The count value
     */
    public int getCount() {
        return(this.count);
    }
    /**
     * Sets the count of a theme
     * @param c The count value
     */
    public void setCount(int c){
        this.count = c;
    }
    /**
     * Gets the name of a theme
     * @return The name of a theme
     */
    public String getName() {
        return(name);
    }
    /**
     * Sets the name of a theme
     * @param s The name of the theme
     */
    public void setName(String s){
        this.name = s;
    }
    /**
     * Gets the id of a theme
     * @return The theme id
     */
    public int getId(){
        return(id);
    }
    /**
     * Sets the id of a theme
     * @param i the id to set
     */
    public void setId(int i){
        this.id = i;
    }
    /**
     * Gets the description of a theme
     * @return The description
     */
    public String getDescription(){
        return(description);
    }
    /**
     * Sets the description of a theme
     * @param s The description
     */
    public void setDescription(String s){
        this.description = s;
    }
    /**
     * Gets the reason of a theme
     * @return The reason
     */
    public String getReason() {
        return(reason);
    }
    /**
     * Sets the reason of a theme
     * @param s The reason
     */
    public void setReason(String s){
        this.reason = s;
    }
    /**
     * Gets the user who suggested a theme
     * @return the creator id
     */
    public int getCreatorId(){
        return(creatorId);
    }
    /**
     * Sets the user who suggested a theme
     * @param i the user id
     */
    public void setCreatorId(int i) {
        this.creatorId = i;
    }
    /**
     * Gets whether a theme is visible or not
     * @return The visibility
     */
    public boolean getVisible(){
        return(visible);
    }
    /**
     * Sets the visibility of a theme
     * @param b The visibility
     */
    public void setVisible(boolean b){
        this.visible = b;
    }
    /**
     * Gets the year of the theme
     * @return The year
     */
    public int getYear(){
        return(year);
    }
    /**
     * Sets the year for a theme
     * @param i A year
     */
    public void setYear(int i){
        this.year = i;
    }
}
