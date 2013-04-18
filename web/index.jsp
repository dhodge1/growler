<%-- 
    Document   : index
    Created on : Feb 21, 2013, 10:09:16 PM
    Author     : Chase, Justin
--%>

<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
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
<body id="growler1">
    <%@include file="includes/header.jsp" %>
    <h1>Log-in To Project Growler</h1>
    <br/>
    <br/>
    <form method="post" action="model/login.jsp">
        <h3>User Name: <input type="text" name="username" size="15" /></h3>
        <br/>
        <br/>
        <h3>Password:  <input type="password" name="password" size="15"/></h3>
        <br/>
        <br/>
    <input type="submit" value="Submit" />
    </form>
    <br/>
    <a href="view/register.jsp">Sign Up - New User</a><br/><br/>
    <a href="view/resetpassword.jsp">Forgot Password?</a>
    <%@include file="includes/footer.jsp" %>
</body>
</html>
