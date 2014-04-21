<%-- 
    Document   : emailSchedule
    Created on : Sep 23, 2013, 3:26:20 PM
    Author     : 162107
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
   String result;
   // Recipient's email ID needs to be mentioned.
   String to = (String)session.getAttribute("email");

   // Sender's email ID needs to be mentioned
   String from = "techtoberfest-help@gmail.com";

   // Assuming you are sending email from localhost
   String host = "smtp.gmail.com";

   // Get system properties object
   Properties properties = System.getProperties();

   // Setup mail server
   properties.setProperty("mail.smtp.host", host);

   // Get the default Session object.
   Session mailSession = Session.getDefaultInstance(properties);

   try{
      // Create a default MimeMessage object.
      MimeMessage message = new MimeMessage(mailSession);

      // Set From: header field of the header.
      message.setFrom(new InternetAddress(from));

      // Set To: header field of the header.
      message.addRecipient(Message.RecipientType.TO,
                               new InternetAddress(to));

      // Set Subject: header field
      message.setSubject("The 2014 Techtoberfest Schedule");

      // Create the message part 
      BodyPart messageBodyPart = new MimeBodyPart();

      // Fill the message
      messageBodyPart.setText("Here is the current Techtoberfest schedule.");
      
      // Create a multipar message
      Multipart multipart = new MimeMultipart();

      // Set text message part
      multipart.addBodyPart(messageBodyPart);

      // Part two is attachment
      messageBodyPart = new MimeBodyPart();
      String filename = "../public/Techtoberfest_Schedule2014.pdf";
      DataSource source = new FileDataSource(filename);
      messageBodyPart.setDataHandler(new DataHandler(source));
      messageBodyPart.setFileName(filename);
      multipart.addBodyPart(messageBodyPart);

      // Send the complete message parts
      message.setContent(multipart );

      // Send message
      Transport.send(message);
      String title = "Send Email";
      result = "Sent message successfully....";
   }catch (MessagingException mex) {
      mex.printStackTrace();
      result = "Error: unable to send message....";
   }
%>