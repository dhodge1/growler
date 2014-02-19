<%-- 
    Document   : callOutAction
                 This JSP takes message content from the ??form. Then it
                 instantiates a UserPersistence object and uses the getAllUser()
                 method of that UserPesistence object to get an array list of 
                 all the Users objects. Then, this JSP concatenates all of the 
                 User's email address into a long string called emailList. 
                 Lastly, it calls the sendmail()method of the EmailUtilSMTPLocal
                 class to perform the emailing task. 
    
    Resources  : Murach's Java Servlets and JSP 
                 www.codejava.net
                 
                 
    Created on : Feb 18, 2014, 6:08:21 PM
    Author     : Thuy 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*, javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.scripps.growler.*, java.sql.*" %>
<%@ page import="javax.mail.MessagingException"%>

<%
   //set a default email list
   String emailList = new String("thuytohuynh@gmail.com");
   String from = new String();
   String subject = new String();
   String content = new String();
   boolean isContentHTML;
   //get the email list from all the users
   UserPersistence uPersistence = new UserPersistence();
   ArrayList<User> userArrayList = uPersistence.getAllUsers();
   for (int i = 0; i < userArrayList.size(); i++)
   {
      //this if stmt just for testing purposes
     if(!userArrayList.get(i).getEmail().equals("Lawrence.York@scrippsnetworks.com") &&
        !userArrayList.get(i).getEmail().equals("bboehmann@scrippsnetworks.com")&&
        !userArrayList.get(i).getEmail().equals("MMcIntyre@scrippsnetworks.com")&&
        !userArrayList.get(i).getEmail().equals(""))
     {
        emailList.concat(userArrayList.get(i).getEmail() + ", ");
     }    
   }
   //Just for testing will get the follow info from a html form instead
   from ="thuytohuynh@gmail.com";
   subject = "techtoberfest email testing";
   content = "123 Testing!!!";
   isContentHTML = false;
   //End testing code
   try
   {
      //perform the send email task
      EmailUtilSMTPLocal.sendMail(emailList, from, subject, content, isContentHTML);
       
   }
   
   catch (MessagingException e)
   {
     String results = "Failed " + e.getLocalizedMessage();    
   }
%> 
                      
                          