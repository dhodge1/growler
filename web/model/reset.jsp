<%-- 
    Document   : reset
    Created on : Apr 17, 2013, 10:30:03 PM
    Author     : Justin Bauguess
    Purpose    : Processes a password reset
                 Accepts the user name, and (hopefully) matching password fields
                 from the resetpassword.jsp page.  This also needs to user to have 
                 entered the correct verification code sent by the email.
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
    String user = request.getParameter("user");
    String verify = request.getParameter("verify");
    String p1 = request.getParameter("password");
    String p2 = request.getParameter("password2");
    if (p1.compareTo(p2) != 0) {
        response.sendRedirect("../view/resetpassword.jsp?user_name=" + user);
    }
    Connection connection = dataConnection.sendConnection();
    Statement statement = connection.createStatement();
    ResultSet result = statement.executeQuery("select name from user, password where name = '" + user 
            + "' and password = '" + verify + "'");
    boolean success = false;
    while (result.next()) {
        success = statement.execute("update user set password = '" + p1 + "' where name = '" + user + "'");
    }
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
