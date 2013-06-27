<%-- 
    Document   : index
    Created on : Feb 21, 2013, 10:09:16 PM
    Author     : Justin Bauguess and Jonathan C. McCowan
    Purpose    : The log-in area for the application.  Users are redirected here
                if their sessions expire, and also can create new accounts from 
                this page.  The final link will take a user to reset a password.
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
        <title>Log-In to Techtoberfest</title><!-- Title -->
        <link rel="stylesheet" href="css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="css/demo.css" />
        <link rel="stylesheet" href="css/draganddrop.css" /><!--Drag and drop style-->
        <link rel="stylesheet" href="css/prettify/prettify.css" /> 
        <link rel="stylesheet" href="css/wijmo/jquery.wijmo-complete.all.2.3.2.min.css"/>
        <link rel="stylesheet" type="text/css" href="css/general.css" /><!--General CSS-->
        <script src="js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
            <%@include file="includes/indexheader.jsp" %>        
            <div class="container-fluid">
            <div class="row">
                <div class="span3">
                    <img class="logo" src="images/Techtoberfest2013small.png" alt="Techtoberfest 2013 small"/>
                </div>
                <div class="span5">
                    <h1 class = "bordered" >Log-in to Techtoberfest</h1>
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
            <div class="content" role="main"> 
                <form method="post" id="action" action="model/login.jsp">
                    <div class="span5 offset3">
                        <fieldset>
                            <div class="form-group">
                                <label class="required">User ID:</label>
                                <input type="text" name="username" id="tip" data-content="Enter your 6 digit ID" maxlength="6"/>
                            </div>
                            <div class="form-group">
                                <label class="required">Password:</label>
                                <input type="password" name="password" id="tip2" data-content="Enter your password" maxlength="20"/>
                            </div>
                            <div class="form-actions">
                                <input class ="button button-primary" type="submit" value="Log In" id="send" /><br/><br/>
                                <a href="view/register.jsp">Sign Up</a><br/>                                    
                                <a href="view/requestreset.jsp">Forgot Password</a><br/>
                            </div>
                        </fieldset>
                    </div>                   
                </form>
            </div><!-- /.content -->
        </div><!-- /.container-fluid -->
        <%@include file="includes/footer.jsp" %>
        <div id="modalDialog" title="Error logging in">
            <p>Please Enter A Username and Password.</p>
        </div>

        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
        <script src="js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
        <script src="js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
        <script src="js/libs/sniui.auto-inline-help.min.js" type="text/javascript"></script>
        <script src="js/libs/sniui.auto-inline-help.1.0.0.min.js" type="text/javascript"></script>

        <!--Additional script-->
        <script src="js/index.js"></script>
    </body>
</html>
