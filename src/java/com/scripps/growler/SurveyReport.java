/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.scripps.growler;

/**
 *
 * @author 162107
 */
public class SurveyReport {
        
        private Attendance attendance;
        private User user;
        private Session session;

        public Attendance getAttendance() {
            return attendance;
        }

        public void setAttendance(Attendance attendance) {
            this.attendance = attendance;
        }

        public User getUser() {
            return user;
        }

        public void setUser(User user) {
            this.user = user;
        }

        public Session getSession() {
            return session;
        }

        public void setSession(Session session) {
            this.session = session;
        }
        
    }
    
