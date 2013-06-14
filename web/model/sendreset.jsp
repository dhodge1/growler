<%-- 
    Document   : sendreset
    Created on : Jun 6, 2013, 1:49:49 PM
    Author     : 162107
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.*"%>
<%@page import="com.scripps.growler.*" %>
<%@ page import="java.io.*,java.util.*, javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> 
<html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>Growler Project</title><!-- Title -->
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="draganddrop.css" /><!--Drag and drop style-->
        <script src="js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <%
        Connection connection = dataConnection.sendConnection();
        Statement statement = connection.createStatement();
        String user = request.getParameter("id");
        String email = request.getParameter("email");
        
        //ensure the person requesting the reset gave us the proper data
        ResultSet result = statement.executeQuery("select id, name, email from user where id = " + Integer.parseInt(user) + " and email = '" + email + "'");
        
        while (result.next()){
            if (result.getString("name") == null) {
                session.setAttribute("message", "Error: Invalid attributes");
                response.sendRedirect("../view/requestreset.jsp");
            }
        }

        //Make the temporary password a hash of the System Date
        statement.executeUpdate("update user set password = sha1(sysdate()) where id = " + Integer.parseInt(user));

        ResultSet result2 = statement.executeQuery("select id, name, password, email from user where id = " + Integer.parseInt(user));
        User u = new User();
        while (result2.next()) {
            u.setId(result2.getInt("id"));
            u.setUserName(result2.getString("name"));
            u.setPassword(result2.getString("password"));
            u.setEmail(result2.getString("email"));
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
 
		javax.mail.Session sess = javax.mail.Session.getInstance(props,
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
				InternetAddress.parse(u.getEmail()));
			message.setSubject("Your password has been reset");
			message.setText("Dear " + u.getUserName() + "," +
				"We have received a notification for your password reset.\n" +
                                "Please visit http://snitechtoberfest.elasticbeanstalk.com/view/resetpassword.jsp?id=" + u.getId() + "&email=" + u.getEmail() + " \n" +
                                "Your verification code is: " + u.getPassword() + " \n" +
                                "Thanks,\n\n Techtoberfest Admin Staff");
 
			Transport.send(message);
 
			results = "Done";
                        session.setAttribute("message", "Success: Email has been sent!");
 
		} catch (MessagingException e) {
                    results = "Failed " + e.getLocalizedMessage();
			
		}
                finally {
                    result.close();
                    result2.close();
                    statement.close();
                    connection.close();
                    response.sendRedirect("../index.jsp");
                }
    %>
</html>
