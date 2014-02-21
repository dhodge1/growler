<%-- 
    Document   : callOutAction
                 This JSP takes email message content from the ??form. Then it
                 instantiates a UserPersistence object and uses the getAllUserNoVolInfo()
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
  // set a default email list
   StringBuffer emailList = new StringBuffer("ttto@pstcc.edu");
   String from = new String();
   String subject = new String();
   String content = new String();
   boolean isContentHTML;
   //get the email list from all the users
  UserPersistence uPersistence = new UserPersistence();
   ArrayList<User> userArrayList = uPersistence.getAllUsersNoVolInfo();
   //*******************************************
   //The first 5 users on the list are real users
   //and we don't want to send tesing email to them
   //therefore we start the arraylist at index 5. 
   //NEED TO CHANGE THAT LATER TO 0****************
   //***********************************************
   for (int i = 5; i < userArrayList.size(); i++)
   {  
     if(userArrayList.get(i).getEmail() != null)  
     {
       emailList.append(", ");
       emailList.append(userArrayList.get(i).getEmail());
     }    
   }
   //Just for testing will get the follow info from a html form instead
   from ="scrippsproject2014@gmail.com";
   subject = "techtoberfest email testing";
   content = " 123 Testing!!!";
   isContentHTML = false;
   //End testing code
   try
   {
      //perform the send email task
      EmailUtilSMTPLocal.sendMail((emailList.toString()), from, subject, content, isContentHTML);
   }
   catch (Exception e)
   {
    // e.printStackTrace();   
   }

%>                      
    




            