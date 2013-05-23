<%-- 
    Document   : index
    Created on : Feb 21, 2013, 10:09:16 PM
    Author     : Justin Bauguess and Jonathan C. McCowan
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
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <title>Log-In to Project Growler</title><!-- Title -->

        <link rel="stylesheet" href="css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="css/demo.css" />
        <link rel="stylesheet" href="css/draganddrop.css" /><!--Drag and drop style-->
        <link rel="stylesheet" href="css/prettify/prettify.css" /> 
        <link rel="stylesheet" href="css/wijmo/jquery.wijmo-complete.all.2.3.2.min.css"/>
        <link rel="stylesheet" type="text/css" href="css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="css/help.css" /><!--Help CSS-->

        <script src="js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%@include file="includes/header.jsp" %>
        <div class="row">
            <div class="span3">
                <img class="logo" src="images/Techtoberfest2013small.png" alt="Techtoberfest 2013 small"/>
            </div>
            <div class="span5">
                <h1 class = "bordered" >Log-in to Project Growler</h1>
                <%
                    try {
                        String message = (String) session.getAttribute("message");
                        if (!message.equals(null)) {
                            out.print("<p class=feedbackMessage-error>" + message + "</p>");
                        }
                        session.removeAttribute("message");
                    } catch (Exception e) {
                    }
                %>
            </div>
        </div>
        <div class="container-fluid">
            <div class="content">
                <!-- Begin Content -->
                <div class="content" role="main"> 
                    <form method="post" id="action" action="model/login.jsp">
                        <div class="span5 offset3">
                            <fieldset>
                                <div class="form-group">
                                    <label class="required">User Name:</label>
                                    <input type="text" name="username" id="tip" data-content="Enter your username" size="15"/>
                                </div>
                                <div class="form-group">
                                    <label class="required">Password:</label>
                                    <input type="password" name="password" id="tip2" data-content="Enter your password" size="15"/>
                                </div>
                                <div class="form-actions">
                                    <input class ="button button-primary" type="submit" value="Submit" id="send" /><br/><br/>
                                    <a href="view/resetpassword.jsp">Forgot Password?</a><br/><br/>
                                    <a href="view/register.jsp">Sign Up - New User</a>
                                </div>
                            </fieldset>
                        </div>                   
                    </form>
                </div>	
            </div><!-- /.content -->
        </div><!-- /.container-fluid -->
        <%@include file="includes/footer.jsp" %>

        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
        <script src="js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
        <script src="js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
        <script src="js/libs/sniui.auto-inline-help.min.js" type="text/javascript"></script>
        <script src="js/libs/sniui.auto-inline-help.1.0.0.min.js" type="text/javascript"></script>

        <!--Additional script-->
        <script>
            $(function() {
                $("input").autoinline();
            });
            $("#send").click(function() {
                var emptyString = "";
                if ($("#tip").val() === emptyString || $("#tip2").val() === emptyString) {
                    $("#action").attr("action", "");
                    alert("Please enter both a username and a password for log-in.");
                }
                else {
                    $("#action").attr("action", "model/login.jsp");
                }
            });
        </script>
    </body>
</html>
