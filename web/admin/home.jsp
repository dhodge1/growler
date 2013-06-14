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
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/demo.css" />  
        <link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
        <link rel="stylesheet" type="text/css" href="../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="../css/theme.css" /><!--Theme CSS-->
        <link rel="stylesheet" href="/resources/demos/style.css" />

        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">    
        <%@ include file="../includes/isadmin.jsp" %> 
        <%@ include file="../includes/header.jsp" %> 
        <div class="row">
            <%@ include file="../includes/adminnav.jsp" %>
        </div>
        <div class="row"><!-- The Logo Row -->
            <div class="span3">
                <img class="logo" src="../images/Techtoberfest2013admin.png" alt="Techtoberfest 2013 admin"/><!-- Techtoberfest logo-->
            </div>
            <div class="span7 largeBottomMargin">
                <%
                    String user = "";
                    if (null == session.getAttribute("id")) {
                        response.sendRedirect("../index.jsp");
                    }
                    try {
                        user = String.valueOf(session.getAttribute("id"));
                        String name = String.valueOf(session.getAttribute("user"));                  
                    }
                    catch (Exception e) {
                        
                    }
                %>
            </div>
        </div>
        <div class="container-fluid">
            <div class="content">
                <!-- Begin Content -->
                <div class="row"><!--row-->
                    <div class="span6 offset3"><!--span-->
                        <div id="tabs-1">
                            <div class="row">
                                <div class="span6 offset1">
                                    <%@include file="../includes/messagehandler.jsp" %>
                                    <section>

                                        <h3>Themes</h3>
                                        <p>A place to edit and add Themes for this year's Techtoberfest</p>
                                        <h3>Speakers</h3>
                                        <p>A place to edit and add Speakers for this year's Techtoberfest</p>
                                        <h3>Sessions</h3>
                                        <p>A place to add and view sessions in this year's Techtoberfest</p>

                                    </section>
                                </div>
                                <div class="span3">
                                    <p></p>
                                </div>
                            </div>
                        </div>
                    </div><!--end span-->
                </div><!--end row-->
                <div class="span2 offset3"><!--button div-->

                </div>
            </div><!-- End Content -->	
        </div><!--/.container-fluid-->
        <div class="row">
            <div class="span8">
                <p></p>
            </div>
            <div class="span2">
            </div>
        </div>

        <%@ include file="../includes/footer.jsp" %>
        <%@ include file="../includes/scriptlist.jsp" %>
        <%@ include file="../includes/draganddrop.jsp" %>

        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <script src="../js/grabRanks.js"></script>

        <!--Additional Script-->
        <script>
            $(function() {
                $("#sortable").sortable({revert: true});
                $("#draggable").draggable({connectToSortable: "#sortable", helper: "clone", revert: "invalid"});
                $("ul, li").disableSelection();
            });
        </script>
    </body>
</html>

