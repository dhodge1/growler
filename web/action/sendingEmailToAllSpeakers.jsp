<%-- 
    Document   : sendinEmailToAllSpeaker.jsp
                 This JSP takes email message content from the emailToAllSpeakers.jsp.
                 Then it instantiates a SpeakerPersistence object and uses the 
                 getUsersLikedASessionORSubmittedSurveys() method of that SpeakerPesistence
                 object to get an array list of all the Users objects. Then, this 
                 JSP concatenates all of the Speaker's email address into a long 
                 string called emailList. Lastly, it calls the sendmail()method
                 of the EmailUtilSMTPLocal class to perform the emailing task. 
                 ** Instead of dispatch the request, we returns the json object
    
    Resources  : Murach's Java Servlets and JSP 
                 www.codejava.net
                 **Resource on the json object - David Hodge 
                 
                 
    Created on : March 17, 2014, 6:08:21 PM
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
   
     //get info from the emailform.jsp     
   subject = request.getParameter("emailSubject");
   content = request.getParameter("emailContent");
   //get the email list from all the speakers
   SpeakerPersistence sPersistence = new SpeakerPersistence();
   ArrayList<Speaker> speakerArrayList = sPersistence.getAllSpeakersForEmailList();
   int arraySize = speakerArrayList.size();
   
   for (int i = 0; i < arraySize; i++)
   {  
     if((speakerArrayList.get(i).getEmail() != null) &&
        (speakerArrayList.get(i).getEmail().indexOf("@")!= -1))
     {
       emailList.append(speakerArrayList.get(i).getEmail());
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
     infoMessage =   "No speakers have valid email address info listed in the system.";
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
             