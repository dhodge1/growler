<%-- 
    Document   : mealSurvey
    Created on : Mar 22, 2014, 1:44:05 AM
    Author     : David
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
        <title>Submit Overall Feedback</title><!-- Title -->
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
            if (null == session.getAttribute("id") || null == session.getAttribute("role")) {
                response.sendRedirect("http://sniforms.scrippsnetworks.com/siteminderagent/sniforms/logout.html");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
            SurveyPersistence survP = new SurveyPersistence();
            int surveyCheck = survP.mealSurveyCheck(Integer.parseInt(String.valueOf(session.getAttribute("id"))));
            if (surveyCheck == 1) {
                response.sendRedirect("mealTaken");
            }
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
                    <li class='ieFix'>Submit Feedback for Meals and Happy Hour</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="margin-top:0px;font-weight: normal;">Add A Survey</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>We appreciate your feedback and want to know what you thought of the meals and happy hours. Please let us know below!</h3>
            </div>
            <div class="row mediumBottomMargin">
                <label><span style="color: red;">*</span>Required field</label>
            </div>
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='${pageContext.request.contextPath}/images/Techtoberfest2013small.png'/><span style="padding-left: 12px;">Overall Conference Feedback</span></h2>
            </div>
            <div id="survey" class="largeBottomMargin row">
                <form method="post" action="${pageContext.request.contextPath}/action/processMealSurvey.jsp">
                    <table class="table" style="margin-left: -8px;">

                        <tr>
                            <td><label>How was the quality of the food and drink?</label></td>
                            <td><div class="form-group inline">
                                    <input type="radio" value="1"  name="q1"><span class="checkbox inline divider" >Awful</span>
                                    <input type="radio" value="3"  name="q1" checked><span class="checkbox inline divider" >Ok</span>
                                    <input type="radio" value="5"  name="q1"><span class="checkbox inline" >Great</span>
                                </div></td>
                        </tr>

                        <tr>
                            <td><label>How was the selection of the food and drink?</label></td>
                            <td><div class="form-group inline">
                                    <input type="radio" value="1"  name="q2"><span class="checkbox inline divider" >Awful</span>
                                    <input type="radio" value="3"  name="q2" checked><span class="checkbox inline divider" >Ok</span>
                                    <input type="radio" value="5"  name="q2"><span class="checkbox inline" >Great</span>
                                </div></td>
                        </tr>

                        <tr>
                            <td><label>Please rate the appropriateness of the room for the meal/happy hour?</label></td>
                            <td><div class="form-group inline">
                                    <input type="radio" value="1"  name="q3"><span class="checkbox inline divider" >Awful</span>
                                    <input type="radio" value="3"  name="q3" checked><span class="checkbox inline divider" >Ok</span>
                                    <input type="radio" value="5"  name="q3"><span class="checkbox inline" >Great</span>
                                </div></td>
                        </tr>
                    </table>
                    <label>Comments:</label><textarea maxlength="250" cols="50" rows="5" name="comment" id="commentbox"></textarea>
                    <div class="form-actions" style="padding-top: 12px;">
                        <input class="button button-primary" type="submit" id="send" value="Submit"/>
                    </div>
                </form>
            </div>
        </div>
        <%@ include file="../../includes/footer.jsp" %>
    </body>
</html>
