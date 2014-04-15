<%-- 
    Document   : volunteerSignUp.jsp
    Created on : Apr 5, 2014, 11:01:09 PM
    Author     : Shaun
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>Volunteer Sign-up</title><!-- Title -->
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
        <style>
            .divider {
                margin-right: 12px;
            }
            input[type="radio"] {
                position:relative;
                bottom: 5px;
                margin-right: 6px;
            }
            h1 {
                font-weight: normal;
            }
            .errors {
                display: none;
            }
            .errorsquestion {
                color: red;
                font-weight: bold;
            }
        </style>
        <script>
            (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
            })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

            ga('create', 'UA-41279528-6', 'scrippsnetworks.com');
            ga('send', 'pageview');
        </script>
    </head>
    <body id="growler1">
        <%
            
            int user = 0;
            if (null == session.getAttribute("id")) {
                response.sendRedirect("http://sniforms.scrippsnetworks.com/siteminderagent/sniforms/logout.html");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
            
            /**
             * Need to add my own check here for Volunteer sign up
            SurveyPersistence survP = new SurveyPersistence();
            int surveyCheck = survP.mealSurveyCheck(Integer.parseInt(String.valueOf(session.getAttribute("id"))));
            if (surveyCheck == 1) {
                response.sendRedirect("mealTaken");
            }
            **/
        %>
        <%@ include file="../../includes/header.jsp" %> 
        <% if (String.valueOf(session.getAttribute("role")).equals("admin")) { %>
            <%--<jsp:include page="../../includes/supernav.jsp" flush="true"/>--%>
            <%@ include file="../../includes/supernav.jsp" %>
        <% } else {%>
            <%--<jsp:include page="../../includes/testnav.jsp" flush="true"/>--%>
            <%@ include file="../../includes/testnav.jsp" %>
        <% } %>
        <%--<%@ include file="../../includes/testnav.jsp" %>--%>
        <div class="container-fixed">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li class='ieFix'>Submit Volunteer Interest</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="margin-top:0px;font-weight: normal;">Volunteer Sign-Up</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>Use this form to express interest in volunteering to help with preparation and operation of Techtoberfest events.</h3>
            </div>
            <div class="row mediumBottomMargin">
                <label><span style="color: red;">*</span>Required field</label>
            </div>
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='${pageContext.request.contextPath}/images/Techtoberfest2013small.png'/><span style="padding-left: 12px;">Volunteer Survey</span></h2>
            </div>
            <div id="survey" class="largeBottomMargin row">
                <form method="post" action="${pageContext.request.contextPath}/action/processVolSignUp.jsp">
                    <table class="table" style="margin-left: -8px;">
                        <tr>
                            <td><label>What tasks can you help with?</label>
                            <p>We need: room hosts, room volunteers, hallway monitors, plants, volunteers to clean up, volunteers to setup, & event planners</p></td>
                        </tr>
                        <tr>
                            <td><textarea maxlength="250" cols="100" rows="5" name="tasks" id="comment"></textarea></td>
                        </tr>
                        
                        <tr>
                            <td><label>What times are you available?</label>
                                <p>Event runs between 8AM-6PM October 10th-11th </p></td>
                        </tr>
                        <tr>
                            <td><textarea maxlength="250" cols="100" rows="5" name="times" id="comment"></textarea></td>
                        </tr>
                    </table>
                    <div class="form-actions" style="padding-top: 12px;">
                        <input class="button button-primary" type="submit" id="send" value="Submit"/>
                    </div>
                </form>
            </div>
        </div>
        <%@ include file="../../includes/footer.jsp" %>
    </body>
</html>
