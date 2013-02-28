/*
 * DataConnection.java
 * Author: Justin Baugess
 *
 */

package com.scripps.growler;

import java.sql.*;

public class DataConnection {
    private final String databaseName = "growler_db";
    private final String db_userName = "admin";
    private final String db_password = "password";

    private Connection connection;
    private ResultSet results;
    public DataConnection() throws SQLException, ClassNotFoundException {
       Class.forName("com.mysql.jdbc.Driver");
       connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + databaseName, db_userName, db_password); 
       
    }
    /**
     * Sends our JSP page a Connection object, so it can do fun things
     * 
     * Gets the MySQL Driver, then establishes a connection, then sends it
     * 
     * @return A connection object for our JSP page to use
     * @throws SQLException
     * @throws ClassNotFoundException 
     */
    public Connection sendConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        return (connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/growler_db", "admin", "password"));
    }    
    
    public int countRows() throws SQLException, ClassNotFoundException {
        new DataConnection();
        Statement counter = connection.createStatement();
        ResultSet results = counter.executeQuery("select name from theme");
        results.last();
        return(results.getRow() + 1);
    }
    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/growler_db", "admin", "password");
        Statement counter = connection.createStatement();
        ResultSet results = counter.executeQuery("select name from theme");
        results.last();
        System.out.println(results.getRow());
        
        }
}
