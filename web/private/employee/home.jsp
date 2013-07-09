<%-- 
    Document   : home
    Created on : May 31, 2013
    Author     : Justin Bauguess
    Purpose    : Serves as a launch page for the rest of the application
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<jsp:useBean id="theme" class="com.scripps.growler.Theme" scope="page" />
<jsp:useBean id="persist" class="com.scripps.growler.ThemePersistence" scope="page" />
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page" />
<jsp:useBean id="giveStars" class="com.scripps.growler.GiveStars" scope="page" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Welcome to Techtoberfest!</title><!-- Title -->
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="../../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../../css/demo.css" />  
        <link rel="stylesheet" href="../../css/draganddrop.css" /><!--Drag and drop style-->
        <link rel="stylesheet" type="text/css" href="../../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="../../css/theme.css" /><!--Theme CSS-->
        <script src="../../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">    
        <%@ include file="../../includes/header.jsp" %> 
        <%@ include file="../../includes/testnav.jsp" %>
                <%
                    String user = "";
                    if (null == session.getAttribute("id")) {
                        response.sendRedirect("../../index.jsp");
                    }
                    try {
                        user = String.valueOf(session.getAttribute("id"));
                        String name = String.valueOf(session.getAttribute("user"));                  
                    }
                    catch (Exception e) {
                        
                    }
                %>
        <div class="container-fixed">
            <br/><br/><br/>
            <div class="row">
                
                    <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;width:165px;" src='../../images/Techtoberfest2013small.png'/><span class="titlespan">Welcome to Techtoberfest</span></h2>
                
            </div>
            <br/>
            <div class="row">
                
                    <h3>Themes</h3>
                                        <p>A place to view, rank, and suggest Themes for this year's Techtoberfest</p>
                                        <h3>Speakers</h3>
                                        <p>A place to view, rank, and suggest Speakers for this year's Techtoberfest</p>
                                        <h3>Sessions</h3>
                                        <p>A place to register interest in a session, view the schedule, acknowledge attendance to a session, and complete surveys for sessions in this year's Techtoberfest</p>
                
            </div>
        </div>
        <%@ include file="../../includes/footer.jsp" %>
        <%@ include file="../../includes/scriptlist.jsp" %>
    </body>
</html>

