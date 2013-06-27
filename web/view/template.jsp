<%-- 
    Document   : template
    Created on : Feb 26, 2013, 11:58:57 PM
    Author     : Justin Bauguess
    Purpose    : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.scripps.growler.*" %>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title> </title><!-- Title -->
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <div class="container-fluid">
            <%@ include file="../includes/header.jsp" %> 
            <%@ include file="../includes/usernav.jsp" %>
            <div class="span8 offset2">
                <h1 class="bordered"></h1>

            </div>

            <%@ include file="../includes/footer.jsp" %> 
        </div>
        <%@ include file="../includes/scriptlist.jsp" %>
    </body>
</html>
