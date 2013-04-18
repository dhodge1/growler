<%-- 
    Document   : processattendance
    Created on : Apr 17, 2013, 11:00:30 PM
    Author     : Justin Bauguess
    Purpose    : Adds the record of attendance
                 into the database.
--%>
<%@page import="com.sun.org.apache.regexp.internal.REUtil"%>
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
        
        
        
        Connection connection = dataConnection.sendConnection();
        Statement statement = connection.createStatement();
        ResultSet result = statement.executeQuery("");
        
        //1 represents FALSE for the tinyint type in MySQL
        boolean success = statement.execute("insert into attendance (user_id, session_id) values " +
               session.getAttribute("id") + ", " + sessionId );
        
        
        
        connection.close();
        statement.close();
        result.close();
        
        response.sendRedirect("../view/attendance.jsp");
        %>
	<%@ include file="../includes/scriptlist.jsp" %>
    </body>
</html>