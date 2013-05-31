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

    public void updateLocation(Location l) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("update location description = ? where id = ?");
            statement.setInt(2, l.getId());
            statement.setString(1, l.getDescription());
            statement.execute();
        } catch (Exception e) {
            
        } finally {
            closeJDBC();
        }
    }

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
