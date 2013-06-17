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
    int userId = (Integer)session.getAttribute("id");
    String sessionId = request.getParameter("session");
    String pageReturn = (String)session.getAttribute("page");
    session.removeAttribute("page");
    DataConnection data = new DataConnection();
    Connection connection = data.sendConnection();
    Statement statement = connection.createStatement();
    ResultSet eresult = statement.executeQuery("select email, name from user where id = " + userId);
    StringBuilder to_line = new StringBuilder();
    String name = new String();
    while (eresult.next()) {
        //Add the emails to a list
        name = eresult.getString("name");
        to_line.append(eresult.getString("email"));
        //if it's not the last email, add a comma
        if (eresult.next()) {
            to_line.append(", ");
        }
    }

    eresult = statement.executeQuery("select id, name from session where id = " + sessionId);
    String sess_name = new String();
    while (eresult.next()) {
        sess_name = eresult.getString("name");
    }
    // Sender's email ID needs to be mentioned
    String from = "techtoberfesthelp@gmail.com";

    // Assuming you are sending email from localhost
    String host = "smtp.gmail.com";

    // Get system properties object
    final String username = "techtoberfesthelp@gmail.com";
		final String password = "emailtest";
 
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
 
		Session sess = Session.getInstance(props,
		  new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		  });
 
                String results = "";
		try {
 
			Message message = new MimeMessage(sess);
			message.setFrom(new InternetAddress(username));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse(to_line.toString()));
			message.setSubject("Please Take a Survey");
			message.setText("Dear " + name + ","
				+ "\n\n Please take a survey for the following session:  " + sess_name +
                                "\n\nYour input will help us improve " +
                                "Techtoberfest in the future, and will enter you for a drawing to win" +
                                " a fantasic prize.  Sessions can be taken by logging into the website and " +
                                " going to the \"Rate a Session\" link in the navigation bar.\n\n" +
                                "You are not obligated to take a survey.\n\n" +
                                "Thanks,\n\n Techtoberfest Admin Staff");
 
			Transport.send(message);
 
			results = "Done";
 
		} catch (MessagingException e) {
                    results = "Failed " + e.getLocalizedMessage();
			
		}
                response.sendRedirect(pageReturn);
%>
<html>
    <head>
        <title>Send Email using JSP</title>
    </head>
</html>