package com.scripps.growler;

import java.util.*;

/**
 * Handles the sessions or "events" of Techtoberfest
 *
 * @see com.scripps.growler.SessionPersistence
 * @author "Justin Bauguess"
 */
public class Session {

    /**
     * The identifier for the session
     */
    private Integer id;
    /**
     * The name of the session
     */
    private String name;
    /**
     * A description of the session
     */
    private String description;
    /**
     * The date of the session
     */
    private java.sql.Date sessionDate;
    /**
     * The time the session begins
     */
    private java.sql.Time startTime;
    /**
     * How long the session lasts in minutes
     */
    private java.sql.Time duration;
    /**
     * The location of the session
     */
    private String location;
    /**
     * The track of the session - What information will be covered
     */
    private String track;
    /**
     * The unique key that allows users to attend a session
     */
    private String key;
    
    private boolean active;
    
    private int userRegistered;
    
    private boolean survey;
    
    private Integer localAttendees;
    
    private Integer remoteAttendees;
    
    private String speakerId;
    
    private String sessionId;

    public Session() {
    }

    /**
     * Gets the id of a session
     *
     * @return The session id
     */
    public Integer getId() {
        return id;
    }

    /**
     * Sets the id of a session
     *
     * @param id The session id
     */
    public void setId(Integer id) {
        this.id = id;
    }
    
    public Boolean getActive() {
        return active;
    }
    
    public void setActive(Boolean state) {
        this.active = state;
    }

    /**
     * Gets the name of a session
     *
     * @return The session name
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the name of a session
     *
     * @param name The session name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets the description of a session
     *
     * @return The session description
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets the description of a session
     *
     * @param description The session description
     */
    public void setDescription(String description) {
        this.description = description;
    }

    /**
     * Gets the date of the session
     *
     * @return The session date
     */
    public java.sql.Date getSessionDate() {
        return sessionDate;
    }

    /**
     * Sets the date of the session
     *
     * @param sessionDate The session date
     */
    public void setSessionDate(java.sql.Date sessionDate) {
        this.sessionDate = sessionDate;
    }

    /**
     * Gets the start time of the session
     *
     * @return The session start time
     */
    public java.sql.Time getStartTime() {
        return startTime;
    }

    /**
     * Sets the start time of the session
     *
     * @param startTime The session start time
     */
    public void setStartTime(java.sql.Time startTime) {
        this.startTime = startTime;
    }

    /**
     * Gets the duration of the session
     *
     * @return The minutes a session will last
     */
    public java.sql.Time getDuration() {
        return duration;
    }

    /**
     * Sets the duration of the session
     *
     * @param duration The minutes a session will last
     */
    public void setDuration(java.sql.Time duration) {
        this.duration = duration;
    }

    /**
     * Gets the location of the session
     *
     * @return A reference to the location of a session
     */
    public String getLocation() {
        return location;
    }

    /**
     * Sets the location of a session
     *
     * @param location The session location
     */
    public void setLocation(String location) {
        this.location = location;
    }

    /**
     * Gets the track of a session
     *
     * @return What kind of session
     */
    public String getTrack() {
        return track;
    }

    /**
     * Sets the track of a session
     *
     * @param track What kind of session
     */
    public void setTrack(String track) {
        this.track = track;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String k) {
        this.key = k;
    }

    public boolean isSurvey() {
        return survey;
    }

    public void setSurvey(boolean survey) {
        this.survey = survey;
    }

    public int getUserRegistered() {
        return userRegistered;
    }

    public void setUserRegistered(int userRegistered) {
        this.userRegistered = userRegistered;
    }
    
  
    
    /**
     * Gets the # of local attendees
     */
    public Integer getLocalAttendees() {
        return localAttendees;
    }

    /**
     * Sets the # of local attendees
     */
    public void setLocalAttendees(Integer localAttendees) {
        this.localAttendees = localAttendees;
    }    
    
    
     /**
     * Gets the # of remote attendees
     */
    public Integer getRemoteAttendees() {
        return remoteAttendees;
    }

    /**
     * Sets the # of remote attendees
     */
    public void setRemoteAttendees(Integer remoteAttendees) {
        this.remoteAttendees = remoteAttendees;
    }    
    
     /**
     * Gets the speakerId as string
     */
    public String getSpeakerId() {
        return speakerId;
    }

    /**
     * Sets the speakerId as string
     */
    public void setSpeakerId(String speakerId) {
        this.speakerId = speakerId;
    }       

     /**
     * Gets the sessionId as string
     */
    public String getSessionId() {
        return sessionId;
    }

    /**
     * Sets the sessionId as string
     */
    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }   



}
