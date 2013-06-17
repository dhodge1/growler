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

        <title>Password Reset</title>

        <link rel="stylesheet" href="../css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/prettify/prettify.css" /> 
        <link rel="stylesheet" type="text/css" href="../css/general.css" /><!--General CSS-->

        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->	
    </head>
    <body id="growler1">
        <%@ include file="../includes/header.jsp" %> 
        <div class="row">
            <div class="span3">
                <img class="logo" src="../images/Techtoberfest2013small.png" alt="Techtoberfest 2013 small"/>
            </div>
            <div class="span5">
                <h1 class = "bordered largeBottomMargin">Password Recovery</h1>
            </div>
        </div>
        <div class="container-fluid">
            <div class="content" role="main">
                <!-- Begin Content -->
                <%@include file="../includes/messagehandler.jsp" %>
                <form method="POST" id="action" action="../model/sendreset.jsp">
                    <div class="span5 offset3">
                        <fieldset>
                            <div class="form-group">
                                <label class="required">User ID</label>
                                <input name="id" class="input-xlarge" type="text" id="tip" data-content="Enter your User ID" maxlength="6"/>
                            </div>
                            <div class="form-group">
                                <label class="required">Email Address</label>
                                <input name="email" class="input-xlarge" type="text" id="tip2" data-content="Enter your Email Address" maxlength="50"/>
                            </div>
                            <div class="form-actions">
                                <input class="button button-primary" id="send" value="Submit" type="submit"/>
                                <a class="button" href="../index.jsp">Cancel</a>
                            </div>
                        </fieldset>
                    </div>   
                </form>		
            </div><!-- /.content -->
        </div><!-- /.container-fluid -->
    <%@ include file="../includes/footer.jsp" %> 
    <%@ include file="../includes/scriptlist.jsp" %>

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script src="../js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
    <script src=".../js/libs/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="../js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
    <script src="../js/libs/sniui.auto-inline-help.min.js" type="text/javascript"></script>
    <script src="../js/libs/sniui.auto-inline-help.1.0.0.min.js" type="text/javascript"></script>

    <!--Additional Script-->
    <script>
        $(function() {
            $("#tip, #tip2").autoinline();
        });
        $("#send").click(function(event) {
            var emptyString = "";
            if ($("#tip,#tip2").val() === emptyString) {
                alert("Please enter information into all fields before submitting.");
                event.preventDefault();
            }
            else {
                $("#action").attr("action", "../model/sendreset.jsp");
            }
        });
    </script>
</body>
</html>
