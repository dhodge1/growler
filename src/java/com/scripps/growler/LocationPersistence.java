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
            statement = connection.prepareStatement("insert into location (id, description) values (?, ?)");
            statement.setInt(1, l.getId());
            statement.setString(2, l.getDescription());
            statement.execute();
        } catch (Exception e) {
            
        } finally {
            closeJDBC();
        }
    }

    /**
     * Deletes a location
     * @param l The location to delete
     */
    public void deleteLocation(Location l) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("delete from location where id = ?");
            statement.setInt(1, l.getId());
            statement.execute();
        } catch (Exception e) {
            
        } finally {
            closeJDBC();
        }
    }

    /**
     * Updates a location's info
     * @param l The location to update
     */
    public void updateLocation(Location l) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("update location set description = ? where id = ?");
            statement.setInt(2, l.getId());
            statement.setString(1, l.getDescription());
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
    public Location getLocationById(int id) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, description from location where id = ?");
            statement.setInt(1, id);
            result = statement.executeQuery();
            Location location = new Location();
            while (result.next()){
                location = new Location(result.getInt("id"), result.getString("description"));
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
    public ArrayList<Location> getAllLocations() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, description from location");
            result = statement.executeQuery();
            ArrayList<Location> list = new ArrayList<Location>();
            while (result.next()) {
                Location location = new Location(result.getInt("id"), result.getString("description"));
                list.add(location);
            }
            return list;
        } catch (Exception e) {
            
        } finally {
            closeJDBC();
        }
        return null;
    }
}
