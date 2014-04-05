package com.scripps.growler;

import java.util.*;

/**
 * Handles the sessions or "events" of Techtoberfest
 *
 * @see com.scripps.growler.SessionPersistence
 * @author "Justin Bauguess"
 */
public class Attendees {

    /**
     * The identifier for the session
     */
    private Integer id;
    /**
     * The # of localAttendees of the session
     */
    private Integer localAttendees;
   /**
     * The # of localAttendees of the session
     */
    private Integer remoteAttendees;

    public Attendees() {
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
    

/*  --------------------------------------------------------------------------------
    Added by Chelsea Grindstaff
    18 March 2014
    Used with processTrackAttendees
    */    
    
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
    
  