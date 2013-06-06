package com.scripps.growler;

/**
 * Keeps data for the users of project growler
 *
 * @see com.scripps.growler.Attendance
 * @see com.scripps.growler.Session
 * @see com.scripps.growler.Theme
 * @see com.scripps.growler.Speaker
 * @see com.scripps.growler.UserPersistence
 * @author "Justin Bauguess"
 */
public class User {

    /**
     * Contains the integer that represents the user in the database
     */
    private Integer id;
    /**
     * Contains the user's display name
     */
    private String userName;
    /**
     * The string that contains a user's password - encrypted
     */
    private String password;
    /**
     * The SNI ID that is 6 digits - It's a string because we aren't doing math with it
     */
    private String corporateId;
    
    private String email;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Default constructor
     */
    public User() {
    }

    /**
     * Constructs a user object with id, password, and name
     *
     * @param id User's ID
     * @param pwd User's Password
     * @param name User's Name
     */
    public User(Integer id, String pwd, String name) {
        this.id = id;
        this.password = pwd;
        this.userName = name;
    }

    /**
     * Gets the user's id
     *
     * @return the User's id
     */
    public Integer getId() {
        return id;
    }

    /**
     * Sets the user's id
     *
     * @param id an integer for the user's id
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * Gets the user's display name
     *
     * @return A string with a displayable name
     */
    public String getUserName() {
        return userName;
    }

    /**
     * Sets the user's display name
     *
     * @param userName A string with a name
     */
    public void setUserName(String userName) {
        this.userName = userName;
    }

    /**
     * Gets the user's password
     *
     * @return The user's password
     */
    public String getPassword() {
        return password;
    }

    /**
     * Sets the user's password. It will be encrypted first.
     *
     * @param password A string
     */
    public void setPassword(String password) {
        this.password = password;
    }
    public String getCorporateId() {
        return corporateId;
    }
    public void setCorporateId(String id){
        this.corporateId = id;
    }
}