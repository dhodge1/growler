<%-- 
    Document   : home
    Created on : May 31, 2013
    Author     : Justin Bauguess
    Purpose    : Serves as a launch page for the rest of the application
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<%
            if (request.getHeader("sn_employee_id") != null) {
                String first_name = request.getHeader("sn_first_name");
                String last_name = request.getHeader("sn_last_name");
                String email = request.getHeader("sn_email");
                String id = request.getHeader("sn_employee_id");
                String name = last_name + ", " + first_name;
                UserPersistence up = new UserPersistence();
                User u = up.getUserByEmail(email);
                User newUser = new User();
                if (u != null) {
                    session.setAttribute("user", u.getUserName());
                    session.setAttribute("id", u.getCorporateId());
                    if (u.getRole().equals("admin")) {
                        session.setAttribute("role", "admin");
                        response.sendRedirect("../../private/employee/admin/home.jsp");
                    }
                } else if (!id.equals(null) || !id.equals("null")) {
                    newUser.setId(Integer.parseInt(id));
                    newUser.setCorporateId(id);
                    newUser.setUserName(name);
                    newUser.setEmail(email);
                    up.addUser(newUser);
                    session.setAttribute("user", newUser.getUserName());
                    session.setAttribute("id", newUser.getCorporateId());
                    if (id.equals("160240") || id.equals("160445") || id.equals("162107")) { //if it's Ian R. or Brian S.
                        session.setAttribute("role", "admin");
                        //response.sendRedirect("../../private/employee/admin/home.jsp");
                    }
                }
            }
        %>
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
        <link rel="shortcut icon" type="image/png" href="http://growler-dev.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="../../css/bootstrap.css"/>
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://growler-dev.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <script src="http://growler-dev.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <style>
            .carousel {
                box-shadow: 1px 1px 7px 7px #ccc;
                -webkit-box-shadow: 1px 1px 7px 7px #ccc;
                filter:
                    progid:DXImageTransform.Microsoft.Shadow(color=#CCCCCC,direction=0,strength=5),
                    progid:DXImageTransform.Microsoft.Shadow(color=#CCCCCC,direction=45,strength=2),
                    progid:DXImageTransform.Microsoft.Shadow(color=#CCCCCC,direction=90,strength=5),
                    progid:DXImageTransform.Microsoft.Shadow(color=#CCCCCC,direction=135,strength=5),
                    progid:DXImageTransform.Microsoft.Shadow(color=#CCCCCC,direction=180,strength=10),
                    progid:DXImageTransform.Microsoft.Shadow(color=#CCCCCC,direction=225,strength=5),
                    progid:DXImageTransform.Microsoft.Shadow(color=#CCCCCC,direction=270,strength=5),
                    progid:DXImageTransform.Microsoft.Shadow(color=#CCCCCC,direction=315,strength=2);
            }
            .carousel-caption {
                position: absolute;
                margin-left: auto;
                margin-right:auto;
                opacity: 50%;
            }
            #this-carousel-id{
                height:350px;
                width:900px;
                margin-left: auto;
                margin-right: auto;
            }
            .carousel .item {
                height:350px;
                width:900px;
            }
            .carousel .item .active {
                height:350px;
                width:900px
            }
            .carousel-indicators li {
                background: #c0c0c0;
            }
            .carousel-indicators .active {
                background: #333333;
            }
            .carousel-text {
                color: #fff;
            }
            .carousel-indicators.middle {
                left: 0;
                right: 0;
                top: auto;
                bottom: 3px;
                text-align: center;
            }
            .carousel-indicators.middle li {
                float: none;
                display: inline-block;
            }
            h1,h3 {
                text-align: center;
                color:#333;
                font-family: Arial, Helvetica, sans-serif;
            }
            .c_img {
                margin-left: auto;
                margin-right:auto;
            }
        </style>
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
            } catch (Exception e) {
            }
        %>
        <div class="container-fixed largeBottomMargin">
            <div class="row mediumBottomMargin"></div>
            <div class="row mediumBottomMargin">
                <h1>Welcome to the 2013 Techtoberfest Information System!</h1>
            </div>
            <div class="row largeBottomMargin">
                <div id="this-carousel-id" class="carousel slide">
                    <ol class="carousel-indicators middle">
                        <li data-target="#this-carousel-id" data-slide-to="0" class="active"></li>
                        <li data-target="#this-carousel-id" data-slide-to="1"></li>
                        <li data-target="#this-carousel-id" data-slide-to="2"></li>
                    </ol>
                    <div class="carousel-inner">
                        <div class="item active">
                            <img class='c_img' src="../../images/Techtoberfest2013large.png"/>
                            <div class="carousel-caption"><h3 class="carousel-text">In October, the Knoxville office will host its fourth annual "Techtoberfest", a gathering of Scripps Networks Interactive employees from around the globe, sharing the present and future technology within our company via a series of amazing presentations.</h3></div>
                        </div>
                        <div class="item">
                            <img  class='c_img' src="../../images/slider_image1.png"/>
                            <div class="carousel-caption"><h3 class="carousel-text">All feedback is encouraged to ensure this years event goes off without a hitch!  From user rankings to suggestions, the Techtoberfest Information System (TIS) is here to ensure your voice is heard before, during and after the Techtoberfest 2013 ends.</h3></div>                            
                        </div>
                        <div class="item">
                            <img class='c_img' src="../../images/slider_image2.png"/>
                            <div class="carousel-caption"><h3 class="carousel-text">For this year's Techtoberfest, even though no registration is required, we encourage employees to provide their level of interest for any/all desired presentation sessions.  There will even be surveys available for those wanting to provide feedback regarding sessions they have attended.</h3></div>
                        </div>
                    </div><!-- .carousel-inner -->
                    <!--  next and previous controls here
                          href values must reference the id for this carousel -->
                    <!--<a class="carousel-control left" href="#this-carousel-id" data-slide="prev">&lsaquo;</a>
                    <a class="carousel-control right" href="#this-carousel-id" data-slide="next">&rsaquo;</a>-->
                </div>
            </div>
            <div class="row largeBottomMargin"></div>
            <div class="row">
                <%@include file="../../includes/messagehandler.jsp" %>
                <%
                    Calendar today = Calendar.getInstance();
                    if (today.get(Calendar.MONTH) <= 7) { //if it's August
%>
                <%@include file="../../includes/august_home.jsp" %>
                <%                        } else {
                %>
                <%@include file="../../includes/september_home.jsp" %>
                <%                            }
                %>
            </div>
        </div>
        <%@ include file="../../includes/footer.jsp" %>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="js/jquery-1.7.2.min.js"><\/script>')</script>
        <!-- Bootstrap jQuery plugins compiled and minified -->
        <script src="../../js/bootstrap.min.js"></script>
        <script src="../../js/collapse.min.js"></script>
        <script src="../../js/bootstrap-carousel.js"></script>
        <script src="../../js/bootstrap-transition.js"></script>
        <script>
            $(document).ready(function() {
                $('.carousel').carousel({
                    interval: 10000
                });
            });
        </script>
    </body>
</html>

