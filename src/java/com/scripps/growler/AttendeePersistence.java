package com.scripps.growler;

import java.sql.SQLException;
import java.util.*;


public class AttendeePersistence extends GrowlerPersistence {
    

    private ArrayList<Attendees> attendeesList = new ArrayList<Attendees>();
    




    //Default Constructor 
    public AttendeePersistence() {
        }


    /**
     * Gets a list of all sessions in the database
     *
     * @param sessionId
     * @return A list of sessions in the database
     * */
    
    public Attendees getAttendeesBySessionId(int sessionId) {
        //ArrayList<Attendees> attendeeList = new ArrayList<Attendees>();
            try {
            initializeJDBC();
            statement = connection.prepareStatement("select local_Attendees, remote_Attendees from attendees where session_id = ?");
            statement.setInt(1, sessionId);
            result = statement.executeQuery();


            Attendees a = new Attendees();
            if (result.next()) {
                a.setLocalAttendees(result.getInt("local_Attendees"));
                a.setRemoteAttendees(result.getInt("remote_Attendees"));

            }
            closeJDBC();
            return (a);
        } catch (SQLException e) {
        }
        finally {
            closeJDBC();
        }
        return null;
    }
    
    
 

    public void addAttendees(int session, int localAttendees, int remoteAttendees) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("insert into attendees (session_id, local_Attendees, remote_Attendees) values (?, ?, ?)");
            statement.setInt(1, session);
            statement.setInt(2, localAttendees);
            statement.setInt(3, remoteAttendees);
            statement.execute();
            closeJDBC();
        } catch (SQLException e) {
        }
        finally {
            closeJDBC();
        }
    }

    public void editAttendees(int localAttendees, int remoteAttendees, int session) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("UPDATE attendees SET local_Attendees = '"
                                                  +  localAttendees   
                                                  + "', remote_Attendees = '"
                                                  + remoteAttendees
                                                  + "'WHERE session_id = '"
                                                  + session + "'");
            statement.execute();
            closeJDBC();
        } catch (SQLException e) {
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
                a.setLocalAttendees(result.getInt("b.local_Attendees"));
                a.setRemoteAttendees(result.getInt("b.remote_Attendees"));
                

                //Add the session to the list
                attendeeList.add(a);
            }
            closeJDBC();
            return attendeeList;
        } catch (SQLException e) {
        }
        finally {
            closeJDBC();
        }
        return attendeeList;
    }




}