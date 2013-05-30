<%-- 
    Document   : emailer
    Created on : May 30, 2013, 8:12:09 AM
    Author     : 162107
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*, javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.scripps.growler.DataConnection, java.sql.*" %>
<%
    String result;
    DataConnection data = new DataConnection();
    Connection connection = data.sendConnection();
    Statement statement = connection.createStatement();
    ResultSet eresult = statement.executeQuery("select email, name from user where id = 4");
    StringBuilder to_line = new StringBuilder();
    while (eresult.next()) {
        //Add the emails to a list
        to_line.append(eresult.getString("email"));
        //if it's not the last email, add a comma
        if (eresult.next()) {
            to_line.append(", ");
        }
    }

    // Sender's email ID needs to be mentioned
    String from = "jmbauguess@gmail.com";

    // Assuming you are sending email from localhost
    String host = "127.0.0.1";

    // Get system properties object
    Properties properties = System.getProperties();

    // Setup mail server
    properties.setProperty("mail.host", host);
    properties.setProperty("mail.transport.protocol", "smtp");

    // Get the default Session object.      
    Session mailSession = Session.getDefaultInstance(properties);

    try {
        // Create a default MimeMessage object.
        MimeMessage message = new MimeMessage(mailSession);
        // Set From: header field of the header.
        message.setFrom(new InternetAddress(from));
        // Set To: header field of the header.
        message.addRecipient(Message.RecipientType.TO,
                new InternetAddress("jbauguess@scrippsnetworks.com"));
        // Set Subject: header field
        message.setSubject("Techtoberfest News");
        // Now set the actual message
        message.setText("You registered for a session.  Please fill out a survey!");
        // Send message
        Transport.send(message);
        result = "Sent message successfully....";
    } catch (MessagingException mex) {
        mex.printStackTrace();
        result = "Error: unable to send message...." + "<br/>" + mex.getMessage();
    }
%>
<html>
    <head>
        <title>Send Email using JSP</title>
    </head>
    <body>
    <center>
        <h1>Send Email using JSP</h1>
    </center>
    <p align="center">
        <%
            out.println("Result: " + result + "\n");
        %>
    </p>
</body>
</html>