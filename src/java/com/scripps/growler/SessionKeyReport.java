/*
 * SessionKeyReport
 * A structure to hold one row of all data needed for the Session Key Report
 * stores: Session Name, Session Presenters, & Session Key
 */
package com.scripps.growler;

import java.util.ArrayList;

/**
 *
 * @author Shaun
 */
public class SessionKeyReport {
    private String sessionName;
    private String sessionKey;
    private ArrayList<Speaker> speakers;

    public String getSessionName() {
        return sessionName;
    }

    public void setSessionName(String sessionName) {
        this.sessionName = sessionName;
    }

    public String getSessionKey() {
        return sessionKey;
    }

    public void setSessionKey(String sessionKey) {
        this.sessionKey = sessionKey;
    }

    public ArrayList<Speaker> getSpeakers() {
        return speakers;
    }

    public void setSpeakers(ArrayList<Speaker> speakers) {
        this.speakers = speakers;
    }
}


