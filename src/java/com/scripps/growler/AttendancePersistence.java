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
     * Adds an attendance record to the database
     *
     * @param a The attendance record to add
     */
    public void addAttendance(Attendance a) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("set time_zone = 'US/Eastern'");
            statement.execute();
            statement = connection.prepareStatement("insert into attendance "
                    + " (user_id, session_id, isSurveyTaken, isKeyGiven) "
                    + " values (?, ?, ?, ?)");
            statement.setInt(1, a.getUserId());
            statement.setInt(2, a.getSessionId());
            statement.setBoolean(3, a.getIsSurveyTaken());
            statement.setBoolean(4, a.getIsKeyGiven());
            statement.execute();
            closeJDBC();
        } catch (Exception e) {
        }
    }

    /**
     * Deletes an attendance record from the database: Only if the user hasn't
     * taken a survey
     *
     * @param a
     */
    public void deleteAttendance(Attendance a) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("delete from attendance where user_id = ? and session_id = ? and isSurveyTaken = 0");
            statement.setInt(1, a.getUserId());
            statement.setInt(2, a.getSessionId());
            statement.execute();
            closeJDBC();
        } catch (Exception e) {
        }
    }

    /**
     * Gets a list of all attendances in the database
     *
     * @return The list of all attendances
     */
    public ArrayList<Attendance> getAllAttendance() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select user_id, session_id, isSurveyTaken, surveySubmitTime from attendance ");
            result = statement.executeQuery();
            while (result.next()) {
                Attendance a = new Attendance();
                a.setUserId(result.getInt("user_id"));
                a.setSessionId(result.getInt("session_id"));
                a.setIsSurveyTaken(result.getBoolean("isSurveyTaken"));
                a.setSurveySubmitTime(result.getTimestamp("surveySubmitTime"));
                attendances.add(a);
            }
            closeJDBC();
            return (attendances);
        } catch (Exception e) {
        }
        return null;
    }

    /**
     * Gets a list of session attendance for a specific user
     *
     * @param user The user ID to look for
     * @return The list of attendances that match the criteria
     */
    public ArrayList<Attendance> getAttendanceByUser(int user) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select user_id, session_id, isSurveyTaken from attendance where user_id = ?");
            statement.setInt(1, user);
            result = statement.executeQuery();
            while (result.next()) {
                Attendance a = new Attendance();
                a.setUserId(result.getInt("user_id"));
                a.setSessionId(result.getInt("session_id"));
                a.setIsSurveyTaken(result.getBoolean("isSurveyTaken"));
                attendances.add(a);
            }
            closeJDBC();
            return (attendances);
        } catch (Exception e) {
        }
        return null;
    }

    /**
     * Gets a list of session attendance for a specific session
     *
     * @param session The session ID to look for
     * @return The list of attendances that match the criteria
     */
    public ArrayList<Attendance> getAttendanceBySession(int session) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select user_id, session_id, isSurveyTaken, surveySubmitTime from attendance where session_id = ?");
            statement.setInt(1, session);
            result = statement.executeQuery();
            while (result.next()) {
                Attendance a = new Attendance();
                a.setUserId(result.getInt("user_id"));
                a.setSessionId(result.getInt("session_id"));
                a.setIsSurveyTaken(result.getBoolean("isSurveyTaken"));
                a.setSurveySubmitTime(result.getTimestamp("surveySubmitTime"));
                attendances.add(a);
            }
            closeJDBC();
            return (attendances);
        } catch (Exception e) {
        }
        return null;
    }

    public int getCountBySession(int session) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select count(user_id) from attendance where session_id = ?");
            statement.setInt(1, session);
            result = statement.executeQuery();
            while (result.next()) {
                return (result.getInt(1));
            }
            closeJDBC();
        } catch (Exception e) {
        }
        return 0;
    }

    /**
     * Gets a list of session attended by whether or not they've been attended
     *
     * @param registered The condition to look for in the query
     * @return The list of attendances that match the criteria
     */
    public ArrayList<Attendance> getAttendanceByRegistered(boolean registered) {
        try {
            initializeJDBC();
            initializeJDBC();
            statement = connection.prepareStatement("select user_id, session_id, isSurveyTaken, surveySubmitTime from attendance where isSurveyTaken = ?");
            statement.setBoolean(1, registered);
            result = statement.executeQuery();
            while (result.next()) {
                Attendance a = new Attendance();
                a.setUserId(result.getInt("user_id"));
                a.setSessionId(result.getInt("session_id"));
                a.setIsSurveyTaken(result.getBoolean("isSurveyTaken"));
                a.setSurveySubmitTime(result.getTimestamp("surveySubmitTime"));
                attendances.add(a);
            }
            closeJDBC();
            return (attendances);
        } catch (Exception e) {
        }
        return null;
    }

    public ArrayList<Attendance> getAttendanceBySubmitTime() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select user_id, session_id, surveySubmitTime from attendance where isSurveyTaken = true order by surveySubmitTime");
            result = statement.executeQuery();
            while (result.next()) {
                Attendance a = new Attendance();
                a.setUserId(result.getInt("user_id"));
                a.setSessionId(result.getInt("session_id"));
                a.setSurveySubmitTime(result.getTimestamp("surveySubmitTime"));
                attendances.add(a);
            }
            return attendances;
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }

        return null;
    }

    public ArrayList<Session> getUsersAttendanceInYear(int user) {
        ArrayList<Session> sessions = new ArrayList<Session>();
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select s.id as id, s.name as name, s.session_date as session_date, s.start_time as start_time, a.isSurveyTaken as isSurveyTaken from thisyearsession s left join attendance a on a.session_id = s.id and a.user_id = ? order by session_date, start_time, name");
            statement.setInt(1, user);
            result = statement.executeQuery();    
            while (result.next()) {
                Session s = new Session();
                s.setId(result.getInt("id"));
                s.setName(result.getString("name"));
                s.setSessionDate(result.getDate("session_date"));
                s.setStartTime(result.getTime("start_time"));
                s.setSurvey(result.getBoolean("isSurveyTaken"));
                sessions.add(s);
            }
            return sessions;
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return sessions;
    }
}
