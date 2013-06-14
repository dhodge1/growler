<%-- 
    Document   : processattendance
    Created on : Apr 17, 2013, 11:00:30 PM
    Author     : Justin Bauguess
    Purpose    : Adds the record of survey
                 into the database.
--%>
<%@page import="com.sun.org.apache.regexp.internal.REUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.*"%>
<%@page import="com.scripps.growler.*" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page" />
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> 
<html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>Growler Project</title><!-- Title -->
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="css/draganddrop.css" /><!--Drag and drop style-->
        <script src="js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body>
        <%
                    int user = 0;
                    if (null == session.getAttribute("id")) {
                        response.sendRedirect("../index.jsp");
                    }
                    try {
                        user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                        String name = String.valueOf(session.getAttribute("user"));                  
                    }
                    catch (Exception e) {
                        
                    }
                %>
        <%
            String sessionId = (String) session.getAttribute("sessionId");


            //Make sure user didn't click back and try to take survey again
            AttendancePersistence ap = new AttendancePersistence();
            ArrayList<Attendance> attendances = ap.getAttendanceBySession(Integer.parseInt(sessionId));
  
            for (int a = 0; a < attendances.size(); a++) {
                if (user == attendances.get(a).getUserId() && attendances.get(a).getIsSurveyTaken() == true) {
                    session.setAttribute("message", "You have already taken this survey");
                    response.sendRedirect("../view/surveylist.jsp");
                }

            }

            String question1 = String.valueOf(request.getParameter("1"));
            String question2 = String.valueOf(request.getParameter("2"));
            String question3 = String.valueOf(request.getParameter("3"));
            String question4 = String.valueOf(request.getParameter("4"));
            try {
                String comment = String.valueOf(request.getParameter("comment"));
                CommentPersistence cp = new CommentPersistence();
                Comment c = new Comment(Integer.parseInt(sessionId), comment);
                cp.addComment(c);
            } catch (Exception e) {
                //No comment found
            }

            Connection connection = dataConnection.sendConnection();
            Statement statement = connection.createStatement();



            statement.execute("insert into session_ranking (question_id, session_id, ranking) values "
                    + "(" + 1 + ", " + sessionId + ", " + question1 + "),"
                    + "(" + 2 + ", " + sessionId + ", " + question2 + "),"
                    + "(" + 3 + ", " + sessionId + ", " + question3 + "),"
                    + "(" + 4 + ", " + sessionId + ", " + question4 + ")");
            Statement statement2 = connection.createStatement();
            statement2.execute("update attendance set isSurveyTaken = true, surveySubmitTime = NOW() where user_id = " + user + " and session_id = " + sessionId);
            connection.close();
            statement.close();
            session.removeAttribute("session");
            SessionPersistence sp = new SessionPersistence();
            session.setAttribute("message", "Survey for " + sp.getSessionByID(Integer.parseInt(sessionId)).getName() + " complete!");

            response.sendRedirect("../view/surveylist.jsp");
        %>
        <%@ include file="../includes/scriptlist.jsp" %>
    </body>
</html>