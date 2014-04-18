<%-- 
    Document   : eAllParticipants
                 This JSP takes email message content from the emailToAllParticipants.jsp.
                 Then it instantiates a UserPersistence object and uses the 
                 getUsersLikedASessionORSubmittedSurveys() method of that UserPesistence
                 object to get an array list of all the Users objects. Then, this 
                 JSP concatenates all of the User's email address into a long 
                 string called emailList. Lastly, it calls the sendmail()method
                 of the EmailUtilSMTPLocal class to perform the emailing task. 
                 ** Instead of dispatch the request, we returns the json object
                    back to the Ajax called.
    
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
<%@ page import="com.scripps.growler.Feedback"%>
<%@ page import="javax.mail.MessagingException"%>
<%@page import="com.google.gson.Gson" %>



 <%
  
   StringBuffer emailList = new StringBuffer();
   String subject = new String();
   String content = new String();
   boolean isContentHTML = false;
   
   String infoMessage = new String();//for email sending status info message
   //String isSuccess = new String(); //for error checking purpose
   boolean lclSuccess;
   String jsonStr = new String();
   Feedback emailFeedback; 
   Gson gson = new Gson();  
   //***************
   //add gson object
   //***************
   //Gson gson = new Gson();
   
   
     //get info from the emailform.jsp     
   subject = request.getParameter("emailSubject");
   content = request.getParameter("emailContent");
   
   //get the email list from all the users
   UserPersistence uPersistence = new UserPersistence();
   ArrayList<User> userArrayList = uPersistence.getUsersLikedASessionORSubmittedSurveys();
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
   }
   
   //*******************************************************
   //error checking for no valid email listed in the system
   //*******************************************************
   if(emailList.length()==0)
   {
     infoMessage =   "No participants have valid email address info listed in the system.";
     emailFeedback= new Feedback(infoMessage);
     //calls the Ajax function
     jsonStr = gson.toJson(emailFeedback);
     //send the json object back to the browser
     out.print(jsonStr);
     //String json = Gson.toJson(infoMessage);
     //out.print(json);
     //String respond ="{'isSuccess':'false', 'infoMessage': 'No participants have valid email address info listed in the system.'}";
     //out.print(respond);   
  /*   
     request.setAttribute("infoMessage", infoMessage);
     RequestDispatcher dispatcher = request.getRequestDispatcher("emailToAllParticipants");      
     if (dispatcher != null)
     {
       dispatcher.forward(request, response);
     }
  */
     
   }
   else
   {    
     try
     {
       //perform the send email task
       EmailUtilSMTPScripps.sendMail((emailList.toString()), subject, content, isContentHTML);
      // String respond ="{\"isSuccess\":\"true\", \"infoMessage\": \"Your message has been sent!\"}";
       //out.print(respond);
       
       infoMessage = "Your message has been sent!";
       lclSuccess = true;
       
       emailFeedback= new Feedback(infoMessage, lclSuccess);
       //calls the Ajax function
       jsonStr = gson.toJson(emailFeedback);
       //send the json object back to the browser
       out.print(jsonStr);
       //request.setAttribute("isSuccess", isSuccess);
     }
     catch (Exception e)
     {
       
       //String respond ="{'isSuccess':'false', 'infoMessage': 'Your message can't be sent at this time.'}";
       //out.print(respond);
         
       infoMessage ="Your message can't be sent at this time";
       emailFeedback= new Feedback(infoMessage);
       //calls the Ajax function
       jsonStr = gson.toJson(emailFeedback);
       //send the json object back to the browser
       out.print(jsonStr);
      
     }
     finally 
     {
       //request.setAttribute("infoMessage", infoMessage); 
       //RequestDispatcher dispatcher = request.getRequestDispatcher("emailToAllParticipants");      
       //if (dispatcher != null)
      // {
        // dispatcher.forward(request, response);
       //} 
     }
   }    
   
%>                      
    

