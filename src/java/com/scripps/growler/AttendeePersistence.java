package com.scripps.growler;

import java.util.*;
import java.sql.*;


public class AttendeePersistence extends GrowlerPersistence {
    
    // An array list object for each method to use
    ArrayList<Attendees> attendees = new ArrayList<Attendees>();
    




//Default Constructor 
public AttendeePersistence() {
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
   }