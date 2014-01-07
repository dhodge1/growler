/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.scripps.growler;

import java.sql.*;

import org.apache.log4j.*;

/**
 *
 * @author "Justin Bauguess"
 */
public class DataConnection {

    static Logger logger = Logger.getLogger(DataConnection.class);
    private final String DBNAME = "growler_db";
    private final String DBUSER = "root";
    private final String PRODUSER = "admin";
    private final String PRODPASS = "gr0wlerz";
    private final String DBPASS = "password";
    private final String LOCAL = "localhost";
    private final String AMAZON = "aa1kghi1e8rhlu6.cllctpcw9g9x.us-east-1.rds.amazonaws.com";
    private final String PRODUCTION = "aa1gc4mp7cif9f.c1cdygckt6aw.us-east-1.rds.amazonaws.com";
    private final String PROD2 = "aakrmqeutbcxty.cabe2rveogll.us-east-1.rds.amazonaws.com";
    String dbName = System.getProperty("RDS_DB_NAME");
    String userName = System.getProperty("RDS_USERNAME");
    String password = System.getProperty("RDS_PASSWORD");
    String hostname = System.getProperty("RDS_HOSTNAME");
    String port = System.getProperty("RDS_PORT");
    String jdbcUrl = "jdbc:mysql://" + System.getProperty("RDS_HOSTNAME") + ":" + port + "/" + dbName + "?user=" + userName + "&password=" + password;
    public Connection connection;

    public DataConnection() throws SQLException, ClassNotFoundException {
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
        logger.info("Getting the Driver, then Returning a connection using the class constants of DBNAME, DBUSER, DBPASSWORD");
        Class.forName("com.mysql.jdbc.Driver");
        return (connection = DriverManager.getConnection("jdbc:mysql://" + System.getProperty("RDS_HOSTNAME") + ":3306/" + DBNAME, PRODUSER, PRODPASS));
    }

    public String bytesToHex(byte[] b) {
        char hexDigit[] = {'0', '1', '2', '3', '4', '5', '6', '7',
            '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
        StringBuffer buf = new StringBuffer();
        for (int j = 0; j < b.length; j++) {
            buf.append(hexDigit[(b[j] >> 4) & 0x0f]);
            buf.append(hexDigit[b[j] & 0x0f]);
        }
        return buf.toString();
    }

    public void split2012Ranks() throws SQLException, ClassNotFoundException {
        Connection connection = DriverManager.getConnection("jdbc:mysql://ps11.pstcc.edu:3306/c2850a01test", "c2850a01", "c2850a01");
        Statement counter = connection.createStatement();
        ResultSet results = counter.executeQuery("select session_id, question1, question2, question3, question4 from survey_techtober_12");
        Statement insert = connection.createStatement();
        while (results.next()) {

            insert.execute("insert into session_ranking (session_id, question_id, ranking) "
                    + "values (" + results.getInt("session_id") + ", 1, " + results.getInt("question1") + ")");
            System.out.println(results.getInt("session_id") + " " + results.getInt("question1"));
            insert.execute("insert into session_ranking (session_id, question_id, ranking) "
                    + "values (" + results.getInt("session_id") + ", 2, " + results.getInt("question2") + ")");
            System.out.println(results.getInt("session_id") + " " + results.getInt("question2"));
            insert.execute("insert into session_ranking (session_id, question_id, ranking) "
                    + "values (" + results.getInt("session_id") + ", 3, " + results.getInt("question3") + ")");
            System.out.println(results.getInt("session_id") + " " + results.getInt("question3"));
            insert.execute("insert into session_ranking (session_id, question_id, ranking) "
                    + "values (" + results.getInt("session_id") + ", 4, " + results.getInt("question4") + ")");
            System.out.println(results.getInt("session_id") + " " + results.getInt("question4"));
        }
        connection.close();
        counter.close();
        results.close();
        insert.close();

    }

    public void add2012RanksTable() throws SQLException, ClassNotFoundException {
        connection = sendConnection();
        Statement create = connection.createStatement();
        create.executeUpdate("create table ranks_2012 as (select avg(r.ranking) as rating, s.id from session_ranking r, speaker s, speaker_team t where t.session_id = r.session_id and t.speaker_id = s.id group by s.id)");

        create.close();
        connection.close();
    }
}
