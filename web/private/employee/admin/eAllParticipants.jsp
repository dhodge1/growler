<%-- 
    Document   : eAllParticipants
                 This JSP takes email message content from the emailToAllParticipants.jsp. Then it
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
  
   StringBuffer emailList = new StringBuffer();
   String subject = new String();
   String content = new String();
   boolean isContentHTML = false;
   
   String isSuccess = new String(); //for error checking purpose
   
     //get info from the emailform.jsp     
   subject = request.getParameter("emailSubject");
   content = request.getParameter("emailContent");
   //get the email list from all the users
   UserPersistence uPersistence = new UserPersistence();
   ArrayList<User> userArrayList = uPersistence.getAllUsersNoVolInfo();
   int arraySize = userArrayList.size();
   //*******************************************
   //The first 5 users on the list are real users
   //and we don't want to send tesing email to them
   //therefore we start the arraylist at index 5. 
   //NEED TO CHANGE THAT LATER TO 0****************
   //***********************************************
   for (int i = 5; i < arraySize; i++)
   {  
     if(userArrayList.get(i).getEmail() != null)  
     {
       emailList.append(userArrayList.get(i).getEmail());
       if(i < (arraySize-1))
       {
          emailList.append(", ");
       }       
     }    
   }
   
   try
   {
      //perform the send email task
      EmailUtilSMTPLocal.sendMail((emailList.toString()), subject, content, isContentHTML);
      isSuccess = "Your message has been sent!";
   }
   catch (Exception e)
   {
    // e.printStackTrace();
     isSuccess ="Your message can't be sending at this time";
   }
   
   finally 
   {
     request.setAttribute("isSuccess", isSuccess);
     RequestDispatcher dispatcher = request.getRequestDispatcher("emailToAllParticipants");      
     if (dispatcher != null)
     {
       dispatcher.forward(request, response);
     } 
   }
   //response.sendRedirect("../../../private/employee/home.jsp");
%>                      
    

