<%-- 
    Document   : sendinEmailToAllSpeaker.jsp
                 
    
    Resources  : Murach's Java Servlets and JSP 
                 www.codejava.net
                 
                 
    Created on : March 17, 2014, 6:08:21 PM
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
   
   String infoMessage = new String();//for email sending status info message
   String isSuccess = new String(); //for error checking purpose
   
     //get info from the emailform.jsp     
   subject = request.getParameter("emailSubject");
   content = request.getParameter("emailContent");
   //get the email list from all the users
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
     infoMessage =   "No presenters have valid email address info listed in the system.";
     request.setAttribute("infoMessage", infoMessage);
     RequestDispatcher dispatcher = request.getRequestDispatcher("emailToAllSpeakers");      
     if (dispatcher != null)
     {
       dispatcher.forward(request, response);
     } 
   }
   else
   {    
     try
     {
       //perform the send email task
       EmailUtilSMTPScripps.sendMail((emailList.toString()), subject, content, isContentHTML);
       infoMessage = "Your message has been sent!";
       isSuccess =   "true";
       request.setAttribute("isSuccess", isSuccess);
     }
     catch (Exception e)
     {
       infoMessage ="Your message can't be sending at this time";
     }
   
     finally 
     {
       request.setAttribute("infoMessage", infoMessage); 
       RequestDispatcher dispatcher = request.getRequestDispatcher("emailToAllSpeakers");      
       if (dispatcher != null)
       {
         dispatcher.forward(request, response);
       } 
     }
   } 
%>                      
             