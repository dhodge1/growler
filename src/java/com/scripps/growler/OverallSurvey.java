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
public class OverallSurvey {
    
    private float overallQuality;
    private float topics;
    private float rooms;
    private float webEx;
    
    public float getOverallQuality() {
        return overallQuality;
    }
    
    public void setOverallQuality(float oQ) {
        this.overallQuality = oQ;
    }
    
    public float getTopics() {
        return topics;
    }
    
    public void setTopics(float t) {
        this.topics = t;
    }
    
    public float getRooms() {
        return rooms;
    }
    
    public void setRooms(float r) {
        this.rooms = r;
    }
    
    public float getWebEx() {
        return webEx;
    }
    
    public void setWebEx(float w) {
        this.webEx = w;
    }
    
}
