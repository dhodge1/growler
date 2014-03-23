/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.scripps.growler;

/**
 *
 * @author David
 */
public class FacilityReport {
    
    private String room;
    private float avgAttendance;
    private int totalAttendance;
    private float avgRating;
    
    public String getRoom() {
        return room;
    }
    
    public void setRoom(String roomName) {
        this.room = roomName;
    }
    
    public float getAvgAttendance() {
        return avgAttendance;
    }
    
    public void setAvgAttendance(float avgA) {
        this.avgAttendance = avgA;
    }
    
    public int getTotalAttendance() {
        return totalAttendance;
    }
    
    public void setTotalAttendance(int tot) {
        this.totalAttendance = tot;
    }
    
    public float getAvgRating() {
        return avgRating;
    }
    
    public void setAvgRating(float avgR) {
        this.avgRating = avgR;
    }
    
}
