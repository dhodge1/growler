package com.scripps.growler;
import java.sql.*;
import java.util.*;
/**
 * Handles database communication for Attendance objects
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
     * An array list for each method to use
     */
    ArrayList<Attendance> attendances = new ArrayList<Attendance>();
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
		statement = connection.prepareStatement("select user_id, session_id, isRegistered from attendance");
		result = statement.executeQuery();
		while (result.next()){
			Attendance a = new Attendance();
			a.setUserId(result.getInt("user_id"));
			a.setSessionId(result.getInt("session_id"));
			a.setIsRegistered(result.getBoolean("isRegistered"));
			attendances.add(a);
		}
            closeJDBC();
		return(attendances);
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
            initializeJDBC();statement = connection.prepareStatement("select user_id, session_id, isRegistered from attendance where user_id = ?");
		statement.setInt(1,user);
		result = statement.executeQuery();
		while (result.next()){
			Attendance a = new Attendance();
			a.setUserId(result.getInt("user_id"));
			a.setSessionId(result.getInt("session_id"));
			a.setIsRegistered(result.getBoolean("isRegistered"));
			attendances.add(a);
		}
            closeJDBC();
		return(attendances);          
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
            initializeJDBC();statement = connection.prepareStatement("select user_id, session_id, isRegistered from attendance where session_id = ?");
		statement.setInt(1,session);
		result = statement.executeQuery();
		while (result.next()){
			Attendance a = new Attendance();
			a.setUserId(result.getInt("user_id"));
			a.setSessionId(result.getInt("session_id"));
			a.setIsRegistered(result.getBoolean("isRegistered"));
			attendances.add(a);
		}
            closeJDBC();
		return(attendances);          
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
            initializeJDBC();statement = connection.prepareStatement("select user_id, session_id, isRegistered from attendance where isRegistered = ?");
		statement.setBoolean(1, registered);
		result = statement.executeQuery();
		while (result.next()){
			Attendance a = new Attendance();
			a.setUserId(result.getInt("user_id"));
			a.setSessionId(result.getInt("session_id"));
			a.setIsRegistered(result.getBoolean("isRegistered"));
			attendances.add(a);
		}
            closeJDBC();
		return(attendances);          
        }
        catch (Exception e) {
            
        }
        return null;
    }
}
