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
public class LocationPersistence extends GrowlerPersistence {
    
    /**
     * Adds a location to the database
     * @param l The location to add
     */
    public void addLocation(Location l) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("insert into location (id, description, building, capacity) values (?, ?, ?, ?)");
            statement.setString(1, l.getId());
            statement.setString(2, l.getDescription());
            statement.setString(3, l.getBuilding());
            statement.setInt(4, l.getCapacity());
            statement.execute();
        } catch (Exception e) {
            
        } finally {
            closeJDBC();
        }
    }
    
    public void assignRemoteRoom(String remoteRoomId, String localRoomId) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("insert into mapped_rooms (localID, remoteID) values (?, ?)");
            statement.setString(1, localRoomId);
            statement.setString(2, remoteRoomId);
            statement.execute();
        } catch (Exception e) {
            
        } finally {
            closeJDBC();
        }
    }
    
    public void deleteMappings(String localID) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("delete from mapped_rooms where localID = ?");
            statement.setString(1, localID);
            statement.execute();
        } catch (Exception e) {
            
        } finally {
            closeJDBC();
        }
    }
    
    
    
    public ArrayList<RemoteRoom> getRemoteRoomForLocation(String localID) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select remoteID from mapped_rooms where localID = ?");
            statement.setString(1, localID);
            result = statement.executeQuery();
            ArrayList<RemoteRoom> rrs = new ArrayList<RemoteRoom>();
            while (result.next()){
                RemoteRoom rr = new RemoteRoom();
                rr.setLocalID(localID);
                rr.setRemoteID(result.getString("remoteID"));
                rrs.add(rr);
            }
            closeJDBC();
            return rrs;
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
        return null;
    }

    /**
     * Deletes a location
     * @param l The location to delete
     */
    public void deleteLocation(Location l) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("delete from location where id = ?");
            statement.setString(1, l.getId());
            statement.execute();
        } catch (Exception e) {
            
        } finally {
            closeJDBC();
        }
    }

    /**
     * Updates location info
     * @param l The location to update
     */
    public void updateLocation(Location l) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("update location set description = ?, capacity = ?, building = ? where id = ?");
            statement.setString(4, l.getId());
            statement.setString(1, l.getDescription());
            statement.setInt(2, l.getCapacity());
            statement.setString(3, l.getBuilding());
            statement.execute();
        } catch (Exception e) {
            
        } finally {
            closeJDBC();
        }
    }

    /**
     * Returns a location object based on an ID
     * @param id The ID to search for
     * @return The location that matches the ID
     */
    public Location getLocationById(String id) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, description, capacity, building from location where id = ?");
            statement.setString(1, id);
            result = statement.executeQuery();
            Location location = new Location();
            while (result.next()){
                location.setId(result.getString("id"));
                location.setBuilding(result.getString("building"));
                location.setDescription(result.getString("description"));
                location.setCapacity(result.getInt("capacity"));
            }
            return location;
        } catch (Exception e) {
            
        } finally {
            closeJDBC();
        }
        return null;
    }
    
    /**
     * Gets a list of all locations
     * @return An ArrayList of all locations in the database
     */
    public ArrayList<Location> getAllLocations(String sort) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, description, capacity, building from location " + sort);
            result = statement.executeQuery();
            ArrayList<Location> list = new ArrayList<Location>();
            while (result.next()) {
                Location location = new Location();
                location.setId(result.getString("id"));
                location.setBuilding(result.getString("building"));
                location.setDescription(result.getString("description"));
                location.setCapacity(result.getInt("capacity"));
                list.add(location);
            }
            return list;
        } catch (Exception e) {
            
        } finally {
            closeJDBC();
        }
        return null;
    }
    
    public ArrayList<Session> getRoomAssignments(String location) {
        ArrayList<Session> sessions = new ArrayList<Session>();
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, session_date, start_time, duration from session where location = ? and extract(year from session_date) = 2013 ");
            statement.setString(1, location);
            result = statement.executeQuery();
            while (result.next()){
                Session session = new Session();
                session.setId(result.getInt("id"));
                session.setName(result.getString("name"));
                session.setSessionDate(result.getDate("session_date"));
                session.setStartTime(result.getTime("start_time"));
                session.setDuration(result.getTime("duration"));
                sessions.add(session);
            }
        } catch (Exception e) {
            
        } finally {
            closeJDBC();
        }
        return sessions;
    }
}
