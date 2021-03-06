
<%-- 
    Document   : eSessionliked
                 This JSP takes email message content and selected session from 
                 the emailFormOfParticipants.jsp. Then it
                 instantiates a UserPersistence object and uses the getUserLikedASession()
                 method of that UserPesistence object to get an array list of 
                 the Users objects. This array list only contain a group of 
                 users that liked the selected session. Then, this JSP 
                 concatenates all of these User's email address into a long
                 string called emailList. Lastly, it calls the sendmail()method
                 of the EmailUtilSMTPLocal class to perform the emailing task. 
    
    Resources   : A modifcation version of the callOutAction.jsp 
                  (Murach's Java Servlets and JSP www.codejava.net)
                 
                 
    Created on : March 02, 2014, 7:05:21 PM
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
   String thuyStr = new String();
   boolean isContentHTML = false;
  int selectedSession;
   
   String infoMessage = new String();//for email sending status info message
   boolean lclSuccess;
   String jsonStr = new String();
   Feedback emailFeedback; 
   Gson gson = new Gson();
    
     //get info from the emailform.jsp 
   thuyStr = request.getParameter("sessionNum");
   subject = request.getParameter("emailSubject");
   content = request.getParameter("emailContent");
   
   selectedSession = Integer.parseInt(thuyStr);


   //get the email list from all the users
   UserPersistence uPersistence = new UserPersistence();
   ArrayList<User> userArrayList = uPersistence.getUsersLikedASession(selectedSession);
   int arraySize = userArrayList.size();
   //*******************************************
   //The first 5 users on the list are real users
   //and we don't want to send tesing email to them
   //therefore we start the arraylist at index 5. 
   //NEED TO CHANGE THAT LATER TO 0****************
   //***********************************************
    

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
   }

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