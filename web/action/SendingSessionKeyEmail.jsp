//Thuy To
//03/21/14
//Email session key to presenters


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*, javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.scripps.growler.*, java.sql.*" %>
<%
StringBuffer speakerIList = new StringBuffer();
StringBuffer speakerVList = new StringBuffer();
String subject = new String();
String content = new String();
boolean isContentHTML = false;
int validEmailNum = 0;
int invalidEmailNum = 0;
   
String infoMessage = new String();//for email sending status info message
String isSuccess = new String(); //for error checking purpose
   
DataConnection data = new DataConnection();
Connection connection = data.sendConnection();
Statement statement = connection.createStatement();
ResultSet speakerRS = statement.executeQuery("SELECT s.id, s.name, s.session_key, " 
                                           + "k.speaker_id, r.first_name, r.last_name, r.email "
	                                   + "FROM session s, speaker_team k, speaker r "
					   + "WHERE s.id = k.session_id "
                                           + "AND r.id = k.speaker_id "
                                           + "AND EXTRACT(YEAR FROM s.session_date)='2014'");
											 
while(speakerRS.next())
{ 
  String strSessionId = speakerRS.getString("id");
  String strSessionName = speakerRS.getString("name");
  String strSessionKey = speakerRS.getString("session_key");
  String strSpeakerId = speakerRS.getString("speaker_id");
  String strFirstName = speakerRS.getString("first_name");
  String strLastName = speakerRS.getString("last_name");
  String strSpeakerEmail = speakerRS.getString("email");
  
  
  if((strSpeakerEmail!= null) &&
     (strSpeakerEmail.indexOf("@")!= -1))
  {
    subject = "The " + strSessionName + " Session Key";
	content = "Dear " + strFirstName + " " + strLastName + ", \n\n"
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
	   speakerVList.append(strSessionId +   ": " + strSessionName + ": " + strSessionKey + ": " 
	                   + strSpeakerId + ": " + strFirstName + ", " + strLastName + "\n");
					   
       //infoMessage = "Your message has been sent!";
       //isSuccess =   "true";
       //request.setAttribute("isSuccess", isSuccess);
	   
	   
     }
     catch (Exception e)
     {
       infoMessage ="Your message can't be sending at this time";
	   request.setAttribute("infoMessage", infoMessage); 
	   
	   RequestDispatcher dispatcher = request.getRequestDispatcher("email");      
       if (dispatcher != null)
       {
         dispatcher.forward(request, response);
       } 
     } //End of catch				 				 
	//*************************************************************************				 					 					 
	validEmailNum++;				 
 }  
  else
  {
    //invalid email address
	speakerIList.append(strSessionId +   ": " + strSessionName + ": " + strSessionKey + ": " 
	                   + strSpeakerId + ": " + strFirstName + ", " + strLastName + "\n");  

    invalidEmailNum ++;
	//**********************************
  }  
} //End of while loop									 
											
   
   //*******************************************************
   //error checking for no valid email listed in the system
   //*******************************************************
   
   if((validEmailNum == 0) && (invalidEmailNum == 0))
   {
     infoMessage =   "No presenters have assigned to any session of 2014.";
     request.setAttribute("infoMessage", infoMessage);
	 //also return the list of presenters don't have valid email addresses
	 
	 //********************************************************************
     RequestDispatcher dispatcher = request.getRequestDispatcher("email");      
     if (dispatcher != null)
     {
       dispatcher.forward(request, response);
     } 
   }
   else if(validEmailNum == 0)
   {
     infoMessage ="No presenters have valid email address info listed in the system.";
     request.setAttribute("infoMessage", infoMessage);
	 request.setAttribute("speakerIList", speakerIList);
	 //also return the list of presenters don't have valid email addresses
	 
	 //********************************************************************
     RequestDispatcher dispatcher = request.getRequestDispatcher("email");      
     if (dispatcher != null)
     {
       dispatcher.forward(request, response);
     } 
   }
   else if(invalidEmailNum == 0)
   {
     infoMessage ="Your message has been sent!";
     request.setAttribute("infoMessage", infoMessage);
	 request.setAttribute("speakerVList", speakerVList);
	 //also return the list of presenters don't have valid email addresses
	 
	 //********************************************************************
     RequestDispatcher dispatcher = request.getRequestDispatcher("email");      
     if (dispatcher != null)
     {
       dispatcher.forward(request, response);
     } 
   
     //************************************************************************
   }
   else
   {
   
     infoMessage ="There are some able to send out and some are not able to";
     request.setAttribute("infoMessage", infoMessage);
	 request.setAttribute("speakerVList", speakerVList);
	 request.setAttribute("speakerIList", speakerIList);
	 //also return the list of presenters don't have valid email addresses
	 
	 //********************************************************************
     RequestDispatcher dispatcher = request.getRequestDispatcher("email");      
     if (dispatcher != null)
     {
       dispatcher.forward(request, response);
     } 
   
     //************************************************************************
   
   
   }
   
   
   %>