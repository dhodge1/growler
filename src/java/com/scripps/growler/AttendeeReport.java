/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.scripps.growler;

/**
 *
 * @author 162107
 */
public class AttendeeReport {
        
        private Integer localAttendees;
        private Integer remoteAttendees;
        private Integer sessionId;
        private String sessionName;




    public Integer getId() {
        return sessionId;
    }


    public void setId(int sessionId) {
        this.sessionId = sessionId;
    }
    


    public Integer getLocalAttendees() {
        return localAttendees;
    }


    public void setLocalAttendees(int localAttendees) {
        this.localAttendees = localAttendees;
    }    
    

    public Integer getRemoteAttendees() {
        return remoteAttendees;
    }


    public void setRemoteAttendees(int remoteAttendees) {
        this.remoteAttendees = remoteAttendees;
    }    
    
    
    public String getSessionName() {
        return sessionName;
    }   

    public void setSessionName(String sessionName) {
        this.sessionName = sessionName;
    }  
}  
        
    
    
