
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



<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="description" content="" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <title>Email To Participants</title><!-- Title -->

        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../../../css/demo.css" />  
        <link rel="stylesheet" type="text/css" href="../../../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="../../../css/speaker.css" /><!--Survey CSS-->
        <link rel="stylesheet" href="/resources/demos/style.css" />
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body>
       

 <%
  
   StringBuffer emailList = new StringBuffer();
   String subject = new String();
   String content = new String();
   String thuyStr = new String();
   boolean isContentHTML = false;
  int selectedSession;
   
   String isSuccess = new String(); //for error checking purpose
   
     //get info from the emailform.jsp 
   thuyStr = request.getParameter("sessionNum");
   subject = request.getParameter("emailSubject");
   content = request.getParameter("emailContent");
   


   //get the email list from all the users
   UserPersistence uPersistence = new UserPersistence();
   ArrayList<User> userArrayList = uPersistence.getUsersLikedASession(46);
   int arraySize = userArrayList.size();
   //*******************************************
   //The first 5 users on the list are real users
   //and we don't want to send tesing email to them
   //therefore we start the arraylist at index 5. 
   //NEED TO CHANGE THAT LATER TO 0****************
   //***********************************************
    

   for (int i = 0; i < arraySize; i++)
   {  
     if(userArrayList.get(i).getEmail() != null)  
     {
       emailList.append(userArrayList.get(i).getEmail());
       if(i < (arraySize-1))
       {
          emailList.append(", ");
       }       
     }    
   }


   
   try
   {
      //perform the send email task
      EmailUtilSMTPLocal.sendMail((emailList.toString()), subject, content, isContentHTML);
      isSuccess = "Your message has been sent!";
   }
   catch (Exception e)
   {
    // e.printStackTrace();
     isSuccess ="Your message can't be sending at this time";
   }
   
   finally 
   {
     request.setAttribute("isSuccess", isSuccess);
     RequestDispatcher dispatcher = request.getRequestDispatcher("emailFormOfParticipants.jsp");      
     if (dispatcher != null)
     {
       dispatcher.forward(request, response);
     } 
   }
   //response.sendRedirect("../../../private/employee/home.jsp");
                    
    

%>

      <%@ include file="../../../includes/footer.jsp" %> 
       <%@ include file="../../../includes/scriptlist.jsp" %>
    </body>
</html>

            