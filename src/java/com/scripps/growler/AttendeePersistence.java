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
     * */
    
    public ArrayList<Attendees> getAttendeesBySessionId(int sessionId) {
        ArrayList<Attendees> attendeeList = new ArrayList<Attendees>();
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select * from attendees where session_id = ?");
            result = statement.executeQuery();

            while (result.next()) {
                Attendees a = new Attendees();
                a.setLocalAttendees(result.getString("local_Attendees"));
                a.setRemoteAttendees(result.getString("remote_Attendees"));

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
    
    
   

    public void addAttendees(int session, String localAttendees, String remoteAttendees) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("insert into attendees (session_id, local_attendees, remote_attendees) values (?, ?, ?)");
            statement.setInt(1, session);
            statement.setString(2, localAttendees);
            statement.setString(3, remoteAttendees);
            statement.execute();
            closeJDBC();
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
    }

    public void editAttendees(String localAttendees, String remoteAttendees, int session) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("update attendees set"
                    + "local_attendees = ?, "
                    + "remote_attendees = ? "
                    + "where session_id = ?" );
            statement.setString(1, localAttendees);
            statement.setString(2, remoteAttendees);
            statement.setInt(3, session);
            statement.execute();
            closeJDBC();
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
    }
   
    
    /**
     * Gets a list of all sessions in the database, and if there are attendees entered, get them
     *
     * @return list
     */
    public ArrayList<Attendees> getAllSessions() {
        ArrayList<Attendees> attendeeList = new ArrayList<Attendees>();
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select s.id, s.name, b.local_Attendees, b.remote_Attendees from session s LEFT JOIN attendees b ON s.id = b.session_id");
            result = statement.executeQuery();

            while (result.next()) {
                Attendees a = new Attendees();
                a.setId(result.getInt("s.id"));
                a.setSessionName(result.getString("s.name"));
                a.setLocalAttendees(result.getString("b.local_Attendees"));
                a.setRemoteAttendees(result.getString("b.remote_Attendees"));
                

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




}