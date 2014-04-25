<%-- 
    Document   : sendingFeedbackEmail
                 The Ajax calls from the sessioFeedbackEmail-confirm.jsp called 
                 this page. We send the feedback email message to each speaker 
                 team of each current year active sessions. The feedback message 
                 consists of the average of each survey question and all the 
                 comments that related to that particular session.
                 
                 
    Created on : Mar 31, 2014, 8:21:36 PM
    Author     : ThuyTo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*, javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.mail.MessagingException"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="com.scripps.growler.*, java.sql.*" %>
<%@ page import="com.scripps.growler.Session" %>
<%@ page import="com.scripps.growler.Comment" %>
<%@ page import="com.scripps.growler.CommentPersistence" %>
<%@page import="com.google.gson.Gson" %>

<%
String question1 = new String("This session met my expectations: ");
String question2 = new String("The speaker was knowledgable on the topic: ");
String question3 = new String("The speaker's presentation skills were good: ");
String question4 = new String("The facility was appropriate for the presentation: ");

String subject = new String();
String content = new String();
boolean isContentHTML = false;
int sessionId;
int emailSent = 0;
String sessionName = new String();

   String infoMessage = new String();//for email sending status info message
   boolean lclSuccess; 
   String jsonStr = new String();
   Feedback emailFeedback; 
   Gson gson = new Gson();

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
          avg1 = "(NO RATINGS HAVE BEEN SUBMITTED)";
          avg2 = "(NO RATINGS HAVE BEEN SUBMITTED)";
          avg3 = "(NO RATINGS HAVE BEEN SUBMITTED)";
          avg4 = "(NO RATINGS HAVE BEEN SUBMITTED)";
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
            commentList.append("\t"+ (k+1) +")");
            commentList.append(commentArrayList.get(k).getDescription().trim());
            commentList.append("\n");  
          }
        } 
        else
        {
          commentList.append("\t" +"(NO COMMENT SUBMITTED)");
        }
        
        if((!(avg1.equals("(NO RATINGS HAVE BEEN SUBMITTED)"))) ||
            (commentSize > 0))
        {
           //**************************************************************
           //**Everything is ready for hard coding the email content for **
           //**the given team of speakers                                **
           //**************************************************************
           subject =  "Session Feedback: " + sessionName;
           content = "Dear Presenter(s) \n\n"
              + "Here is the feedback for your presentation:\n\n" 
              + "A. Average score for each question(out of 5.00)\n"
	      + "\t1)"+ question1 + avg1 + "\n"
              + "\t2)"+ question2 + avg2 + "\n"
              + "\t3)"+ question3 + avg3 + "\n"
              + "\t4)"+ question4 + avg4 + "\n\n"
              + "B. Below are all the comments that relate to your presentation \n"
              +  commentList.toString() 
	      + "\n\nThanks\n"
	      + "Techtoberfest Team\n";	   
           //**************************************************************
    
           try
           { 
   
              //perform the send email task
              EmailUtilSMTPScripps.sendMail((emailList.toString()), subject, content, isContentHTML);
              emailSent++;
              
           }
           catch (Exception e)
           { 
              //e.getMessage();
              //infoMessage = e.getMessage().toString();
              infoMessage ="Your message can't be sent at this time";
              emailFeedback= new Feedback(infoMessage, false);
              //calls the Ajax function
              jsonStr = gson.toJson(emailFeedback);
              //send the json object back to the browser
              out.print(jsonStr);
              return; //needs this return stmt to get back the ajax function called page.
          }
       } //READY TO EMAIL OUT 
        
    }//END OF EMAIL LIST AVAILABLE
  }//END OF SESSION FOR LOOP

  if(emailSent > 0)
  {
       infoMessage = "Your messages have been sent!";
       lclSuccess = true;
       //since the lclSuccess  is true therefore we need to call the 2-arg constructor
       emailFeedback= new Feedback(infoMessage, lclSuccess);
       //turns the Feedback object type to the json object
       jsonStr = gson.toJson(emailFeedback);
       //send the json object back to the browser
       out.print(jsonStr);
  }
  else
  {
       infoMessage ="No valid email address or session feedback is submitted at this time";
       emailFeedback= new Feedback(infoMessage);
       //calls the Ajax function
       jsonStr = gson.toJson(emailFeedback);
       //send the json object back to the browser
       out.print(jsonStr);
  }

}//END OF ELSE THERE SESSIONS IN 2014   
   %>
   