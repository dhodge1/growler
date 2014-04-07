<%-- 
    Document   : sendingFeedbackEmail
    Created on : Mar 31, 2014, 8:21:36 PM
    Author     : ThuyTo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*, javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.scripps.growler.*, java.sql.*" %>
<%@ page import="com.scripps.growler.Session" %>
<%@ page import="com.scripps.growler.Comment" %>
<%@ page import="com.scripps.growler.CommentPersistence" %>


<%

String subject = new String();
String content = new String();
boolean isContentHTML = false;
int sessionId;
int emailSent = 0;
String sessionName = new String();
String infoMessage = new String();//for email sending status info message
String isSuccess = new String(); //for error checking purpose
String avg1 = new String();
String avg2 = new String();
String avg3 = new String();
String avg4 = new String();   
//get an arraylist() of this year active sessions
SessionPersistence sessionPer = new SessionPersistence();
ArrayList<Session> sessionArrayList = sessionPer.getThisYearActiveSessionId(2014, true);
int sessionSize = sessionArrayList.size();

//*****************************************************************************
//** If no session available then flag the warning feedback message and 
//** redirect back to the confirming page.
//   Else then generate an email list for that particular session speaker team.
//******************************************************************************
if(sessionSize==0)
{
   infoMessage =   "No active sessions have been listed in the system.";
   request.setAttribute("infoMessage", infoMessage);
   RequestDispatcher dispatcher = request.getRequestDispatcher("sessionKeyEmail-confirm");      
   if (dispatcher != null)
   {
     dispatcher.forward(request, response);
   } 
}
else
{
  for(int i=0; i<sessionSize; i++)
  {
    sessionName = sessionArrayList.get(i).getName();
    sessionId  = sessionArrayList.get(i).getId();
    SpeakerPersistence speakerPer = new SpeakerPersistence();
    ArrayList<Speaker>speakerArrayList = speakerPer.getSpeakersEmailListBySessionId(sessionId);
    int speakerSize = speakerArrayList.size();
    StringBuffer emailList = new StringBuffer();
    if(speakerSize > 0)
    {
      for (int j = 0; j < speakerSize; j++)
      {  
        if((speakerArrayList.get(j).getEmail() != null) &&
           (speakerArrayList.get(j).getEmail().indexOf("@")!= -1))  
        {
           emailList.append(speakerArrayList.get(j).getEmail());
           if(j < (speakerSize-1))
           {
             emailList.append(", ");
           }       
        }//END OF GOOD EMAILS    
      }//END OF J LOOP
    } //END OF BUILDING EMAIL LIST
    
    //************************************
    //**Error check for empty email list *
    //************************************
    if(emailList.length()!=0)
    {
        //gets the ranking average base on each question category
        avg1 = sessionPer.getAvgByQuestionCategory(sessionId, 1);
        //****************************************************
        //** First,check if the question survey is available**
        //** for a particular given session                 **
        //****************************************************   
        if(avg1 != null)
        {
          avg2 = sessionPer.getAvgByQuestionCategory(sessionId, 2);
          avg3 = sessionPer.getAvgByQuestionCategory(sessionId, 3);
          avg4 = sessionPer.getAvgByQuestionCategory(sessionId, 4);
        }
        else
        { 
          avg1 = "Not available";
          avg2 = "Not available";
          avg3 = "Not available";
          avg4 = "Not available";
        }
        //gets an arraylist()of comments that related to the given session id
        CommentPersistence commentPer = new CommentPersistence();
        ArrayList<Comment>commentArrayList = commentPer.getCommentBySessionIdForFeedback(sessionId);
        int commentSize = commentArrayList.size();
        StringBuffer commentList = new StringBuffer();
        //checks if any comment is available for the given session
        if(commentSize > 0)
        {
          for(int k=0; k <commentSize; k++)
          {
            commentList.append(commentArrayList.get(k).getDescription());
            commentList.append("\n");  
          }
        } 
        else
        {
          commentList.append("Not available");
        }
        
        if((!(avg1.equals("Not available"))) ||
            (commentSize > 0))
        {
           //**************************************************************
           //**Everything is ready for hard coding the email content for **
           //**the given team of speakers                                **
           //**************************************************************
           subject =  "The feedback of session: " + sessionName;
           content = "Dear Presenter(s) \n\n"
              + "Here is the feedback for your presentation,\n\n" 
              + "1. Average scores in each question category\n"
	      + "\tQuestion 1: "+ avg1 + " (out of 5.00)\n"
              + "\tQuestion 2: "+ avg2 + " (out of 5.00)\n"
              + "\tQuestion 3: "+ avg3 + " (out of 5.00)\n"
              + "\tQuestion 4: "+ avg4 + " (out of 5.00)\n\n"
              + "2. Below are all the comments that relate to your presentation \n"
              + "\t" + commentList.toString() 
	      + "\n\nThanks\n\n"
	      + "Techtoberfest Adminstration\n";	   
    
    
           //**************************************************************
    
           try
           { 
   
            //perform the send email task
            EmailUtilSMTPScripps.sendMail(emailList.toString(), subject, content, isContentHTML);
            emailSent++;
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
        } //READY TO EMAIL OUT 
        
    }//END OF EMAIL LIST AVAILABLE
  }//END OF SESSION FOR LOOP

  if(emailSent > 0)
  {
       infoMessage = "Your message has been sent!";
       isSuccess =   "true";
       request.setAttribute("isSuccess", isSuccess);
       request.setAttribute("infoMessage", infoMessage); 
       RequestDispatcher dispatcher = request.getRequestDispatcher("sessionKeyEmail-confirm");      
       if (dispatcher != null)
       {
         dispatcher.forward(request, response);
       } 
  }

}//END OF ELSE THERE SESSIONS IN 2014   
   %>
   