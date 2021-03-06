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
<%
        Connection connection = dataConnection.sendConnection();
        Statement statement = connection.createStatement();
        String email = request.getParameter("email");
        
        //ensure the person requesting the reset gave us the proper data
        ResultSet result = statement.executeQuery("select id, name, email from user where email = '" + email + "'");
        while (result.next()){
            if (result.getString("name") == null) {
                session.setAttribute("message", "Error: Invalid attributes");
                response.sendRedirect("../public/requestreset.jsp");
            }
        }
        //Make the temporary password a hash of the System Date
        statement.executeUpdate("update user set password = sha1(sysdate()) where email = '" + email + "'");
        ResultSet result2 = statement.executeQuery("select id, name, password, email from user where email = '" + email + "'");
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
		props.put("mail.smtp.host", host);
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
			message.setFrom(new InternetAddress(from));
			message.setRecipients(Message.RecipientType.TO,
				InternetAddress.parse(u.getEmail()));
			message.setSubject("Your password has been reset");
			message.setText("Dear " + u.getUserName() + ",\n\n" +
				"We have received a notification for your password reset.\n" +
                                "Please visit http://growler.elasticbeanstalk.com/view/resetpassword.jsp?id=" + u.getId() + "&email=" + u.getEmail() + " \n" +
                                "Your verification code is: " + u.getPassword() + " \n" +
                                "Thanks,\n\n Techtoberfest Admin Staff");
 
			Transport.send(message);
 
			results = "Done";
                        session.setAttribute("message", "Success: Password reset requested successfully! ");
 
		} catch (MessagingException e) {
                    results = "Failed " + e.getLocalizedMessage();
                    session.setAttribute("message", "Error: Email was not sent!");
			
		}
                finally {
                    result.close();
                    result2.close();
                    statement.close();
                    connection.close();
                    response.sendRedirect("../public/reset-confirmed.jsp");
                }
    %>