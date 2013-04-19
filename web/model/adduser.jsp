<%-- 
    Document   : adduser
    Created on : Apr 17, 2013, 9:50:54 PM
    Author     : Justin Bauguess
    Purpose    : Processes adding a user to the Growler Project
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<!doctype html>
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
	<link rel="stylesheet" href="draganddrop.css" /><!--Drag and drop style-->
  <script src="js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
</head>
<body id="growler1">
 <%@ include file="../includes/header.jsp" %> 
<%
    //Find if the user already exists
    String user = request.getParameter("username");
    Connection connection = dataConnection.sendConnection();
    Statement statement = connection.createStatement();
    ResultSet result = statement.executeQuery("select name from user where name = '" + user + "'");
    //If there's a result, we send back to the index...don't want the same user name twice
    while(result.next()) {
        response.sendRedirect("../index.jsp");
    }
    //Add the user if they aren't already there
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String corporate = "";
    try{
        corporate = request.getParameter("corporate");
       }
    catch (Exception e) {
        corporate = "null";
    }
    boolean success = statement.execute("insert into user (name, password, email, corporate_id) values ('" + 
            user + "',sha1('" + password + "'),'" + email + "', '" + corporate + "')");
    if (success) {
        result.close();
        statement.close();
        connection.close();
        session.setAttribute("user", user);
        response.sendRedirect("../view/theme.jsp");
       }
    else {
        result.close();
        statement.close();
        connection.close();
        response.sendRedirect("../index.jsp");
    }
%>
<%@ include file="../includes/footer.jsp" %> 
<%@ include file="../includes/scriptlist.jsp" %>
<%@ include file="../includes/draganddrop.jsp" %>
    </body>
</html>
