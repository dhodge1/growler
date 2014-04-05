package com.scripps.growler;

import java.util.*;
import java.sql.*;


public class AttendeePersistence extends GrowlerPersistence {
    
    /**
     * Sorts queries by name ascending
     */
    final String SORT_BY_NAME_ASC = " order by session.name asc";
    
    
    // An array list object for each method to use
    ArrayList<Attendees> attendees = new ArrayList<Attendees>();
    




    //Default Constructor 
    public AttendeePersistence() {
        }


    /**
     * Gets a list of all sessions in the database
     *
     * @param sort the criteria to sort the sessions
     * @return A list of sessions in the database, sorted
     */
    public ArrayList<Attendees> getAllSessions(String sort) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select * from session " + sort);
            result = statement.executeQuery();
            attendees = new ArrayList<Attendees>();
            while (result.next()) {
                //Create a new Session and add all data about the session to it
                Attendees a = new Attendees();
                a.setId(result.getInt("session_id"));
                a.setLocalAttendees(result.getInt("local_Attendees"));
                a.setRemoteAttendees(result.getInt("remote_Attendees"));

                //Add the session to the list
                attendees.add(a);
            }
            closeJDBC();
            return attendees;
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
        return attendees;
    }
    
    
    public ArrayList<Attendees> getLocalAttendeesById(String id) {
        ArrayList<Attendees> attendeeList = new ArrayList<Attendees>();
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select * from attendees where session_id = ?");
            statement.setString(1, id);
            result = statement.executeQuery();
            while (result.next()){
                Attendees s = new Attendees();
                s.setLocalAttendees(result.getInt("local_Attendees"));
                attendeeList.add(s);
            }
        } catch(Exception e){
            
        }finally  {
            closeJDBC();
        }
        return attendeeList;
    }    

   public ArrayList<Attendees> getRemoteAttendeesById(String id) {
        ArrayList<Attendees> attendeeList = new ArrayList<Attendees>();
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select * from attendees where session_id = ?");
            statement.setString(1, id);
            result = statement.executeQuery();
            while (result.next()){
                Attendees s = new Attendees();
                s.setRemoteAttendees(result.getInt("remote_Attendees"));
                attendeeList.add(s);
            }
        } catch(Exception e){
            
        }finally  {
            closeJDBC();
        }
        return attendeeList;
    }         
   

    public void addAttendees(int session, int localAttendees, int remoteAttendees) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("insert into attendees (session_id, local_attendees, remote_attendees) values (?, ?, ?)");
            statement.setInt(1, session);
            statement.setInt(2, localAttendees);
            statement.setInt(3, remoteAttendees);
            statement.execute();
            closeJDBC();
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
    }







}