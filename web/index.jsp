<%-- 
    Document   : index
    Created on : Feb 21, 2013, 10:09:16 PM
    Author     : Justin Bauguess and Jonathan C. McCowan
    Purpose    : The log-in area for the application.  Users are redirected here
                if their sessions expire, and also can create new accounts from 
                this page.  The final link will take a user to reset a password.
Test comment - Chelsea 22 Jan 2014 1234567
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page" />
<%@page import="com.scripps.growler.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
     if (request.getHeader("sn_employee_id") != null) {
        String first_name = request.getHeader("sn_first_name");
        String last_name = request.getHeader("sn_last_name");
        String email = request.getHeader("sn_email");
        String id = request.getHeader("sn_employee_id");
    if (!id.equals("")) {
        String name = last_name + ", " + first_name;
                UserPersistence up = new UserPersistence();
                User u = up.getUserByEmail(email);
                User newUser = new User();
                if (u != null) {
                    session.setAttribute("user", u.getUserName());
                    session.setAttribute("id", u.getCorporateId());
                    session.setAttribute("email", u.getEmail());
                    if (u.getRole().equals("admin")) {
                        session.setAttribute("role", "admin");
                    }
                } else {
                    newUser.setId(Integer.parseInt(id));
                    newUser.setCorporateId(id);
                    newUser.setUserName(name);
                    newUser.setEmail(email);
                    up.addUser(newUser);
                    session.setAttribute("user", newUser.getUserName());
                    session.setAttribute("id", newUser.getCorporateId());
                    session.setAttribute("email", newUser.getEmail());
                    if (id.equals("160240") || id.equals("160445") || id.equals("162107") || id.equals("161301")) { //if it's Ian R. or Brian S.
                        session.setAttribute("role", "admin");
                    }
                }
                response.sendRedirect("private/employee/home.jsp");
    }
     }
%>
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
        <link rel="stylesheet" href="css/prettify/prettify.css" /> 
        <link rel="stylesheet" href="css/wijmo/jquery.wijmo-complete.all.2.3.2.min.css"/>
        <link rel="stylesheet" type="text/css" href="css/general.css" /><!--General CSS-->
        <script src="js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <link rel="shortcut icon" type="image/png" href="http://growler.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <style>
            .message_container {
                display: none;
                color: red;
                font-weight: bold;
            }
            h3 {
                font-weight: normal;
            }
        </style>

    </head>
    <body id="growler1">
        <%@ include file="includes/indexheader.jsp" %> 
        <div class='row mediumBottomMargin'></div>
        <div class="container-fixed largeBottomMargin">
            <div class="row">
                <h1>Techtoberfest Information System (TIS)</h1>
                <h3>TIS allows Scripps Employees the ability to not only stay abreast 
                    of all Techtoberfest sessions, but also the opportunity to provide 
                    valuable session feedback before, during, and after the event!</h3>

            </div>
            <br/><br/><br/>
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='images/Techtoberfest2013small.png'/><span class="titlespan">Login to TIS</span></h2>
            </div>
            <div class="row">
                <%@include file="includes/messagehandler.jsp" %>
                <p id="error_global" class="message_container feedbackMessage-error">
                    <span style="color: #000">An Employee ID and Password are required.</span>
                </p>
               <!-- <form action="action/login.jsp" method="post" id="form"> -->
                <form action="https://sniforms-qa.scrippsnetworks.com/siteminderagent/portal/login.fcc" method="post" id="form"><!---->
                    <div class="form-group">
                        <label>Employee ID</label>
                        <input type="text" name="USER" id="tip" data-content="Enter your Employee ID"/><br/>
                        <input type="hidden" value="http://techtoberfest-dev.scrippsnetworks.com/private/employee/home.jsp" name="target" id="smtarget">
                        <input type="hidden" value=0 name=smauthreason>
                        <input type="hidden" name="SMAGENTNAME" value='-SM-qqTTNRp8HuVz4vfjuz8PpwRSGfFdF8v5ee9waRpRop7zciV2VtF46AXySxgHy%2bZO' />
                        <span id="error_userid" class="message_container">
                            <span>Please enter your Employee ID</span>
                        </span>
                        <label style="padding-top:12px;">Password</label>
                        <input type="password" name="PASSWORD" id="tip2" data-content="Enter your Password"/><br/>
                        <span id="error_password" class="message_container">
                            <span>Please enter your password</span>
                        </span>
                    </div>
                    <div class="form-actions">
                        <button class="button button-primary" id="send" type="submit" style="margin-right:4px;">Login</button>
                        <a href="public/requestreset.jsp">Forgot Password?</a>
                    </div>
                </form>
            </div>
        </div>
        <%@include file="includes/footer.jsp" %>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
        <script src="js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
        <script src="js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
        <script src="js/libs/sniui.auto-inline-help.1.0.0.min.js" type="text/javascript"></script>
        <!--Additional script-->
        <script src="js/index.js"></script>
        <script>$(function() {
                $("input").autoinline();
            });
           </script>
    </body>
</html>
