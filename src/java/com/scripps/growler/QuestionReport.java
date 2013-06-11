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
public class QuestionReport {
    
    private String session_name;
    private String session_description;
    private ArrayList<Speaker> speakers;
    private double score;
    private int attendance;
    private int raters;

    public String getSession_name() {
        return session_name;
    }

    public void setSession_name(String session_name) {
        this.session_name = session_name;
    }

    public String getSession_description() {
        return session_description;
    }

    public void setSession_description(String session_description) {
        this.session_description = session_description;
    }

    public ArrayList<Speaker> getSpeakers() {
        return speakers;
    }

    public void setSpeakers(ArrayList<Speaker> speakers) {
        this.speakers = speakers;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public int getAttendance() {
        return attendance;
    }

    public void setAttendance(int attendance) {
        this.attendance = attendance;
    }

    public int getRaters() {
        return raters;
    }

    public void setRaters(int raters) {
        this.raters = raters;
    }
    
    
    
}
