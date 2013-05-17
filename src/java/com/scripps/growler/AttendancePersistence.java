package com.scripps.growler;
import java.sql.*;
import java.util.*;
/**
 *
 * @see com.scripps.growler.Attendance
 * @author "Justin Bauguess"
 */
public class AttendancePersistence extends GrowlerPersistence {
    /**
     * Sorts queries by user ascending
     */
    final String SORT_BY_USER_ASC = " order by attendance.user_id asc";
    /**
     * Sorts queries by user descending
     */
    final String SORT_BY_USER_DESC = " order by attendance.user_id desc";
    /**
     * Sorts queries by session ascending
     */
    final String SORT_BY_SESSION_ASC = " order by attendance.session_id asc";
    /**
     * Sorts queries by session descending
     */
    final String SORT_BY_SESSION_DESC = " order by attendance.session_id desc";
    /**
     * Sorts queries by registration status ascending
     */
    final String SORT_BY_REGISTERED_ASC = " order by attendance.is_registered asc";
    /**
     * Sorts queries by registration status descending
     */
    final String SORT_BY_REGISTERED_DESC = " order by attendance.is_registered desc";
    /**
     * Default constructor
     */
    public AttendancePersistence() {
    }
    /**
     * Gets a list of all attendances in the database
     * @return The list of all attendances
     */
    public ArrayList<Attendance> getAllAttendance() {
        try {
            initializeJDBC();
            closeJDBC();
        }
        catch (Exception e) {
            
        }
        return null;
    }
    /**
     * Gets a list of session attendance for a specific user
     * @param user The user ID to look for
     * @return The list of attendances that match the criteria
     */
    public ArrayList<Attendance> getAttendanceByUser(int user) {
        try {
            initializeJDBC();
            closeJDBC();
            
        }
        catch (Exception e) {
            
        }
        return null;
    }
    /**
     * Gets a list of session attendance for a specific session
     * @param session The session ID to look for
     * @return The list of attendances that match the criteria
     */
    public ArrayList<Attendance> getAttendanceBySession(int session) {
        try {
            initializeJDBC();
            closeJDBC();
            
        }
        catch (Exception e) {
            
        }
        return null;
    }
    /**
     * Gets a list of session attended by whether or not they've been attended
     * @param registered The condition to look for in the query
     * @return The list of attendances that match the criteria
     */
    public ArrayList<Attendance> getAttendanceByRegistered(boolean registered) {
        try {
            initializeJDBC();
            closeJDBC();
            
        }
        catch (Exception e) {
            
        }
        return null;
    }
}
