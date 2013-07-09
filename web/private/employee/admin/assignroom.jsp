<%-- 
    Document   : assignroom
    Created on : Jun 11, 2013, 2:23:20 PM
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
        <title>Assign a Room to a Session</title><!-- Title -->
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
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../../../index.jsp");
            } else if (!session.getAttribute("user").equals("admin")) {
                response.sendRedirect("../../../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
        %>

        <%@ include file="../../../includes/adminheader.jsp" %> 
        <%@ include file="../../../includes/adminnav.jsp" %>
        <div class="container-fixed">
            <br/><br/><br/>
            <div class="row">
                
                    <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;width:165px;" src='../../../images/Techtoberfest2013small.png'/><span class="titlespan">Assign Room To Session</span></h2>
                
            </div>
            <br/>
            <div class="row">
                
                    <%
                        SessionPersistence sessionPersist = new SessionPersistence();
                        LocationPersistence locationPersist = new LocationPersistence();
                        ArrayList<Session> sessions = sessionPersist.getThisYearSessions(2013);
                        ArrayList<Location> locations = locationPersist.getAllLocations();
                    %>
                    <form id="action" action="../../../action/processroomassign.jsp" method="post" onsubmit="return validateForm();">
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
                            <label>Available Rooms:</label>
                            <select class="rooms" name="roomId">
                                <option value="0"> - Please Pick a Room - </option>
                                <%
                                    //Get a list of suggested speakers
                                    for (int i = 0; i < locations.size(); i++) {
                                        out.print("<option value=\"" + locations.get(i).getId() + "\">" + locations.get(i).getDescription() + ", "
                                                + locations.get(i).getBuilding() + " Capacity: "
                                                + locations.get(i).getCapacity() + "</option>");
                                    }
                                %>
                            </select>
                        </div>
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
                                            $("#action").attr("action", "../../../action/processroomassign.jsp");
                                        }
                                    });
                                });
        </script>
    </body>
</html>

