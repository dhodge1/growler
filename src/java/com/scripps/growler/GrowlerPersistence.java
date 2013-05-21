package com.scripps.growler;

import java.sql.*;

/**
 * Abstract class for all Persistence objects in the Growler project
 *
 * @since May 15, 2013
 * @author "Justin Bauguess"
 */
public abstract class GrowlerPersistence {

    /**
     * Reference to the DataConnection class
     */
    protected DataConnection data;
    /**
     * Connection for prepared statements
     */
    protected Connection connection;
    /**
     * Statement for using prepared statements
     */
    protected PreparedStatement statement;
    /**
     * Holds the results of the queries
     */
    protected ResultSet result;
    /**
     * Used for determining the success of certain queries
     */
    protected boolean success;

    /**
     * Establishes connection for the database using the DataConnection class
     */
    public void initializeJDBC() {
        try {
            data = new DataConnection();
            connection = data.sendConnection();
        } catch (Exception e) {
        }
    }

    /**
     * Closes all database resources: connection, statement, result set
     */
    public void closeJDBC() {
        try {
            connection.close();
            statement.close();
            result.close();
        } catch (Exception e) {
        }
    }
}
