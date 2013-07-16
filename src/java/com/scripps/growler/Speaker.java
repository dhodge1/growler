package com.scripps.growler;

/**
 * Represents speakers in the database
 *
 * @see com.scripps.growler.SpeakerPersistence
 * @author "Justin Bauguess"
 */
public class Speaker {

    /**
     * The ID of a speaker
     */
    private Integer id;
    /**
     * The First Name of a speaker
     */
    private String firstName;
    /**
     * The Last Name of a speaker
     */
    private String lastName;
    /**
     * The ID of the user who suggested a speaker
     */
    private Integer suggestedBy;
    /**
     * Whether a speaker is visible to regular users or not
     */
    private Boolean visible;
    /**
     * The points a user has obtained through votes this year
     */
    private int rank;
    /**
     * The times a user has received points through voting
     */
    private int count;
    /**
     * The rank from last year's Techtoberfest
     */
    private double rank2012;
    /**
     * The times a speaker was ranked at last year's Techtoberfest
     */
    private int count2012;
    
    private String type;

    /**
     * Default constructor
     */
    public Speaker() {
    }

    /**
     * Gets the id of a speaker
     *
     * @return Speaker ID value
     */
    public Integer getId() {
        return id;
    }

    /**
     * Sets the id of a speaker
     *
     * @param id Speaker ID value
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * Gets the first name of a speaker
     *
     * @return First Name value
     */
    public String getFirstName() {
        return firstName;
    }

    /**
     * Sets the first name of a speaker
     *
     * @param firstName First Name value
     */
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    /**
     * Gets the last name of a speaker
     *
     * @return Last Name value
     */
    public String getLastName() {
        return lastName;
    }

    /**
     * Sets the last name of a speaker
     *
     * @param lastName Last Name value
     */
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    /**
     * Gets the id of who suggested the speaker
     *
     * @return The user id of the person who suggested the speaker
     */
    public Integer getSuggestedBy() {
        return suggestedBy;
    }

    /**
     * Sets who suggested a speaker
     *
     * @param suggestedBy The user id of the person who suggested the speaker
     */
    public void setSuggestedBy(Integer suggestedBy) {
        this.suggestedBy = suggestedBy;
    }

    /**
     * Gets the visibility of a speaker
     *
     * @return True: visible, False: invisible
     */
    public Boolean getVisible() {
        return visible;
    }

    /**
     * Sets the visibility of a speaker
     *
     * @param visible True: visible, False: invisible
     */
    public void setVisible(Boolean visible) {
        this.visible = visible;
    }

    /**
     * Gets the rank for this year
     *
     * @return A rank value
     */
    public int getRank() {
        return (rank);
    }

    /**
     * Sets the rank for this year
     *
     * @param rank A rank value
     */
    public void setRank(int rank) {
        this.rank = rank;
    }

    /**
     * Gets the count for this year's rankings
     *
     * @return The count
     */
    public int getCount() {
        return count;
    }

    /**
     * Sets the count for this year's rankings
     *
     * @param count A count value
     */
    public void setCount(int count) {
        this.count = count;
    }

    /**
     * Gets the rank from 2012
     *
     * @return A rank value
     */
    public double getRank2012() {
        return rank2012;
    }

    /**
     * Sets the rank for 2012
     *
     * @param rank A rank value
     */
    public void setRank2012(double rank) {
        this.rank2012 = rank;
    }

    /**
     * Gets the count for 2012 ranks
     *
     * @return
     */
    public int getCount2012() {
        return (count2012);
    }

    /**
     * Sets the count for 2012 ranks
     *
     * @param count A count value
     */
    public void setCount2012(int count) {
        this.count2012 = count;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    
    public String getFullName() {
        return (this.lastName + ", " + this.firstName);
    }
}