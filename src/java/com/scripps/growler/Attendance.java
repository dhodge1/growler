package com.scripps.growler;

/**
 * Represents the Attendance table in the database
 *
 * @see com.scripps.growler.AttendancePersistence
 * @see com.scripps.growler.User
 * @see com.scripps.growler.Session
 * @author "Justin Bauguess"
 */
public class Attendance {

    protected int userId;
    protected int sessionId;
    private Boolean isRegistered;

    /**
     * Default constructor
     */
    public Attendance() {
    }

    /**
     * Creates an unregistered Attendance object
     *
     * @param user The user ID
     * @param session The session ID
     */
    public Attendance(int user, int session) {
        userId = user;
        sessionId = session;
        isRegistered = false;
    }

    /**
     * Creates an attendance object
     *
     * @param user The user ID
     * @param session The session ID
     * @param register Whether or not the survey is registered
     */
    public Attendance(int user, int session, boolean register) {
        userId = user;
        sessionId = session;
        isRegistered = register;
    }

    /**
     * Gives the user id for the attendance
     *
     * @return A user id
     */
    public int getUserId() {
        return userId;
    }

    /**
     * Sets the user id for an attendance
     *
     * @param user The user attending the event
     */
    public void setUserId(int user) {
        this.userId = user;
    }

    /**
     * Gets the session ID
     *
     * @return A session ID
     */
    public int getSessionId() {
        return sessionId;
    }

    /**
     * Sets the session ID for an attendance
     *
     * @param session The session attended
     */
    public void setSessionId(int session) {
        this.sessionId = session;
    }

    /**
     * Gets whether an attendance has a survey taken
     *
     * @return If the survey has been taken
     */
    public Boolean getIsRegistered() {
        return isRegistered;
    }

    /**
     * Sets the survey status for an attendance
     *
     * @param isRegistered True: survey taken, False: survey not taken
     */
    public void setIsRegistered(Boolean isRegistered) {
        this.isRegistered = isRegistered;
    }
}
