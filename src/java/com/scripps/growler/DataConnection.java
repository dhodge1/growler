/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.scripps.growler;

import java.sql.*;

/**
 *
 * @author "Justin Bauguess"
 */
public class DataConnection {
    private Connection connection;
    private ResultSet results;
    public DataConnection() throws SQLException, ClassNotFoundException {
       Class.forName("com.mysql.jdbc.Driver");
       connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/growler_db", "admin", "password"); 
       
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
    public int selectThemeCount() throws SQLException, ClassNotFoundException {
        new DataConnection();
        Statement statement = connection.createStatement();
        results = statement.executeQuery("select count(name) from theme");
        return(Integer.parseInt(results.getString("count(name)")));
    }
    public ResultSet selectThemes() throws SQLException, ClassNotFoundException {
        new DataConnection();
        Statement statement = connection.createStatement();
        results = statement.executeQuery("select name from theme");
        return(results);
        
        
    }    
    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/growler_db", "admin", "password");
        Statement statement = connection.createStatement();
        ResultSet result = statement.executeQuery("select name from theme");
        while (result.next()){
            System.out.println(result.getString("name"));
        }
        
    }
}
