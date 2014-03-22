<%-- 
    Document   : assignspeaker
    Created on : Jun 10, 2013, 10:52:05 AM
    Author     : 162107
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>Assign a Speaker to a Session</title><!-- Title -->
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/draganddrop.css" /><!--Drag and drop style-->
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <style>
            h1, h3 {
                font-weight: normal;
            }
            .no-close .ui-dialog-titlebar-close {
                display: none;
            }
            .keywordFilter-clear {
                cursor: pointer;
            }
            .pullRight {
                float: right;
                top:10px;
                position:relative;
            }
            #sessions {
                list-style-type: none;
                height: 345px;
                overflow-y: auto;
                border: 1px solid #ccc;
                margin:0;
                margin-bottom: 24px;
            }
            input[type="radio"] {
                position:relative;
                bottom: 5px;
                margin-right: 6px;
            }
            #additional {
                color:#0067b1;
                text-decoration: underline;
                cursor: pointer;
            }
            .modals{
                display:none;
            }
            #list {
                font-weight: bold;
            }
        </style>
    </head>
    <body id="growler1">
        <%
            int user = 0;
            int sessionPassed = 0;
            int speakerPassed = 0;
            if (null == session.getAttribute("id") || null == session.getAttribute("role")) {
                response.sendRedirect("../../../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
                sessionPassed = Integer.parseInt(request.getParameter("sessionId"));
                speakerPassed = Integer.parseInt(request.getParameter("speakerId"));
            } catch (Exception e) {
            }
        %>

        <%@ include file="../../../includes/adminheader.jsp" %> 
        <% if (String.valueOf(session.getAttribute("role")).equals("admin")) { %>
            <jsp:include page="../../../includes/supernav.jsp" flush="true"/>
        <% } else {%>
            <jsp:include page="../../../includes/adminnav.jsp" flush="true"/>
        <% } %>
        <%--<%@ include file="../../../includes/adminnav.jsp" %>--%>
        <div class="container-fixed">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li class='ieFix'>Assign A Speaker</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="margin-top:0px;font-weight: normal;">Assign A Speaker</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>To assign a speaker to a session, choose an available session from the list and press the <strong>Assign</strong> button.</h3>
            </div>
            <!--<div class='row largeBottomMargin'></div>-->
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='${pageContext.request.contextPath}/images/Techtoberfest2013small.png'/><span style="padding-left:12px;">Assign Details</span></h2>
            </div>
            <div class="row largeBottomMargin">
                    <%
                        SessionPersistence sessionPersist = new SessionPersistence();
                        SpeakerPersistence speakerPersist = new SpeakerPersistence();
                        ArrayList<Session> sessions = sessionPersist.getThisYearSessions(2013, " order by session_date");
                        ArrayList<Speaker> speakers = speakerPersist.getNonDefaultSpeakers();
                    %>
                    <form id="action" action="${pageContext.request.contextPath}/action/processSessionAssign.jsp" method="post" onsubmit="return validateForm();">
                        <div class="form-group">
                            <label class="required">Session Name:</label>
                            <select class="session" name="sessionId">
                                <option value="0"> - Please Pick a Session - </option>
                                <%
                                    //Get a list of all sessions
                                    for (int i = 0; i < sessions.size(); i++) {
                                        out.print("<option value=\"" + sessions.get(i).getId() + "\"");
                                        if (sessions.get(i).getId() == sessionPassed) {
                                            out.print(" selected ");
                                        }
                                        out.print(">" + sessions.get(i).getName());

                                        out.print("</option>");
                                    }
                                %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label class="required">Suggested Speakers:</label>
                            <select class="speaker" name="speaker">
                                <option value="0"> - Please Pick a Speaker - </option>
                                <%
                                    //Get a list of suggested speakers
                                    for (int i = 0; i < speakers.size(); i++) {
                                        out.print("<option value=\"" + speakers.get(i).getId() + "\"");
                                        out.print(">" + speakers.get(i).getLastName() + ", " + speakers.get(i).getFirstName());
                                        out.print("</option>");
                                    }
                                %>
                            </select>
                        </div>
                            <p><a href="speakerentry.jsp">Add a New Speaker</a></p>
                        <div class="form-actions">
                            <input id="send" type="submit" class="button button-primary" value="Submit"/>
                            <a id="cancel" href="session.jsp">Cancel</a>
                        </div>
                    </form>
            </div>
        </div>

        <%@ include file="../../../includes/footer.jsp" %> 
        <%@ include file="../../../includes/scriptlist.jsp" %>
        <script>
                                $(document).ready(function() {
                                    $("#send").click(function(event) {
                                        if ($(".session").val() == 0) {
                                            alert("Please enter a session!");
                                            event.preventDefault();
                                        }
                                        else if ($(".speaker").val() == 0) {
                                            alert("Please enter a speaker!");
                                            event.preventDefault();
                                        }
                                        else {
                                            $("#action").attr("action", "../../../action/processSessionAssign.jsp");
                                        }
                                    });
                                });
        </script>
    </body>
</html>
