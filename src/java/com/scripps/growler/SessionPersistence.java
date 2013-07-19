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

    public void addSession(Session s) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("insert into session "
                    + " (name, session_date, start_time, location, duration, description) "
                    + " values (?, ?, ?, ?, ?, ?)");
            statement.setString(1, s.getName());
            statement.setDate(2, s.getSessionDate());
            statement.setTime(3, s.getStartTime());
            statement.setString(4, s.getLocation());
            statement.setTime(5, s.getDuration());
            statement.setString(6, s.getDescription());
            statement.execute();
            generateKey(s.getName());
            closeJDBC();
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
    }

    /**
     * Deletes a session
     *
     * @param s The session to delete
     */
    public void deleteSession(Session s) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("delete from session where id = ?");
            statement.setInt(1, s.getId());
            statement.execute();
            closeJDBC();
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
    }

    /**
     * Updates a session
     *
     * @param s The values to update
     */
    public void updateSession(Session s) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("update session set "
                    + "name = ?,"
                    + "description = ?, "
                    + "session_date = ?, "
                    + "start_time = ?,"
                    + "location = ?,"
                    + "duration = ? "
                    + "where id = ?");
            statement.setString(1, s.getName());
            statement.setString(2, s.getDescription());
            statement.setDate(3, s.getSessionDate());
            statement.setTime(4, s.getStartTime());
            statement.setString(5, s.getLocation());
            statement.setTime(6, s.getDuration());
            statement.setInt(7, s.getId());
            statement.execute();
            generateKey(s.getName());
            closeJDBC();
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
    }

    /**
     * Generates the keys for all sessions
     *
     * @param list A list of sessions
     */
    public void generateKey(String name) {
        try {
            statement = connection.prepareStatement("select id from session where name = ?");
            statement.setString(1, name);
            result = statement.executeQuery();
            if (result.next()) {
                Session s = new Session();
                s.setId(result.getInt("id"));
                statement = connection.prepareStatement("update session set session_key = "
                        + "substring(sha1(" + result.getInt("id") + "),1,4) where id = " + result.getInt("id"));
                statement.execute();
            }

        } catch (Exception e) {
        }
        finally {
            closeJDBC();
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
                s.setSessionDate(result.getDate(4));
                s.setStartTime(result.getTime("start_time"));
                s.setLocation(result.getString("location"));
                s.setTrack(result.getString("track"));
                s.setDuration(result.getTime("duration"));
                s.setKey(result.getString("session_key"));
                //Add the session to the list
                sessions.add(s);
            }
            closeJDBC();
            return sessions;
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
        return sessions;
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
            sessions = new ArrayList<Session>();
            while (result.next()) {
                //Create a new Session and add all data about the session to it
                Session s = new Session();
                s.setId(result.getInt("id"));
                s.setName(result.getString("name"));
                s.setDescription(result.getString("description"));
                s.setSessionDate(result.getDate("session_date"));
                s.setStartTime(result.getTime("start_time"));
                s.setLocation(result.getString("location"));
                s.setTrack(result.getString("track"));
                s.setDuration(result.getTime("duration"));
                //Add the session to the list
                sessions.add(s);
            }
            closeJDBC();
            return sessions;
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
        return sessions;
    }

    /**
     * Gets a list of sessions based on a date
     *
     * @param date The date of the session
     * @param sort The sort criteria
     * @return The sessions that occur on the given date
     */
    public ArrayList<Session> getSessionsByDate(int day, String sort) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, description, "
                    + "session_date, start_time, duration, location, track from session "
                    + "where session_date = ? ?");
            String date = ("2013-10-20");
            if (day == 1) {
                date = ("2013-10-17");
            }
            else if (day == 2) {
                date = ("2013-10-18");
            }
            statement.setString(1, date);
            statement.setString(2, sort);
            result = statement.executeQuery();
            sessions = new ArrayList<Session>();
            while (result.next()) {
                //Create a new Session and add all data about the session to it
                Session s = new Session();
                s.setId(result.getInt("id"));
                s.setName(result.getString("name"));
                s.setDescription(result.getString("description"));
                s.setSessionDate(result.getDate("session_date"));
                s.setStartTime(result.getTime("start_time"));
                s.setLocation(result.getString("location"));
                s.setTrack(result.getString("track"));
                s.setDuration(result.getTime("duration"));
                //Add the session to the list
                sessions.add(s);
            }
            closeJDBC();
            return sessions;
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
        return sessions;
    }
    
    public ArrayList<Session> getSessionsWithoutADate() {
         try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, description, "
                    + "session_date, start_time, duration, location, track from session "
                    + "where session_date is null");
            result = statement.executeQuery();
            sessions = new ArrayList<Session>();
            while (result.next()) {
                //Create a new Session and add all data about the session to it
                Session s = new Session();
                s.setId(result.getInt("id"));
                s.setName(result.getString("name"));
                s.setDescription(result.getString("description"));
                s.setSessionDate(result.getDate("session_date"));
                s.setStartTime(result.getTime("start_time"));
                s.setLocation(result.getString("location"));
                s.setTrack(result.getString("track"));
                s.setDuration(result.getTime("duration"));
                //Add the session to the list
                sessions.add(s);
            }
            closeJDBC();
            return sessions;
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
        return sessions;
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
            sessions = new ArrayList<Session>();
            while (result.next()) {
                //Create a new Session and add all data about the session to it
                Session s = new Session();
                s.setId(result.getInt("id"));
                s.setName(result.getString("name"));
                s.setDescription(result.getString("description"));
                s.setSessionDate(result.getDate("session_date"));
                s.setStartTime(result.getTime("start_time"));
                s.setLocation(result.getString("location"));
                s.setTrack(result.getString("track"));
                s.setDuration(result.getTime("duration"));
                //Add the session to the list
                sessions.add(s);
            }
            closeJDBC();
            return sessions;
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
        return sessions;
    }

    /**
     * Gets a session based on a date and time
     *
     * @param date The date of the session
     * @param time The time of the session
     * @return The session on the given date at the given time
     */
    public Session getSessionByDateAndTime(java.sql.Date date, java.sql.Time time, String sort) {
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
                s.setLocation(result.getString("location"));
                s.setTrack(result.getString("track"));
                s.setDuration(result.getTime("duration"));
                //Add the session to the list
                return s;
            }
            closeJDBC();
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
        return new Session();
    }

    /**
     * Gets a list of sessions that are on today's date, that are over, but haven't been over longer than 15 minutes.
     * @return Sessions a user can acknowledge
     */
    public ArrayList<Session> getSessionsToAcknowledge() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name from session where session_date = curdate() and addtime(start_time, duration) <= curtime() and addtime(addtime(start_time,duration), '00:15:00') >= curtime()");
            result = statement.executeQuery();
            while (result.next()) {
                Session s = new Session();
                s.setId(result.getInt("id"));
                s.setName(result.getString("name"));
                sessions.add(s);
            }
            closeJDBC();
            return sessions;
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
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
                s.setLocation(result.getString("location"));
                s.setTrack(result.getString("track"));
                s.setDuration(result.getTime("duration"));
            }
            return s;
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
        return null;
    }
    
    public ArrayList<Session> getThisYearSessions(int year, String sort, int limit) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, description, session_date, start_time, location, track, duration, session_key from session where extract(YEAR FROM session_date) = ? and extract(MONTH FROM session_date) = '10' " + sort + " limit ?, 15");
            statement.setInt(1, year);
            statement.setInt(2, limit);
            result = statement.executeQuery();
            sessions = new ArrayList<Session>();
            while (result.next()) {
                Session s = new Session();
                s.setId(result.getInt("id"));
                s.setName(result.getString("name"));
                s.setDescription(result.getString("description"));
                s.setSessionDate(result.getDate("session_date"));
                s.setStartTime(result.getTime("start_time"));
                s.setLocation(result.getString("location"));
                s.setTrack(result.getString("track"));
                s.setDuration(result.getTime("duration"));
                s.setKey(result.getString("session_key"));
                sessions.add(s);
            }
            return sessions;
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return sessions;
    }

    public ArrayList<Session> getThisYearSessions(int year, String sort) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, description, session_date, start_time, location, track, duration, session_key from session where extract(YEAR FROM session_date) = ? and extract(MONTH FROM session_date) = '10' " + sort);
            statement.setInt(1, year);
            result = statement.executeQuery();
            sessions = new ArrayList<Session>();
            while (result.next()) {
                Session s = new Session();
                s.setId(result.getInt("id"));
                s.setName(result.getString("name"));
                s.setDescription(result.getString("description"));
                s.setSessionDate(result.getDate("session_date"));
                s.setStartTime(result.getTime("start_time"));
                s.setLocation(result.getString("location"));
                s.setTrack(result.getString("track"));
                s.setDuration(result.getTime("duration"));
                s.setKey(result.getString("session_key"));
                sessions.add(s);
            }
            return sessions;
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return sessions;
    }

    /**
     * Checks to see if there is a session already scheduled in a room at a certain time. Multiple locations can have "TBD" as the value.
     * 
     * @param id
     * @param location
     * @return False if there is a session already scheduled in that room for that time \n True if there is no session in that room at that time
     */
    public boolean validateSessionSlot(int id, String location) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, start_time, addtime(start_time, duration), session_date, location from session where addtime(start_time, duration) >= (select start_time from session where id = ?) and session_date = (select session_date from session where id = ?) and start_time <= (select addtime(start_time, duration) from session where id = ?)");
            statement.setInt(1, id);
            statement.setInt(2, id);
            statement.setInt(3, id);
            result = statement.executeQuery();
            while (result.next()) {
                if (result.getString("location").equals(location) && !location.equals("TBD")) {
                    return false;
                }
            }
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return true;
    }
    
    public ArrayList<Session> getUnscheduledSessions() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select * from session where extract(YEAR FROM session_date) = 2013 and extract(MONTH FROM session_date) = '10' and start_time is null order by session_date, start_time, name");
            result = statement.executeQuery();
            sessions.clear();
            while (result.next()) {
                Session s = new Session();
                s.setId(result.getInt("id"));
                s.setName(result.getString("name"));
                s.setDescription(result.getString("description"));
                s.setSessionDate(result.getDate("session_date"));
                s.setLocation(result.getString("location"));
                s.setTrack(result.getString("track"));
                s.setDuration(result.getTime("duration"));
                s.setKey(result.getString("session_key"));
                sessions.add(s);
            }
            return sessions;
        }catch (Exception e) {
            
        } finally {
            closeJDBC();
        }
        return sessions;
    }
    
    public int getThisYearSessionCount(int year) {
        int rows = 0;
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select count(id) from session where extract(YEAR FROM session_date) = ?");
            statement.setInt(1, year);
            result = statement.executeQuery();    
            while (result.next()){
                rows = result.getInt(1);
            }
        } catch(Exception e) {
            
        } finally {
            closeJDBC();
        }
        return rows;
    }

    public void assignSpeakerTeam() {
    }
}
