package com.scripps.growler;

import java.sql.*;
import java.util.*;

/**
 * Handles database operations for the User class
 *
 * @see com.scripps.growler.User
 * @author "Justin Bauguess"
 */
public class UserPersistence extends GrowlerPersistence {

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
            initializeJDBC();
            statement = connection.prepareStatement("select name, corporate_id, email from user where id = ?");
            statement.setInt(1, id);
            result = statement.executeQuery();
            if (result.next()) {
                User u = new User();
                u.setId(id);
                u.setUserName(result.getString("name"));
                closeJDBC();
                return u;
            }
            closeJDBC();
        } catch (Exception e) {
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
    }
}