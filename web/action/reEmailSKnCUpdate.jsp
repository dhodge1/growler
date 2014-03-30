<%-- 
    Document   : reEmailSKnCUpdate
    Created on : Mar 30, 2014, 2:03:38 AM
    Author     : Thuy
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*, javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.scripps.growler.*, java.sql.*" %>



<%
//StringBuffer speakerIList = new StringBuffer();
//StringBuffer speakerVList = new StringBuffer();
String subject = new String();
String content = new String();
boolean isContentHTML = false;
int validEmailNum = 0;
int invalidEmailNum = 0;
   
String infoMessage = new String();//for email sending status info message
String isSuccess = new String(); //for error checking purpose
   

String[] strRecords = request.getParameter("hiddenString").split(";");
for(int i=0; i<strRecords.length; i++)
{
   String[] eachRec = strRecords[i].split(",");
   String strSpeakerId = eachRec[0];
   String strLastName = eachRec[1];
   String strFirstName = eachRec[2];
   String strSessionName = eachRec[3];
   String strSessionKey = eachRec[4];
   String strSpeakerEmail = request.getParameter(eachRec[0]);
   
   //update the valid email address to the speaker table
   SpeakerPersistence sp = new SpeakerPersistence();
   sp.updateEmailBySpeakerId(Integer.parseInt(strSpeakerId), strSpeakerEmail);
   
   subject = "The " + strSessionName + " Session Key";
   content = "Dear " + strLastName + " " + strFirstName + ", \n\n"
	      + "Here is the session key for your presentation, "
	      + strSessionName +": "+ strSessionKey + ". \n\n"
	      + "Please give this only to the people in your room, "
              + "and only during your scheduled session. \n\n"
	      + "Thanks\n"
	      + "Techtoberfest Adminstration\n";	 
	//*************************************************************************				 
   try
   {
       //perform the send email task
        EmailUtilSMTPScripps.sendMail(strSpeakerEmail, subject, content, isContentHTML);
					   
       //infoMessage = "Your message has been sent!";
       //isSuccess =   "true";
       //request.setAttribute("isSuccess", isSuccess);
	   	   
   }
   catch (Exception e)
   {
       infoMessage ="Your message can't be sent at this time";
       request.setAttribute("infoMessage", infoMessage); 
	   
       RequestDispatcher dispatcher = request.getRequestDispatcher("sessionKeyEmail-confirm");      
       if (dispatcher != null)
       {
         dispatcher.forward(request, response);
       } 
   } //End of catch
   validEmailNum= validEmailNum + 1;
}    

  
  
  
  
  
  
   				   
								
   
   %>
