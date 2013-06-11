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
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <% String user = "";
            try {
                user = String.valueOf(session.getAttribute("id"));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
            if (user == null) {
                response.sendRedirect("../index.jsp");
            }
        %>
        <%@include file="../includes/isadmin.jsp" %>
        <%@ include file="../includes/header.jsp" %> 
        <%@ include file="../includes/adminnav.jsp" %>
        <div class="row">
            <div class="span3">
                <img class="logo" src="../images/Techtoberfest2013admin.png" alt="Techtoberfest 2013 admin"/>
            </div>
            <br/>
            <div class="span5">
                <h1 class = "bordered largeBottomMargin">Assign a Suggested Speaker to a Session</h1>
            </div>
        </div>
        <div class="container-fixed">
            <div class="content">
                <!-- Begin Content -->
                <div class="row">

                    <div class="span10 offset1">
                        <%
                            //Displaying error or success messages -- clear it out when done
                            String message = (String) session.getAttribute("message");
                            if (message != null && message.startsWith("Speaker")) {
                                out.print("<p class=feedbackMessage-success>" + message + "</p>");
                                session.removeAttribute("message");
                            } else if (message != null && message.startsWith("Could")) {
                                out.print("<p class=feedbackMessage-error>" + message + "</p>");
                                session.removeAttribute("message");
                            }
                        %>
                        <section>
                            <%
                                SessionPersistence sessionPersist = new SessionPersistence();
                                SpeakerPersistence speakerPersist = new SpeakerPersistence();
                                ArrayList<Session> sessions = sessionPersist.getAllSessions(" ");
                                ArrayList<Speaker> speakers = speakerPersist.getNonDefaultSpeakers();
                            %>
                            <form id="action" action="../model/processSessionAssign.jsp" method="post" onsubmit="return validateForm();">
                                <div class="form-group">
                                    <label class="required">Session Name:</label>
                                    <select class="session" name="sessionId">
                                        <option value="0"> - Please Pick a Session - </option>
                                        <%
                                            //Get a list of all sessions
                                            for (int i = 0; i < sessions.size(); i++) {
                                                out.print("<option value=\"" + sessions.get(i).getId() + "\">" + sessions.get(i).getName() + "</option>");
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Suggested Speakers:</label>
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
                                <a href="../admin/speakerentry.jsp">Add a New Speaker</a><br/>
                                <div class="form-actions">
                                    <input id="send" type="submit" class="button button-primary" value="Submit"/>
                                </div>
                            </form>
                        </section>
                    </div>
                    <div class="span7">
                        <p></p>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Content -->

        <div class="row">
            <div class="span8">
                <p></p>
            </div>
            <div class="span2">
            </div>
        </div>

        <%@ include file="../includes/footer.jsp" %> 
        <%@ include file="../includes/scriptlist.jsp" %>
        <script>
                                $(document).ready(function() {
                                    $("#send").click(function() {
                                        if ($(".session").val() == 0) {
                                            alert("Please enter a session!");
                                            $("#action").attr("action", "");
                                        }
                                        else if ($(".speaker").val() == 0) {
                                            alert("Please enter a speaker!");
                                            $("#action").attr("action", "");
                                        }
                                        else {
                                            $("#action").attr("action", "../model/processSessionAssign.jsp");
                                        }
                                    });
                                });
        </script>
    </body>
</html>
