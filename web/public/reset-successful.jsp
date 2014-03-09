<%-- 
    Document   : reset-successful
    Created on : Jul 11, 2013, 11:14:39 AM
    Author     : 162107
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> 
<html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="description" content="" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <title>Password Reset Request Successful</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/prettify/prettify.css" /> 
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/general.css" /><!--General CSS-->
        <script src="${pageContext.request.contextPath}/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%@ include file="../includes/header.jsp" %> 
        <%@ include file="../includes/publicnav.jsp" %>
        <div class="container-fixed largeBottomMargin">
            <div class="row">
                <%@include file="../includes/messagehandler.jsp" %>
            </div>
            <div class="row largeBottomMargin">
                <h1 style="font-family: Arial, sans-serif;font-size:24px;color:#333;">Password Reset Confirmation</h1>
            </div>
            <div class="row mediumBottomMargin">
                <p>Your password has been successfully reset.  You may now login with your new password.  
                If you have any issues logging in, please contact the Scripps Help Desk at x4040.</p>
            </div>
            <div class="row">
                <a href="${pageContext.request.contextPath}/index.jsp">Return to homepage</a>
            </div>
        </div>
    <%@ include file="../includes/footer.jsp" %> 
    <%@ include file="../includes/scriptlist.jsp" %>

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}./js/libs/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/libs/sniui.auto-inline-help.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/libs/sniui.auto-inline-help.1.0.0.min.js" type="text/javascript"></script>

    <!--Additional Script-->
</body>
</html>