<%-- 
    Document   : callOutAction
                 This JSP takes email message content from the emailForm.jsp. Then it
                 instantiates a UserPersistence object and uses the getAllUserNoVolInfo()
                 method of that UserPesistence object to get an array list of 
                 all the Users objects. Then, this JSP concatenates all of the 
                 User's email address into a long string called emailList. 
                 Lastly, it calls the sendmail()method of the EmailUtilSMTPLocal
                 class to perform the emailing task. 
                 **This page is an action jsp of the emailForm.jsp and both are
                   located in admin folder.

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
<%@page import="com.google.gson.Gson" %>

 <%
  
   StringBuffer emailList = new StringBuffer();
   String subject = new String();
   String content = new String();
   boolean isContentHTML = false;
   
   String infoMessage = new String();//for email sending status info message
   boolean lclSuccess;
   String jsonStr = new String();
   Feedback emailFeedback; 
   Gson gson = new Gson();
   
         
   subject = request.getParameter("emailSubject");
   content = request.getParameter("emailContent");
   
   //get the email list from all the users
   UserPersistence uPersistence = new UserPersistence();
   ArrayList<User> userArrayList = uPersistence.getAllUsersNoVolInfo();
   int arraySize = userArrayList.size();
   
   for (int i = 0; i < arraySize; i++)
   {  
     if((userArrayList.get(i).getEmail() != null) &&
        (userArrayList.get(i).getEmail().indexOf("@")!= -1))
     {
       emailList.append(userArrayList.get(i).getEmail());
       if(i < (arraySize-1))
       {
          emailList.append(", ");
       }       
     }    
   } //END for loop
   
   //*******************************************************
   //error checking for no valid email listed in the system
   //*******************************************************
   if(emailList.length()==0)
   {
     infoMessage =   "No participants have valid email address info listed in the system.";
     //*************************************************************************
     //calls Feedback 1 arg-constructor because the success field set to false 
     //by default. Therefore we don't need to call the 2arg constructor.
     //*************************************************************************
     emailFeedback= new Feedback(infoMessage);
     //calls the Ajax function
     jsonStr = gson.toJson(emailFeedback);
     //send the json object back to the browser
     out.print(jsonStr);
   }
   else
   {    
     try
     {
       //perform the send email task
       EmailUtilSMTPScripps.sendMail((emailList.toString()), subject, content, isContentHTML);
       //**********************************************************
       //** instantiates the Feedback object type 
       //**********************************************************
       infoMessage = "Your message has been sent!";
       lclSuccess = true;
       //since the lclSuccess  is true therefore we need to call the 2-arg constructor
       emailFeedback= new Feedback(infoMessage, lclSuccess);
       //turns the Feedback object type to the json object
       jsonStr = gson.toJson(emailFeedback);
       //send the json object back to the browser
       out.print(jsonStr);
       
     }
     catch (Exception e)
     {
       infoMessage ="Your message can't be sent at this time";
       emailFeedback= new Feedback(infoMessage);
       //calls the Ajax function
       jsonStr = gson.toJson(emailFeedback);
       //send the json object back to the browser
       out.print(jsonStr);
     }
   } 
%>                      
             