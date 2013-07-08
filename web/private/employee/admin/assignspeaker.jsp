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
        <link rel="stylesheet" href="../../../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../../../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../../../css/draganddrop.css" /><!--Drag and drop style-->
        <script src="../../../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%
            int user = 0;
            int sessionPassed = 0;
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../../../index.jsp");
            } else if (!session.getAttribute("user").equals("admin")) {
                response.sendRedirect("../../../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
                sessionPassed = Integer.parseInt(request.getParameter("sessionId"));
            } catch (Exception e) {
            }
        %>

        <%@ include file="../../../includes/adminheader.jsp" %> 
        <%@ include file="../../../includes/adminnav.jsp" %>
        <div class="container-fixed">
            <br/><br/><br/>
            <div class="row">
                
                    <h2 class="bordered"><img src='../../../images/Techtoberfest2013small.png'/><span>Assign Speaker to Session</span></h2>
                
            </div>
            <br/>
            <div class="row">
                
                    <%
                        SessionPersistence sessionPersist = new SessionPersistence();
                        SpeakerPersistence speakerPersist = new SpeakerPersistence();
                        ArrayList<Session> sessions = sessionPersist.getThisYearSessions(2013);
                        ArrayList<Speaker> speakers = speakerPersist.getNonDefaultSpeakers();
                    %>
                    <form id="action" action="../../../action/processSessionAssign.jsp" method="post" onsubmit="return validateForm();">
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
                                        out.print("<option value=\"" + speakers.get(i).getId() + "\">" + speakers.get(i).getLastName() + ", " + speakers.get(i).getFirstName() + "</option>");
                                    }
                                %>
                            </select>
                        </div>
                        <a href="speakerentry.jsp">Add a New Speaker</a><br/>
                        <div class="form-actions">
                            <input id="send" type="submit" class="button button-primary" value="Submit"/>
                            <a id="cancel" class="button" href="session.jsp">Cancel</a>
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
