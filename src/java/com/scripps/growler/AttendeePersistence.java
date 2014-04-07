package com.scripps.growler;

import java.util.*;


public class AttendeePersistence extends GrowlerPersistence {
    

    private ArrayList<Attendees> attendeesList = new ArrayList<Attendees>();
    




    //Default Constructor 
    public AttendeePersistence() {
        }


    /**
     * Gets a list of all sessions in the database
     *
     * @return A list of sessions in the database
     */
    public ArrayList<Attendees> getAllSessions() {
        ArrayList<Attendees> attendeeList = new ArrayList<Attendees>();
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select * from attendees ");
            result = statement.executeQuery();

            while (result.next()) {
                Attendees a = new Attendees();
                a.setId(result.getInt("session_id"));
                a.setLocalAttendees(result.getInt("local_Attendees"));
                a.setRemoteAttendees(result.getInt("remote_Attendees"));

                //Add the session to the list
                attendeeList.add(a);
            }
            closeJDBC();
            return attendeeList;
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
        return attendeeList;
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