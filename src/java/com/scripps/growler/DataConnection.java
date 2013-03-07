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
    private final String DBNAME = "growler_db";
    private final String DBUSER = "admin";
    private final String DBPASS = "password";

    public Connection connection;
    private ResultSet results;
    public DataConnection() throws SQLException, ClassNotFoundException {
       Class.forName("com.mysql.jdbc.Driver");
       connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + DBNAME, DBUSER, DBPASS); 
       
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
    public int countSRows() throws SQLException, ClassNotFoundException {
        new DataConnection();
        Statement counter = connection.createStatement();
        ResultSet results = counter.executeQuery("select last_name from speaker");
        results.last();
        return(results.getRow() + 1);
    }
    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/growler_db", "admin", "password");
        Statement counter = connection.createStatement();
        ResultSet results = counter.executeQuery("select session_id, question1, question2, question3, question4 from survey_techtober_12");
        Statement insert = connection.createStatement();    
        ResultSet results2;
        while(results.next()) {
            
                insert.execute("insert into session_ranking (session_id, question_id, ranking) "
                        + "values (" + results.getInt("session_id") + ", 1, " + results.getInt("question1") + ")"); 
                System.out.println(results.getInt("session_id") +" " + results.getInt("question1"));
                insert.execute("insert into session_ranking (session_id, question_id, ranking) "
                        + "values (" + results.getInt("session_id") + ", 2, " + results.getInt("question2") + ")"); 
                System.out.println(results.getInt("session_id") +" " + results.getInt("question2"));
                insert.execute("insert into session_ranking (session_id, question_id, ranking) "
                        + "values (" + results.getInt("session_id") + ", 3, " + results.getInt("question3") + ")"); 
                System.out.println(results.getInt("session_id") +" " + results.getInt("question3"));
                insert.execute("insert into session_ranking (session_id, question_id, ranking) "
                        + "values (" + results.getInt("session_id") + ", 4, " + results.getInt("question4") + ")"); 
                System.out.println(results.getInt("session_id") + " " +  results.getInt("question4"));
            
        }
        }
}
