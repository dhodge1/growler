<%-- 
    Document   : requestreset
    Created on : Modified on 5/1/2013 by JCM (Modifed again in June - JMB
    Author     : Christopher Tupps & Jonathan C. McCowan & Justin Bauguess
    Purpose    : This page allows a user to enter a ID and email to allow a password reset.
                If the ID matches the email in the user table, they will be sent
                an email that allows them to reset their password.
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

        <title>Request Password Reset</title>

        <link rel="stylesheet" href="../css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/prettify/prettify.css" /> 
        <link rel="stylesheet" type="text/css" href="../css/general.css" /><!--General CSS-->
        <style>
            .message_container {
                display: none;
                color: red;
                font-weight: bold;
            }
        </style>
        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->	
    </head>
    <body id="growler1">
        <%@ include file="../includes/indexheader.jsp" %> 
        <%@ include file="../includes/publicnav.jsp" %>
        <div class="container-fixed mediumBottomMargin">
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="../index.jsp">Home</a></li>
                    <li class="ieFix">Request Password Reset</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="font-weight:normal;">Request Password Reset</h1>
            </div>
            <div class='row mediumBottomMargin' style='border: 1px dotted #ccc;'></div>
            <div class="row mediumBottomMargin">
                <p>Please enter the Email Address associated with your account and click Submit Request</p>
            </div>
            <div class="row mediumBottomMargin">
                <label><span style="color: red;">*</span>Required field</label>
            </div>
            <div class="row">
                <h2 class="bordered mediumBottomMargin">Request Details</h2>
                <%@include file="../includes/messagehandler.jsp" %>
                <p id="error_global" class="message_container feedbackMessage-error">
                    <span style="color: #000">An email address is required.</span>
                </p>
                    <form method="POST" id="action" action="../action/sendreset.jsp">
                        <fieldset>
                            <div class="form-group largeBottomMargin">
                                <label class="required">Email Address</label>
                                <input name="email" class="input-xlarge" type="text" id="tip" data-content="Enter your Email Address" maxlength="50"/>
                                <br/><span id="error_email" class="message_container">
                                    <span>Please enter a Valid Email Address</span>
                                </span>
                                <span id="error_valid" class="message_container">
                                    <span>Please enter a valid Email Address</span>
                                </span>
                                <span id="error_scripps" class="message_container">
                                    <span>As a Scripps employee, you must request a password reset using the procedure outlined by the help desk.  Please cancel and contact the Help Desk if you need further assistance.</span>
                                </span>
                                <span id="error_final" class="message_container">
                                    <span>This website is for Scripps Networks employees only. Please contact the SNI help desk for further assistance.</span>
                                </span>
                            </div>
                            <div class="form-actions">
                                <input class="button button-primary" id="send" value="Submit Request" type="submit"/>
                                <a href="../index.jsp">Cancel</a>
                            </div>
                        </fieldset>
                </form>	
            </div>
        </div>
    <%@ include file="../includes/footer.jsp" %> 
    <%@ include file="../includes/scriptlist.jsp" %>

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script src="../js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
    <script src=".../js/libs/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="../js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
    <script src="../js/libs/sniui.auto-inline-help.min.js" type="text/javascript"></script>
    <script src="../js/libs/sniui.auto-inline-help.1.0.0.min.js" type="text/javascript"></script>

    <!--Additional Script-->
    <script src="../js/requestreset.js"></script>
</body>
</html>
