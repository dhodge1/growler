/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.scripps.growler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

/**
 *
 * @author 162107
 */
public class RegistrationPersistence extends GrowlerPersistence {

    public void addRegistration(Registration r) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("insert into registration "
                    + "(user_id, session_id, date_registered, time_registered) "
                    + "values (?, ?, curdate(), curtime())");
            statement.setInt(1, r.getUserId());
            statement.setInt(2, r.getSessionId());
            statement.execute();
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
    }

    public void deleteRegistration(Registration r) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("delete from registration where user_id = ? and session_id = ?");
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
    
    public ArrayList<Attendance> getRegisteredWhoAttended() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select a.user_id, a.session_id, r.date_registered, a.surveySubmitTime from attendance a, registration r where r.session_id = a.session_id and r.user_id = a.user_id");
            result = statement.executeQuery();
            ArrayList<Attendance> list = new ArrayList<Attendance>();
            while (result.next()) {
                Attendance a = new Attendance();
                a.setSessionId(result.getInt("session_id"));
                a.setUserId(result.getInt("user_id"));
                a.setSurveySubmitTime(result.getTimestamp("surveySubmitTime"));
                a.setDateRegistered(result.getDate("date_registered"));
                list.add(a);
            }
            return list;
        }
        catch (Exception e) {
            
        }
        finally {
            closeJDBC();
        }
        return null;
    }
    
    public ArrayList<Attendance> getAttendedWhoDidNotRegister() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select distinct a.user_id, a.session_id, a.surveySubmitTime from attendance a where (a.user_id, a.session_id) not in (select user_id, session_id from registration)");
            result = statement.executeQuery();
            ArrayList<Attendance> list = new ArrayList<Attendance>();
            while (result.next()) {
                Attendance a = new Attendance();
                a.setSessionId(result.getInt("session_id"));
                a.setUserId(result.getInt("user_id"));
                a.setSurveySubmitTime(result.getTimestamp("surveySubmitTime"));
                list.add(a);
            }
            return list;
        }
        catch (Exception e) {
            
        }
        finally {
            closeJDBC();
        }
        return null;
    }
    
    public ArrayList<Attendance> getRegisteredWhoDidNotAttend() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select distinct r.user_id, r.session_id, r.date_registered from registration r where (r.user_id, r.session_id) not in (select user_id, session_id from attendance)");
            result = statement.executeQuery();
            ArrayList<Attendance> list = new ArrayList<Attendance>();
            while (result.next()) {
                Attendance a = new Attendance();
                a.setSessionId(result.getInt("session_id"));
                a.setUserId(result.getInt("user_id"));
                a.setDateRegistered(result.getDate("date_registered"));
                list.add(a);
            }
            return list;
        }
        catch (Exception e) {
            
        }
        finally {
            closeJDBC();
        }
        return null;
    }
    
    public boolean isUserRegisteredForSession(int session, int user) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select count(user_id) from registration where user_id = ? and session_id = ?");
            statement.setInt(1, user);
            statement.setInt(2, session);
            result = statement.executeQuery();
            while (result.next()){
                if (result.getInt(1) == 0) {
                    return false;
                }
                else {
                    return true;
                }
            }
        } catch(Exception e) {
            
        } finally {
            closeJDBC();
        }
        return false;
    }
}
