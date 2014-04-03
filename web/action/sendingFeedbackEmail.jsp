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

        <title>Session Key Email Confirm</title><!-- Title -->

        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/demo.css" />  
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/speaker.css" /><!--Survey CSS-->
        <link rel="stylesheet" href="/resources/demos/style.css" />
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%
            int user = 0;
            if (null == session.getAttribute("id")) {
                response.sendRedirect("http://sniforms.scrippsnetworks.com/siteminderagent/sniforms/logout.html");
            } else if (!session.getAttribute("role").equals("admin")) {
                response.sendRedirect("../../../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
        %>
        <%@ include file="../../../includes/adminheader.jsp" %>
        <% if (String.valueOf(session.getAttribute("role")).equals("admin")) { %>
            <%--<jsp:include page="../../includes/supernav.jsp" flush="true"/>--%>
            <%@ include file="../../../includes/supernav.jsp" %>
        <% } else {%>
            <%--<jsp:include page="../../includes/adminnav.jsp" flush="true"/>--%>
            <%@ include file="../../../includes/adminnav.jsp" %>
        <% } %>
        <%--<%@ include file="../../../includes/adminnav.jsp" %>--%>
        




<%

StringBuffer emailList = new StringBuffer();
StringBuffer commentList = new StringBuffer();
String subject = new String();
String content = new String();
boolean isContentHTML = false;
int sessionId;
String infoMessage = new String();//for email sending status info message
//String isSuccess = new String(); //for error checking purpose
   
//get an arraylist() of this year active sessions
SessionPersistence sessionPer = new SessionPersistence();
ArrayList<Session> sessionArrayList = sessionPer.getThisYearActiveSessionId(2014, true);
int sessionSize = sessionArrayList.size();
%>

<div><p><%=sessionArrayList.size()%></p></div>

        <%
if(sessionSize==0)
{
/*
   infoMessage =   "No active sessions have been listed in the system.";
   request.setAttribute("infoMessage", infoMessage);
   RequestDispatcher dispatcher = request.getRequestDispatcher("emailBySurvey");      
   if (dispatcher != null)
   {
     dispatcher.forward(request, response);
   } 
*/
}
else
{

%>

<div><p>HOHOHO</p></div>
<%
  for(int i=0; i<sessionSize; i++)
  {
    sessionId  = sessionArrayList.get(i).getId();
    SpeakerPersistence speakerPer = new SpeakerPersistence();
    ArrayList<Speaker>speakerArrayList = speakerPer.getSpeakersEmailListBySessionId(sessionId);
    int speakerSize = speakerArrayList.size();
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

    //gets the ranking average base on each question category
    double lclAvg1 = sessionPer.getAvgByQuestionCategory(sessionId, 1);
    double lclAvg2 = sessionPer.getAvgByQuestionCategory(sessionId, 2);
    double lclAvg3 = sessionPer.getAvgByQuestionCategory(sessionId, 3);
    double lclAvg4 = sessionPer.getAvgByQuestionCategory(sessionId, 4);

    //gets an arraylist()of comments that related to the given session id
    CommentPersistence commentPer = new CommentPersistence();
    ArrayList<Comment>commentArrayList = commentPer.getCommentsBySession(sessionId);
    int commentSize = commentArrayList.size();
    if(commentSize > 0)
    {
      for(int k=0; k <commentSize; k++)
      {
         commentList.append(commentArrayList.get(k).getDescription());
         commentList.append("\n");  
      }
    } 
    //**************************************************************
    //**Everything is ready for hard coding the email content for **
    //**team of speakers                                          **
    //**************************************************************
    subject =  "The feedback of sessesion.......";
    content = "Dear Presenter(s) \n\n"
	      + "Here is your session feedback\n" 
	      + lclAvg1 +"<br>"
              + lclAvg2 +"<br>"
              + lclAvg3 +"<br>"
              + lclAvg4 +"<br>"
              + commentList.toString()
	      + "\nThanks\n"
	      + "Techtoberfest Adminstration\n";	   
    
    
   //**************************************************************
    
   try
   {
   %>
   <div><p><%=lclAvg1%></p></div>
   <div><p><%=content%></p></div>
   
    <%   //perform the send email task
     //   EmailUtilSMTPScripps.sendMail(emailList.toString(), subject, content, isContentHTML);

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
  }//END OF SESSION FOR LOOP
}//END OF ELSE THERE SESSIONS IN 2014


   
   %>
   
   
          <%@ include file="../../../includes/footer.jsp" %> 
       <%@ include file="../../../includes/scriptlist.jsp" %>
    </body>
</html>