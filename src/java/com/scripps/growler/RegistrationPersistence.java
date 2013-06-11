/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.scripps.growler;

import java.util.ArrayList;

/**
 *
 * @author 162107
 */
public class RegistrationPersistence extends GrowlerPersistence {
    
    public void addRegistration(Registration r) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("insert into registration " +
                    "(user_id, session_id, curdate(), curtime(), reason) " +
                    "values (?, ?, ?)");
            statement.setInt(1, r.getUserId());
            statement.setInt(2, r.getSessionId());
            statement.setString(3, r.getReason());
            statement.execute();
        }
        catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
    }
    
    public void deleteRegistration(Registration r) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("delete from registration" + 
                    " where user_id = ? and session_id = ?");
            statement.setInt(1, r.getUserId());
            statement.setInt(2, r.getSessionId());
            statement.execute();
        }
        catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
    }
    
    public ArrayList<Registration> getRegistrationByUser(int user) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select * from registration " +
                    "where user_id = ?");
            statement.setInt(1, user);
            result = statement.executeQuery();
            ArrayList<Registration> registrations = new ArrayList<Registration>();
            while(result.next()) {
                Registration r = new Registration();
                r.setUserId(user);
                r.setSessionId(result.getInt("session"));
                r.setDateRegistered(result.getDate("date_registered"));
                r.setTimeRegistered(result.getTime("time_registered"));
                r.setReason(result.getString("reason"));
                registrations.add(r);
            }
            return registrations;
        }
        catch (Exception e) {
            
        }
        finally {
            closeJDBC();
        }
        return null;
    }
    
    public ArrayList<Registration> getRegistrationBySession (int session) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select * from registration " +
                    "where session_id = ?");
            statement.setInt(1, session);
            ArrayList<Registration> registrations = new ArrayList<Registration>();
            while(result.next()) {
                Registration r = new Registration();
                r.setUserId(result.getInt("user"));
                r.setSessionId(session);
                r.setDateRegistered(result.getDate("date_registered"));
                r.setTimeRegistered(result.getTime("time_registered"));
                r.setReason(result.getString("reason"));
                registrations.add(r);
            }
            return registrations;
        }
        catch (Exception e) {
            
        }
        finally {
            closeJDBC();
        }
        return null;
    }
    
}
