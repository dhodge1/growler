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
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
            <%
                    int user = 0;
                    if (null == session.getAttribute("id")) {
                        response.sendRedirect("../index.jsp");
                    }
                    else if (!session.getAttribute("user").equals("admin")) {
                        response.sendRedirect("../index.jsp");
                    }
                    try {
                        user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                        String name = String.valueOf(session.getAttribute("user"));                  
                    }
                    catch (Exception e) {
                        
                    }
                %>
        <%@ include file="../includes/header.jsp" %> 
        <%@ include file="../includes/adminnav.jsp" %>
        <div class="row">
            <div class="span3">
                <img class="logo" src="../images/Techtoberfest2013admin.png" alt="Techtoberfest 2013 admin"/>
            </div>
            <br/>
            <div class="span5">
                <h1 class = "bordered largeBottomMargin">Remove a Speaker from a Session</h1>
            </div>
        </div>
        <div class="container-fixed">
            <div class="content">
                <!-- Begin Content -->
                <div class="row">

                    <div class="span10 offset1">
                        <%@include file="../includes/messagehandler.jsp" %>
                        <section>
                            <%
                                int sessionId = Integer.parseInt(request.getParameter("sessionId"));
                                SessionPersistence sessionPersist = new SessionPersistence();
                                SpeakerPersistence speakerPersist = new SpeakerPersistence();
                                
                                
                            %>
                            <form id="action" action="../model/processSpeakerRemove.jsp" method="post" onsubmit="return validateForm();">
                                <div class="form-group">
                                    <label>Session Name:</label>
                                    <label><% out.print(sessionPersist.getSessionByID(sessionId).getName()); %></label>
                                    <input type="hidden" name="sessionId" value="<% out.print(sessionId); %>"/>
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
                                    <a id="cancel" class="button" href="../admin/session.jsp">Cancel</a>
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
                                            $("#action").attr("action", "../model/processSpeakerRemove.jsp");
                                        }
                                    });
                                });
        </script>
    </body>
</html>
