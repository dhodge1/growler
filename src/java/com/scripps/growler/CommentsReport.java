/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.scripps.growler;

import java.util.ArrayList;

/**
 *
 * @author Shaun
 */
public class CommentsReport {
    private String sessionName;
    private ArrayList<Speaker> speakers;
    private String sessionComment;

    public String getSessionName() {
        return sessionName;
    }

    public void setSessionName(String sessionName) {
        this.sessionName = sessionName;
    }

    public String getComment() {
        return sessionComment;
    }

    public void setComment(String sessionComment) {
        this.sessionComment = sessionComment;
    }

    public ArrayList<Speaker> getSpeakers() {
        return speakers;
    }

    public void setSpeakers(ArrayList<Speaker> speakers) {
        this.speakers = speakers;
    }
}
