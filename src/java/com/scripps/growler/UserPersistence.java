package com.scripps.growler;

import java.sql.*;
import java.util.*;

import org.apache.log4j.*;
/**
 * Handles database operations for the User class
 *
 * @see com.scripps.growler.User
 * @author "Justin Bauguess"
 */
public class UserPersistence extends GrowlerPersistence {

    static Logger logger = Logger.getLogger(UserPersistence.class);
    /**
     * An array list for each method to use
     */
    ArrayList<User> users = new ArrayList<User>();

    /**
     * Default constructor
     */
    public UserPersistence() {
    }

    public User getUserByID(int id) {
        try {
            logger.info("Connecting to Database");
            initializeJDBC();
            logger.info("Preparing Statement and loading Parameter");
            statement = connection.prepareStatement("select name, corporate_id, email from user where id = ?");
            statement.setInt(1, id);
            result = statement.executeQuery();
            logger.info("Processing ResultSet");
            if (result.next()) {
                User u = new User();
                u.setId(id);
                u.setUserName(result.getString("name"));
                closeJDBC();
                return u;
            }
            
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
        return null;
    }
    public User getUserByEmail(String email) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, corporate_id, email from user where email = ?");
            statement.setString(1, email);
            result = statement.executeQuery();
            if (result.next()) {
                User u = new User();
                u.setId(result.getInt("id"));
                u.setUserName(result.getString("name"));
                u.setCorporateId(result.getString("corporate_id"));
                closeJDBC();
                return u;
            }
            
        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
        return null;
    }

    /**
     * Gets a list of all users in the database
     *
     * @return The list of all users
     */
    public ArrayList<User> getAllUsers() {
        try {
            initializeJDBC();
            closeJDBC();

        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
        return null;
    }

    /**
     * Adds a user to the database
     *
     * @param user The user to add
     */
    public void addUser(User user) {
        try {
            initializeJDBC();
            closeJDBC();

        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
    }

    /**
     * Deletes a user from the database
     *
     * @param user The user to delete
     */
    public void deleteUser(User user) {
        try {
            initializeJDBC();
            closeJDBC();

        } catch (Exception e) {
        }
        finally {
            closeJDBC();
        }
    }
}