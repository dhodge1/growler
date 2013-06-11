/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.scripps.growler;

import java.util.ArrayList;

/**
 *
 * @author 162107
 */
public class InterestReport {
    
    private String sessionName;
    private String sessionDescription;
    private ArrayList<Speaker> speakers;
    private int interested;

    public String getSessionName() {
        return sessionName;
    }

    public void setSessionName(String sessionName) {
        this.sessionName = sessionName;
    }

    public String getSessionDescription() {
        return sessionDescription;
    }

    public void setSessionDescription(String sessionDescription) {
        this.sessionDescription = sessionDescription;
    }


    public int getInterested() {
        return interested;
    }

    public void setInterested(int interested) {
        this.interested = interested;
    }

    public ArrayList<Speaker> getSpeakers() {
        return speakers;
    }

    public void setSpeakers(ArrayList<Speaker> speakers) {
        this.speakers = speakers;
    }
    
    
    
}
