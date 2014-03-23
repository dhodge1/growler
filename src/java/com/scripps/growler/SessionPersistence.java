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
            //statement.setString(4, s.getLocation());
            statement.setString(4, "TBD");
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
    
    public ArrayList<Session> getThisYearSessionsWithRegistration(int user, String sort) {
        try {
            statement = connection.prepareStatement("select s.id, s.name, s.description, "
                    + "s.session_date, s.start_time, s.location, s.duration, s.session_key, "
                    + "r.user_id from session s left join registration r on s.id = r.session_id "
                    + "and r.user_id = ? " + sort);
            statement.setInt(1, user);
            result = statement.executeQuery();
            while (result.next()){
                Session s = new Session();
                s.setId(result.getInt("s.id"));
                s.setName(result.getString("s.name"));
                s.setDescription(result.getString("s.description"));
                s.setSessionDate(result.getDate("s.session_date"));
                s.setStartTime(result.getTime("s.start_time"));
                s.setLocation(result.getString("s.location"));
                s.setDuration(result.getTime("s.duration"));
                s.setKey(result.getString("s.session_key"));
                s.setUserRegistered(result.getInt("r.user_id"));
                sessions.add(s);
            }
            return sessions;
        } catch(Exception e){
            
        } finally {
            
        }
        return sessions;
    }
    
    public ArrayList<Session> getThisYearSessions(int year, String sort, int limit) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, description, session_date, start_time, location, track, duration, session_key, active from session where extract(YEAR FROM session_date) = ? and extract(MONTH FROM session_date) = '10' " + sort + " limit ?, 15");
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
                s.setActive(result.getBoolean("active"));
                sessions.add(s);
            }
            return sessions;
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return sessions;
    }
    
    public ArrayList<Session> getThisYearActiveSessions(int year, String sort, boolean state) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, description, session_date, start_time, location, track, duration, session_key, active from session where extract(YEAR FROM session_date) = ? and active = ? and extract(MONTH FROM session_date) = '10' " + sort);
            statement.setInt(1, year);
            statement.setBoolean(2, state);
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
                s.setActive(result.getBoolean("active"));
                sessions.add(s);
            }
            return sessions;
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return sessions;
    }
    
    public void setSessionState(int sessionID, boolean state) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("update session set active = ? where id = ?");
            statement.setBoolean(1, state);
            statement.setInt(2, sessionID);
            statement.execute();
            closeJDBC();
        } catch (Exception e){
        } finally {
            closeJDBC();
        }
    }  

    /**
     * Returns a list of sessions for a given year
     * 
     * Information includes id, name, description, session_date, start_time, location, track, duration and key
     * 
     * @param year The year to query against
     * @param sort The sorting criteria
     * @return A list of each session in the given year, sorted by the given criteria
     */
    public ArrayList<Session> getThisYearSessions(int year, String sort) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, description, session_date, start_time, location, track, duration, session_key, active from session where extract(YEAR FROM session_date) = ? and extract(MONTH FROM session_date) = '10' " + sort);
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
                s.setActive(result.getBoolean("active"));
                sessions.add(s);
            }
            return sessions;
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return sessions;
    }

    //***********************************************************************
    //***********************ADDED CODE START HERE***************************
    //***********************************************************************
    
    /************************************************************************
     * author: Thuy
     * This method retrieves only sessions that receives at least 1 like from 
     * the Techtoberfest event participant in a particular given year.
     * 
     * @param year: session year
     *               
     * @return: An array list of session in a particular given year
     ************************************************************************/
        public ArrayList<Session> getSessionsWithAtLeast1Like(int year) {
        try {
            //***********************************
            //The following query selects all the given
            //year sessions that has at least on liked
            //***********************************
            String preparedQuery = ("SELECT s.* "
                                  + "FROM session s "
                                  + "WHERE EXTRACT(YEAR FROM session_date) = ? "
                                  + "AND EXTRACT(MONTH FROM session_date) = '10' "
                                  + "AND EXISTS(SELECT NULL "
                                                + "FROM registration r "
                                                + "WHERE s.id = r.session_id) "
                                                + "ORDER BY s.name ASC"); 
            //********************************************************************                                                          
            initializeJDBC();
            statement = connection.prepareStatement(preparedQuery);             
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

    //*********************ADDED CODE END HERE*********************************
    
    
  
        
        
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
    
    /**
     * Gets sessions that haven't been scheduled for Techtoberfest
     * 
     * @return The list of unscheduled sessions
     */
    public ArrayList<Session> getUnscheduledSessions() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select * from session where extract(YEAR FROM session_date) = 2013 and extract(MONTH FROM session_date) = '10' and location not in ('E130', 'D304') order by session_date, start_time, name");
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
    
    /**
     * Returns who is speaking for a session
     * 
     * Useful because there are times where multiple people may present for a session
     * 
     * @param session the session ID
     * @return A list of speakers for a session
     */
    public ArrayList<Speaker> getSpeakersForSession(int session){
        ArrayList<Speaker> speakers = new ArrayList<Speaker>();
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select s.first_name, s.id, s.last_name from speaker s, session ses, speaker_team t where t.speaker_id = s.id and t.session_id = ses.id and ses.id = ?");
            statement.setInt(1, session);
            result = statement.executeQuery();    
            while (result.next()){
                Speaker s = new Speaker();
                s.setId(result.getInt("id"));
                s.setFirstName(result.getString("first_name"));
                s.setLastName(result.getString("last_name"));
                speakers.add(s);
            }
        } catch(Exception e) {
            
        } finally {
            closeJDBC();
        }
        return speakers;
    }
    
    
    
    

    
    /**
     * Validates that a key is correct for a session
     * 
     * @param key
     * @return true if the key matches, false if it's wrong
     */
    public boolean checkKey(String key, int sessionId){
        try {
            initializeJDBC();
            statement = connection.prepareStatement("set time_zone = 'US/Eastern'");
            statement.execute();
            statement = connection.prepareStatement("select count(id) from session where session_key = ? and id = ?");
            statement.setString(1, key);
            statement.setInt(2, sessionId);
            result = statement.executeQuery();
            while (result.next()){
                if (result.getInt(1) > 0){
                    return true;
                }
            }
        } catch(Exception e) {
            
        } finally {
            closeJDBC();
        }
        return false;
    }

    /**
     * Creates a view to use in queries
     * 
     * @param year The year to create the view for
     */
    public void createThisYearSessions(int year){
        try {
            initializeJDBC();
            statement = connection.prepareStatement("create or replace view thisyearsession as (select s.id, s.name, s.session_date, s.start_time from session s where extract(year from s.session_date) = ?)");
            statement.setInt(1, year);
            statement.execute();
        } catch(Exception e) {
            
        } finally {
            closeJDBC();
        }
        
    }
    
    public void assignSpeaker(int speaker, int session){
        try {
            initializeJDBC();
            statement = connection.prepareStatement("insert into speaker_team (speaker_id, session_id) values (?, ?)");
            statement.setInt(1, speaker);
            statement.setInt(2, session);
            statement.execute();
        } catch (Exception e) {
            
        } finally {
            closeJDBC();
        }
    }
    
    public void undoAssignSpeaker(int speaker, int session){
        try {
            initializeJDBC();
            statement = connection.prepareStatement("delete from speaker_team where speaker_id = ? and session_id = ?");
            statement.setInt(1, speaker);
            statement.setInt(2, session);
            statement.execute();
        } catch (Exception e) {
            
        } finally {
            closeJDBC();
        }
    }
    
    public boolean validateSlotNoLocation(int id){
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select count(id), name, start_time, addtime(start_time, duration), session_date, location from session where addtime(start_time, duration) >= (select start_time from session where id = ?) and session_date = (select session_date from session where id = ?) and start_time <= (select addtime(start_time, duration) from session where id = ?)");
            statement.setInt(1, id);
            statement.setInt(2, id);
            statement.setInt(3, id);
            result = statement.executeQuery();
            while (result.next()) {
                if (result.getInt(1) > 1) {
                    return false;
                }
            }
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return true;
    }
    
    public ArrayList<Session> getSessionsByDateAndTime(java.sql.Date date, java.sql.Time time) {
        try {
            initializeJDBC();
            sessions.clear();
            statement = connection.prepareStatement("select * from session where session_date = ? and start_time = ?");
            statement.setDate(1, date);
            statement.setTime(2, time);            
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
                sessions.add(s);
            }
            return sessions;
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
        return sessions;
    }
    
    public Session getSessionByName(String name) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select * from session where name = ?");
            statement.setString(1, name);
            result = statement.executeQuery();
            while (result.next()){
                Session s = new Session();
                s.setId(result.getInt("id"));
                s.setName(result.getString("name"));
                s.setDescription(result.getString("description"));
                s.setSessionDate(result.getDate("session_date"));
                s.setStartTime(result.getTime("start_time"));
                s.setLocation(result.getString("location"));
                s.setTrack(result.getString("track"));
                s.setDuration(result.getTime("duration"));
                return s;
            }
        } catch(Exception e){
            
        }finally  {
            closeJDBC();
        }
        return new Session();
    }
    /**
     * Gets a list of sessions in the same timeslot as a given session
     * @param ses
     * @return 
     */
    public ArrayList<Session> sessionsInSlot(Session ses) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select * from session where session_date = ? and start_time = ?");
            statement.setDate(1, ses.getSessionDate());
            statement.setTime(2, ses.getStartTime());
            result = statement.executeQuery();
            while (result.next()){
                Session s = new Session();
                s.setId(result.getInt("id"));
                s.setName(result.getString("name"));
                s.setDescription(result.getString("description"));
                s.setSessionDate(result.getDate("session_date"));
                s.setStartTime(result.getTime("start_time"));
                s.setLocation(result.getString("location"));
                s.setTrack(result.getString("track"));
                s.setDuration(result.getTime("duration"));
                sessions.add(s);
            }
            return sessions;
        } catch(Exception e) {
            
        } finally {
            closeJDBC();
        }
        return new ArrayList<Session>();
    }
            
    public ArrayList<Session> checkAvailableTimes(java.sql.Date date){
        try {
            initializeJDBC();
            sessions.clear();
            statement = connection.prepareStatement("select session_date, start_time, duration from session where session_date = ? order by session_date, start_time, duration");
            statement.setDate(1, date);
            result = statement.executeQuery();
            while (result.next()){
                Session s = new Session();
                s.setSessionDate(result.getDate("session_date"));
                s.setStartTime(result.getTime("start_time"));
                s.setDuration(result.getTime("duration"));
                sessions.add(s);
            }
            return sessions;
        } catch (Exception e){
            
        } finally {
            closeJDBC();
        }
        return new ArrayList<Session>();
    }
    
    public void swapSessionLocations(int id, String location) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, start_time, addtime(start_time, duration), session_date, location from session where addtime(start_time, duration) >= (select start_time from session where id = ?) and session_date = (select session_date from session where id = ?) and start_time <= (select addtime(start_time, duration) from session where id = ?) and id != ?");
            statement.setInt(1, id);
            statement.setInt(2, id);
            statement.setInt(3, id);
            statement.setInt(4, id);
            result = statement.executeQuery();
            int replacementId = 0;
            while (result.next()) {
                 if (result.getString("location").equals(location) && !location.equals("TBD")) {
                     replacementId = result.getInt("id");
                }
            }
            SessionPersistence sp = new SessionPersistence();
            if (replacementId != 0) {
                Session ses = sp.getSessionByID(replacementId);
                ses.setLocation("TBD");
                sp.updateSession(ses);
            }
            Session updateMe = sp.getSessionByID(id);
            updateMe.setLocation(location);
            sp.updateSession(updateMe);
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }   
    }
    
    
    /**
     * Added by Chelsea Grindstaff
     * 
     * Used on trackAttendees.jsp
     * 
     * Returns sessions for a speaker
     * 
     * Useful because there are times where one speaker hosts multiple sessions
     * 
     * @param user the current logged-in user aka the speaker
     * @return A list of sessions for a speaker
     */
    public ArrayList<Session> getSessionsForSpeaker(int user){
        ArrayList<Session> sessionList = new ArrayList<Session>();
        try {
            initializeJDBC();
            /*
            statement = connection.prepareStatement("select s.id, t.session_id, t.speaker_id, u.id, u.name"
                    + "from speaker s, session u, "
                    + "inner join speaker_team t "
                    + "where t.speaker_id = s.id = ?");
            */
            
            //The below statement won't work because the speaker_id != user_id
            //statement = connection.prepareStatement("select s.id, t.session_id, t.speaker_id, u.id, u.name from speaker s, session u, speaker_team t where t.speaker_id = s.id = ?");
            statement = connection.prepareStatement("select s.id, s.first_name, s.last_name, t.session_id, t.speaker_id, u.id, u.name from speaker s, speaker_team t, session u where t.speaker_id = s.id");
            
            //statement.setInt(1, session);
            result = statement.executeQuery();    
            while (result.next()){
                //Create a new Session and add all data about the session to it
                Session a = new Session();
                a.setId(result.getInt("u.id"));         //u=session
                a.setName(result.getString("u.name"));
                sessionList.add(a);

            }
        } catch(Exception e) {
            
        } finally {
            closeJDBC();
        }
        return sessionList;
    }
    
   /**
     * Added by Chelsea Grindstaff
     * 
     * Used on trackAttendees.jsp
     * 
     * Returns sessions for a speaker
     * 
     * Useful because there are times where one speaker hosts multiple sessions
     * 
     * @param user the current logged-in user aka the speaker
     * @return A list of sessions for a speaker
     */
    public ArrayList<Session> getSessionsForHost(int user){
        ArrayList<Session> sessionList = new ArrayList<Session>();
        try {
            initializeJDBC();
            /*
            statement = connection.prepareStatement("select s.id, t.session_id, t.speaker_id, u.id, u.name"
                    + "from speaker s, session u, "
                    + "inner join speaker_team t "
                    + "where t.speaker_id = s.id = ?");
            */
            
            statement = connection.prepareStatement("select s.id, s.name, h.user_id, h.session_id from session s, host h where (h.session_id = s.id AND h.user_id = ?)");
            
            //statement.setInt(1, session);
            result = statement.executeQuery();    
            while (result.next()){
                //Create a new Session and add all data about the session to it
                Session s = new Session();
                s.setId(result.getInt("id"));
                s.setName(result.getString("name"));
                sessionList.add(s);
            }
        } catch(Exception e) {
            
        } finally {
            closeJDBC();
        }
        return sessionList;
    }    
    
    /**
     * Added by Chelsea Grindstaff
     * 18 March 2014
     * Adds # of attendees to attendee table
     */
    public void addAttendees(Session s) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("insert into attendees "
                    + "(session_id, local_attendees, remote_attendees) "
                    + "values (?, ?, ?)");
            statement.setInt(1, s.getId());
            statement.setInt(2, s.getLocalAttendees());
            statement.setInt(3, s.getRemoteAttendees());
            statement.execute();
            closeJDBC();
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
    }
    
    

    
    
}
