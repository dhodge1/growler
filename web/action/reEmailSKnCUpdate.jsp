<%-- 
    Document   : reEmailSKnCUpdate
                 Updates speakers new email contact info to the speaker table of
                 the Growler DB. Then resend the session key emails to those
                 speakers.
    Created on : Mar 30, 2014, 2:03:38 AM
    Author     : Thuy
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*, javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.scripps.growler.*, java.sql.*" %>


<%
//**************************SCRIPTLET TAG STARTS HERE**************************    
    
String subject = new String(); //email subject
String content = new String(); //email content
boolean isContentHTML = false; 

   
String infoMessage = new String();//for email sending status info message
String notSuccess = new String(); //for error checking purpose
   
//*****************************************************************************
//** --The hiddenString parameter holds the long string that contains all of **
//** the speakers and their session key info that need to update the new     **
//** email address to the Growler's speaker table. Each record is separate   **
//** by ';'.                                                                 **
//** --The strRecords array holds string of speakers records and its fields  **
//** are separated by ','                                                    **
//** --The eachRec array hold fields of each speaker info record             **
//*****************************************************************************

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
   //**************************************************************************
   //** For each speaker record, update its new email address info to the speaker 
   //** table of the Growler DB (by speaker id)
   //**************************************************************************
   SpeakerPersistence sp = new SpeakerPersistence();
   sp.updateEmailBySpeakerId(Integer.parseInt(strSpeakerId), strSpeakerEmail);
   //************************************************************
   //** Based on the above information of each speaker record, **
   //** hard coded each speaker email content.                 **
   //************************************************************
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
   }
   catch (Exception e)
   {
       infoMessage ="Your message can't be sent at this time";
       notSuccess =   "true";
       request.setAttribute("isSuccess", notSuccess);	
       request.setAttribute("infoMessage", infoMessage);
       RequestDispatcher dispatcher = request.getRequestDispatcher("sessionKeyEmail-confirm");      
       if (dispatcher != null)
       {
         dispatcher.forward(request, response);
       } 
   } //End of catch
}
//*************************************************
//** successfully re-send all session key emails **
//*************************************************
infoMessage = "Your message has been sent!";
request.setAttribute("infoMessage", infoMessage); 
RequestDispatcher dispatcher = request.getRequestDispatcher("sessionKeyEmail-confirm");      
if (dispatcher != null)
{
  dispatcher.forward(request, response);
} 
  								
//**************************JSP SCRIPTLET TAG ENDS HERE************************  
%>