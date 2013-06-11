<%-- 
    Document   : leavesattendance
    Created on : Apr 17, 2013, 11:00:30 PM
    Author     : Justin Bauguess
    Purpose    : Deletes the record of attendance
                 into the database.
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
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
            String sessionId = request.getParameter("session");
            String user = String.valueOf(session.getAttribute("id"));
            Connection connection = dataConnection.sendConnection();
            //Check against isSurveyTaken value, or a user can delete a session they've taken a survey for, then take it again!
            PreparedStatement statement = connection.prepareStatement("delete from attendance where session_id = ? and user_id = ? and isSurveyTaken = false");
            statement.setInt(1, Integer.parseInt(sessionId));
            statement.setInt(2, Integer.parseInt(user));
            int success = statement.executeUpdate();
            if (success == 0) {
                session.setAttribute("message", "Failed to remove attendance record.");
            }
            else {
                session.setAttribute("message", "You were successfully removed from the session!");
            }
            connection.close();
            statement.close();
            
            response.sendRedirect("../view/attendance.jsp");
        %>
        <%@ include file="../includes/scriptlist.jsp" %>
    </body>
</html>