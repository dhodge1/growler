package com.scripps.growler;

import java.util.*;
import java.sql.*;

/**
 * Handles the database communications for the Sessions
 *
 * @see com.scripps.growler.Session
 * @author "Justin Bauguess"
 */
public class SessionPersistence extends GrowlerPersistence {

    /**
     * Sorts queries by session id ascending
     */
    final String SORT_BY_ID_ASC = " order by session.id asc";
    /**
     * Sorts queries by session id descending
     */
    final String SORT_BY_ID_DESC = " order by session.id desc";
    /**
     * Sorts queries by name ascending
     */
    final String SORT_BY_NAME_ASC = " order by session.name asc";
    /**
     * Sorts queries by name descending
     */
    final String SORT_BY_NAME_DESC = " order by session.name desc";
    /**
     * Sorts queries by track ascending
     */
    final String SORT_BY_TRACK_ASC = " order by session.track asc";
    /**
     * Sorts queries by track descending
     */
    final String SORT_BY_TRACK_DESC = " order by session.track desc";
    /**
     * Sorts queries by location ascending
     */
    final String SORT_BY_LOCATION_ASC = " order by session.location asc";
    /**
     * Sorts queries by location descending
     */
    final String SORT_BY_LOCATION_DESC = " order by session.location desc";
    /**
     * Sorts queries by date ascending
     */
    final String SORT_BY_DATE_ASC = " order by session.session_date asc";
    /**
     * Sorts queries by date descending
     */
    final String SORT_BY_DATE_DESC = " order by session.session_date desc";
    /**
     * Sorts queries by time ascending
     */
    final String SORT_BY_TIME_ASC = " order by session.start_time asc";
    /**
     * Sorts queries by time descending
     */
    final String SORT_BY_TIME_DESC = " order by session.start_time desc";
    /**
     * Sorts queries by duration ascending
     */
    final String SORT_BY_DURATION_ASC = " order by session.duration asc";
    /**
     * Sorts queries by duration descending
     */
    final String SORT_BY_DURATION_DESC = " order by session.duration desc";
    /**
     * Sorts queries by date then time ascending
     */
    final String SORT_BY_DATE_TIME_ASC = " order by session.session_date, session.start_time asc";
    /**
     * Sorts queries by date then time descending
     */
    final String SORT_BY_DATE_TIME_DESC = " order by session.session_date, session.start_time desc";
    /**
     * An array list object for each method to use
     */
    ArrayList<Session> sessions = new ArrayList<Session>();

    /**
     * Default Constructor
     */
    public SessionPersistence() {
    }
    public void addSession(Session s){
        try {
            initializeJDBC();
            statement = connection.prepareStatement("insert into session " +
                    " (name, session_date, start_time, location, duration) " +
                    " values (?, ?, ?, ?, ?)");
            statement.setString(1, s.getName());
            statement.setDate(2, s.getSessionDate());
            statement.setTime(3, s.getStartTime());
            statement.setInt(4, s.getLocation());
            statement.setInt(5, s.getDuration());
            statement.execute();
            closeJDBC();
        }
        catch(Exception e){
            
        }
    }

    /**
     * Generates the keys for all sessions
     *
     * @param list A list of sessions
     */
    public void generateKey(int id) {
        try {
            statement = connection.prepareStatement("select id from session where id = ?");
            statement.setInt(1, id);
            result = statement.executeQuery();
            if(result.next()){
                Session s = new Session();
                s.setId(result.getInt("id"));
                statement = connection.prepareStatement("update session set session_key = " +
                        "substring(sha1(" + id + "),1,4) where id = " + id);
                statement.execute();
            }
            
        } catch (Exception e) {
        }
    }
    /**
     * Gets a list of all sessions in the database
     *
     * @param sort the criteria to sort the sessions
     * @return A list of sessions in the database, sorted
     */
    public ArrayList<Session> getAllSessionsWithKeys(String sort) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, description, session_date, start_time, "
                    + " location, track, duration, session_key from session " + sort);
            result = statement.executeQuery();
            while (result.next()) {
                //Create a new Session and add all data about the session to it
                Session s = new Session();
                s.setId(result.getInt("id"));
                s.setName(result.getString("name"));
                s.setDescription(result.getString("description"));
                s.setSessionDate(result.getDate("session_date"));
                s.setStartTime(result.getTime("start_time"));
                s.setLocation(result.getInt("location"));
                s.setTrack(result.getString("track"));
                s.setDuration(result.getInt("duration"));
                s.setKey(result.getString(("session_key")));
                //Add the session to the list
                sessions.add(s);
            }
            closeJDBC();
            return sessions;
        } catch (Exception e) {
        }
        return null;
    }

    /**
     * Gets a list of all sessions in the database
     *
     * @param sort the criteria to sort the sessions
     * @return A list of sessions in the database, sorted
     */
    public ArrayList<Session> getAllSessions(String sort) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, description, session_date, start_time, "
                    + " location, track, duration from session " + sort);
            result = statement.executeQuery();
            while (result.next()) {
                //Create a new Session and add all data about the session to it
                Session s = new Session();
                s.setId(result.getInt("id"));
                s.setName(result.getString("name"));
                s.setDescription(result.getString("description"));
                s.setSessionDate(result.getDate("session_date"));
                s.setStartTime(result.getTime("start_time"));
                s.setLocation(result.getInt("location"));
                s.setTrack(result.getString("track"));
                s.setDuration(result.getInt("duration"));
                //Add the session to the list
                sessions.add(s);
            }
            closeJDBC();
            return sessions;
        } catch (Exception e) {
        }
        return null;
    }

    /**
     * Gets a list of sessions based on a date
     *
     * @param date The date of the session
     * @param sort The sort criteria
     * @return The sessions that occur on the given date
     */
    public ArrayList<Session> getSessionsByDate(java.sql.Date date, String sort) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, description, "
                    + "session_date, start_time, duration, location, track from session "
                    + "where session_date = ? ?");
            statement.setDate(1, date);
            statement.setString(2, sort);
            result = statement.executeQuery();
            while (result.next()) {
                //Create a new Session and add all data about the session to it
                Session s = new Session();
                s.setId(result.getInt("id"));
                s.setName(result.getString("name"));
                s.setDescription(result.getString("description"));
                s.setSessionDate(result.getDate("session_date"));
                s.setStartTime(result.getTime("start_time"));
                s.setLocation(result.getInt("location"));
                s.setTrack(result.getString("track"));
                s.setDuration(result.getInt("duration"));
                //Add the session to the list
                sessions.add(s);
            }
            closeJDBC();
            return sessions;
        } catch (Exception e) {
        }
        return null;
    }

    /**
     * Gets a list of sessions based on a time
     *
     * @param time The time of the session
     * @param sort The sort criteria
     * @return The sessions that occur at the given time
     */
    public ArrayList<Session> getSessionsByTime(java.sql.Time time, String sort) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, description, "
                    + "session_date, start_time, duration, location, track from session "
                    + "where start_time = ? ?");
            statement.setTime(1, time);
            statement.setString(2, sort);
            result = statement.executeQuery();
            while (result.next()) {
                //Create a new Session and add all data about the session to it
                Session s = new Session();
                s.setId(result.getInt("id"));
                s.setName(result.getString("name"));
                s.setDescription(result.getString("description"));
                s.setSessionDate(result.getDate("session_date"));
                s.setStartTime(result.getTime("start_time"));
                s.setLocation(result.getInt("location"));
                s.setTrack(result.getString("track"));
                s.setDuration(result.getInt("duration"));
                //Add the session to the list
                sessions.add(s);
            }
            closeJDBC();
            return sessions;
        } catch (Exception e) {
        }
        return null;
    }

    /**
     * Gets a list of sessions based on a date and time
     *
     * @param date The date of the session
     * @param time The time of the session
     * @return The sessions on the given date at the given time
     */
    public ArrayList<Session> getSessionsByDateAndTime(java.sql.Date date, java.sql.Time time, String sort) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, description, "
                    + "session_date, start_time, duration, location, track from session "
                    + "where session_date = ? and start_time = ? ?");
            statement.setDate(1, date);
            statement.setTime(2, time);
            statement.setString(3, sort);
            result = statement.executeQuery();
            while (result.next()) {
                //Create a new Session and add all data about the session to it
                Session s = new Session();
                s.setId(result.getInt("id"));
                s.setName(result.getString("name"));
                s.setDescription(result.getString("description"));
                s.setSessionDate(result.getDate("session_date"));
                s.setStartTime(result.getTime("start_time"));
                s.setLocation(result.getInt("location"));
                s.setTrack(result.getString("track"));
                s.setDuration(result.getInt("duration"));
                //Add the session to the list
                sessions.add(s);
            }
            closeJDBC();
            return sessions;
        } catch (Exception e) {
        }
        return null;
    }

    /**
     * Finds a session based on a session id
     *
     * @param id The id to look for
     * @return The session object for that id
     */
    public Session getSessionByID(int id) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, description, "
                    + "session_date, start_time, duration, location, track from session "
                    + "where id = ?");
            statement.setInt(1, id);
            result = statement.executeQuery();
            Session s = new Session();
            if (result.next()) {
                //Create a new Session and add all data about the session to it
                s.setId(result.getInt("id"));
                s.setName(result.getString("name"));
                s.setDescription(result.getString("description"));
                s.setSessionDate(result.getDate("session_date"));
                s.setStartTime(result.getTime("start_time"));
                s.setLocation(result.getInt("location"));
                s.setTrack(result.getString("track"));
                s.setDuration(result.getInt("duration"));
            }
            closeJDBC();
            return s;
        } catch (Exception e) {
        }
        return null;
    }

    /**
     * Gets a list of sessions based on a duration
     *
     * @param duration How many minutes a session lasts
     * @param sort The sort criteria
     * @return The sessions that last the specified amount of minutes
     */
    public ArrayList<Session> getSessionByDuration(int duration, String sort) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, description, "
                    + "session_date, start_time, duration, location, track from session "
                    + "where duration = ? ?");
            statement.setInt(1, duration);
            statement.setString(2, sort);
            result = statement.executeQuery();
            while (result.next()) {
                //Create a new Session and add all data about the session to it
                Session s = new Session();
                s.setId(result.getInt("id"));
                s.setName(result.getString("name"));
                s.setDescription(result.getString("description"));
                s.setSessionDate(result.getDate("session_date"));
                s.setStartTime(result.getTime("start_time"));
                s.setLocation(result.getInt("location"));
                s.setTrack(result.getString("track"));
                s.setDuration(result.getInt("duration"));
                //Add the session to the list
                sessions.add(s);
            }
            closeJDBC();
            return sessions;
        } catch (Exception e) {
        }
        return null;
    }
}
