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
            statement = connection.prepareStatement("insert into registration "
                    + "(user_id, session_id, curdate(), curtime(), reason) "
                    + "values (?, ?, ?)");
            statement.setInt(1, r.getUserId());
            statement.setInt(2, r.getSessionId());
            statement.setString(3, r.getReason());
            statement.execute();
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
    }

    public void deleteRegistration(Registration r) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("delete from registration"
                    + " where user_id = ? and session_id = ?");
            statement.setInt(1, r.getUserId());
            statement.setInt(2, r.getSessionId());
            statement.execute();
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
    }

    public boolean isUserRegistered(int user, int session) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select count(user_id) from registration "
                    + "where user_id = ? and session_id = ?");
            statement.setInt(1, user);
            statement.setInt(2, session);
            result = statement.executeQuery();
            while (result.next()){
                if (result.getInt(1) != 0) {
                    return true;
                }
            }
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return false;
    }

    public ArrayList<Registration> getRegistrationsByUser(int user) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select * from registration "
                    + "where user_id = ?");
            statement.setInt(1, user);
            result = statement.executeQuery();
            ArrayList<Registration> registrations = new ArrayList<Registration>();
            while (result.next()) {
                Registration r = new Registration();
                r.setUserId(user);
                r.setSessionId(result.getInt("session"));
                r.setDateRegistered(result.getDate("date_registered"));
                r.setTimeRegistered(result.getTime("time_registered"));
                r.setReason(result.getString("reason"));
                registrations.add(r);
            }
            return registrations;
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return null;
    }
    
    public int registrationCount(int session) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select count(*) from registration where session_id = ?");
            statement.setInt(1, session);
            return(result.getInt(1));
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return 0;
    }
    
    public ArrayList<Registration> getAllRegistrations() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select * from registration");
            ArrayList<Registration> registrations = new ArrayList<Registration>();
            while (result.next()) {
                Registration r = new Registration();
                r.setUserId(result.getInt("user_id"));
                r.setSessionId(result.getInt("session_id"));
                r.setDateRegistered(result.getDate("date_registered"));
                r.setTimeRegistered(result.getTime("time_registered"));
                registrations.add(r);
            }
            return registrations;
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return null;
    }

    public ArrayList<Registration> getRegistrationBySession(int session) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select * from registration "
                    + "where session_id = ?");
            statement.setInt(1, session);
            ArrayList<Registration> registrations = new ArrayList<Registration>();
            while (result.next()) {
                Registration r = new Registration();
                r.setUserId(result.getInt("user"));
                r.setSessionId(session);
                r.setDateRegistered(result.getDate("date_registered"));
                r.setTimeRegistered(result.getTime("time_registered"));
                r.setReason(result.getString("reason"));
                registrations.add(r);
            }
            return registrations;
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return null;
    }
}
