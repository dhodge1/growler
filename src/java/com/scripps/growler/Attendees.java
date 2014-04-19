package com.scripps.growler;

import java.util.*;

/**
 * Handles the # of attendees for each session of Techtoberfest
 *
 * @see com.scripps.growler.SessionPersistence
 * @author Chelsea
 */
public class Attendees {


    private Integer id;
    private String localAttendees;
    private String remoteAttendees;
    private String sessionName;

    public Attendees() {
    }


    public Integer getId() {
        return id;
    }


    public void setId(Integer id) {
        this.id = id;
    }
    

    public String getLocalAttendees() {
        return localAttendees;
    }

    public void setLocalAttendees(String localAttendees) {
        this.localAttendees = localAttendees;
    }    
    
    public String getRemoteAttendees() {
        return remoteAttendees;
    }

    public void setRemoteAttendees(String remoteAttendees) {
        this.remoteAttendees = remoteAttendees;
    }    
    

    public String getSessionName() {
        return sessionName;
    }   

    public void setSessionName(String sessionName) {
        this.sessionName = sessionName;
    }    
    
}  