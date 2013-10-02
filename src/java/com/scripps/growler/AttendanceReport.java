/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.scripps.growler;

import java.sql.Date;

/**
 *
 * @author 162107
 */
public class AttendanceReport {
    
    private String session_name;
    private java.sql.Date session_date;
    private int session_id;
    private int attendee_count;

    public Date getSession_date() {
        return session_date;
    }

    public void setSession_date(Date session_date) {
        this.session_date = session_date;
    }

    
    public int getSession_id() {
        return session_id;
    }

    public void setSession_id(int session_id) {
        this.session_id = session_id;
    }

    
    public String getSession_name() {
        return session_name;
    }

    public void setSession_name(String session_name) {
        this.session_name = session_name;
    }

    public int getAttendee_count() {
        return attendee_count;
    }

    public void setAttendee_count(int attendee_count) {
        this.attendee_count = attendee_count;
    }
    
    
}
