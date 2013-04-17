<%-- 
    Document   : help
    Created on : Apr 4, 2013, 11:40:34 PM
    Author     : Justin Bauguess
    Purpose    : The purpose of the help file is to provide users with advice
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
<!--[if gt IE 8]><!--> 
<html class="no-js" lang="en"> <!--<![endif]-->
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <title>Growler Project</title><!-- Title -->
  <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
  <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
	<link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
  <script src="js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
</head>
<body id="growler1">
        <%@include file="../includes/header.jsp" %>
        <%@include file="../includes/usernav.jsp" %>
        <div>Help Section</div>
        <ol>
            <li><a href="#themerate">How Do I Rate a Theme?</a></li>
            <li><a href="#themesuggest">How Do I Suggest a Theme?</a></li>
            <li><a href="#speakerrate">How Do I Rate a Speaker?</a></li>
            <li><a href="#speakersuggest">How Do I Suggest a Speaker?</a></li>
            <li><a href="#attend">How Do I Attend a Session?</a></li>
            <li><a href="#survey">How Do I Fill Out a Survey?</a></li>
            <li><a href="#unattend">How Do I undo Attendance to a Session?</a></li>
            <li><a href="#password">How Do I Set/Reset My Password?</a></li>
            <li><a href="#credentials">How Do I Leverage my Corporate Credentials?</a></li>
        </ol>
        <a name="themerate"></a>
            <h3>How Do I Rate a Theme?</h3>
            <p>To rate a theme, drag the list of themes into the desired order.
                Only the top ten themes will be ranked.  Once you have the themes
                in the desired order, click "Submit".  The ratings will be saved.</p>
        
        <a name="themesuggest"></a>
            <h3>How Do I Suggest a Theme?</h3>
            <p>To Suggest a theme, type in the name of the theme (30 character max),
                the description (250 character max), and a reason (optional, 250 
                character max).  Click "Submit."  The theme will be saved.</p>
            <p>Suggested themes will not be visible until they are made so by 
                the administrator.</p>
        	<%@ include file="../includes/footer.jsp" %>
	<%@ include file="../includes/scriptlist.jsp" %>
    </body>
</html>
