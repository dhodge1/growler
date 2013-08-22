<%-- 
    Document   : home
    Created on : May 31, 2013
    Author     : Justin Bauguess
    Purpose    : Serves as a launch page for the rest of the application
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="description" content="" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Welcome to the Techtoberfest Information System!</title>
        <link rel="stylesheet" href="../../css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" type="text/css" href="../../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" href="../../../css/prettify/prettify.css" /> 
        <link rel="stylesheet" href="../../../css/wijmo/jquery.wijmo-complete.all.2.3.2.min.css"/>
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <link rel="shortcut icon" type="image/png" href="../../../images/scripps_favicon-32.ico">
        <style>
            .message_container {
                display: none;
                color: red;
                font-weight: bold;
            }
        </style>
    </head>
    <body id="growler1">
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
                    if (id.equals("160240") || id.equals("160445") || id.equals("162107") || id.equals("161301")) { //if it's Ian R. or Brian S.
                        session.setAttribute("role", "admin");
                    }
                }
                
    }
     }
%>
        <%
                    
                    if (null == session.getAttribute("id")) {
                        response.sendRedirect("../../../index.jsp");
                    }
        %>
        <%@ include file="../../../includes/header.jsp" %> 
        <%@ include file="../../../includes/adminnav.jsp" %>
        <div class="container-fixed mediumBottomMargin">
            <div class="row mediumBottomMargin"></div>
            <div class="row largeBottomMargin">
                <h1 style="margin-top:0px;font-weight: normal;">Welcome to the Techtoberfest Information System!</h1>
            </div>
            <div class="row largeBottomMargin"></div>
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='http://growler.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span style="padding-left:12px;">Administration Details</span></h2>
            </div>
            <div class="row">
                <h3>Themes Menu</h3>
                <p>This section allows you to manage new and existing themes.</p>

                <h3>Speakers Menu</h3>
                <p>This section allows you to manage new and existing speakers, including assigning speakers to sessions.</p>

                <h3>Sessions Menu</h3>
                <p>This section allows you to manage and view the latest sessions.</p>

                <h3>Rooms Menu</h3>
                <p>This section allows you to manage room assignments for each session.</p>

                <h3>Reports Menu</h3>
                <p>This section allows you to view real-time Techtoberfest reports.</p>
            </div>
        </div>
        <%@ include file="../../../includes/footer.jsp" %> 
    </body>
</html>