<%-- 
    Document   : removespeaker
    Created on : Jun 13, 2013, 3:41:53 PM
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
        <title>Remove a Speaker from a Session</title><!-- Title -->
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
                
                    <h2 class="bordered"><img src='../../../images/Techtoberfest2013small.png'/><span>Remove a Speaker from a Session</span></h2>
                
            </div>
            <br/>
            <div class="row">
                
                    <%
                        int sessionId = Integer.parseInt(request.getParameter("sessionId"));
                        SessionPersistence sessionPersist = new SessionPersistence();
                        SpeakerPersistence speakerPersist = new SpeakerPersistence();


                    %>
                    <form id="action" action="../../../action/processSpeakerRemove.jsp" method="post" onsubmit="return validateForm();">
                        <div class="form-group">
                            <label>Session Name:</label>
                            <label><% out.print(sessionPersist.getSessionByID(sessionId).getName());%></label>
                            <input type="hidden" name="sessionId" value="<% out.print(sessionId);%>"/>
                        </div>
                        <div class="form-group">
                            <label>Assigned Speakers:</label>
                            <select class="speaker" name="speaker">
                                <option value="0"> - Please Pick a Speaker - </option>
                                <%
                                    ArrayList<Speaker> speakers = speakerPersist.getSpeakersBySession(sessionId);
                                    //Get a list of suggested speakers
                                    for (int i = 0; i < speakers.size(); i++) {
                                        out.print("<option value=\"" + speakers.get(i).getId() + "\">" + speakers.get(i).getLastName() + ", " + speakers.get(i).getFirstName() + "</option>");
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
                                            $("#action").attr("action", "../../../action/processSpeakerRemove.jsp");
                                        }
                                    });
                                });
        </script>
    </body>
</html>
