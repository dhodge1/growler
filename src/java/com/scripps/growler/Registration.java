/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.scripps.growler;

import java.sql.Date;
import java.sql.Time;

/**
 *
 * @author 162107
 */
public class Registration {
    
    private int userId;
    private int sessionId;
    private java.sql.Date dateRegistered;
    private java.sql.Time timeRegistered;
    private String reason;

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getSessionId() {
        return sessionId;
    }

    public void setSessionId(int sessionId) {
        this.sessionId = sessionId;
    }

    public Date getDateRegistered() {
        return dateRegistered;
    }

    public void setDateRegistered(Date dateRegistered) {
        this.dateRegistered = dateRegistered;
    }

    public Time getTimeRegistered() {
        return timeRegistered;
    }

    public void setTimeRegistered(Time timeRegistered) {
        this.timeRegistered = timeRegistered;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }
    
    
}
