<%-- 
    Document   : sessioninterest
    Created on : Jul 22, 2013, 1:21:19 PM
    Author     : 162107
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> 
<html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Techtoberfest Session Schedule</title><!-- Title -->
        <link rel="shortcut icon" type="image/png" href="http://sni-techtoberfest.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="http://sni-techtoberfest.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <style>
            .table {
                margin-bottom: 0px;
            }
            .pullRight {
                float:right;
                font-weight: normal;
                font-family: Arial;
                font-size: 11px;
                position: relative;
                top: 30px;
            }
        </style>
    </head>
    <body id="growler1">  
        <%
            int user = 0;
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
        %>
        <%
            //Get the year
            int year = 2013;
            try {
                year = Integer.parseInt(request.getParameter("year"));
            } catch (Exception e) {
            }
            SessionPersistence sp = new SessionPersistence();
            ArrayList<Session> sessions = sp.getThisYearSessions(year, " order by name ");
        %>
        <%@ include file="../../includes/header.jsp" %> 
        <%@ include file="../../includes/testnav.jsp" %>
        <div class="container-fixed largeBottomMargin">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="../../private/employee/sessionschedule.jsp">Session Schedule</a></li>
                    <li>Provide Session Interest</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1>Provide Session Interest</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dashed #ccc"></div>
            <div class="row largeBottomMargin">
                <span>Did a particular topic pique your interest?  Let us know.<br/>Simply check on the checkbox next to the session topics(s) you're interested in and press <strong>Submit Interest</strong>.</span>
            </div>
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='http://sni-techtoberfest.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class="titlespan">Session Topics</span></h2>
            </div>
            <div>
                <form id="form" method="post" action="../../action/registerinterest.jsp">
                    <div class="form-group">
                        <table class="table table-alternatingRow">
                        <% 
                        for (int i = 0; i < sessions.size(); i++){
                            if (i % 4 == 0) {
                                out.print("<tr>");
                            }
                            out.print("<td>");
                            out.print("<input type='checkbox' name='interest' value='" + sessions.get(i).getId() + "' />");
                            out.print("<input type='hidden' name='name' value='" + sessions.get(i).getId() + "' />");
                            out.print("<span>" + sessions.get(i).getName() +"</span>");
                            out.print("</td>");
                            if (i % 4 == 3) {
                                out.print("</tr>");
                            }
                        }
                        %>
                        </table>
                    </div>
                    <div class="form-actions">
                        <input type="submit" class="button button-primary" value="Submit Interest"/>
                        <a href="../../private/employee/sessionschedule.jsp">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
        <%@ include file="../../includes/footer.jsp" %>
</html>
