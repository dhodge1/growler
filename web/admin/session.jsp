<%-- 
    Document   : session
    Created on : Feb 27, 2013, 11:23:26 PM
    Author     : Justin Bauguess
    Purpose    : The purpose of session(admin) is to show a list of session keys.
                The session keys are derived from using the sha1 hash algorithm
                on the session id and taking the first 4 letters.
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
        <title>Growler Project</title><!-- Title -->
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%@include file="../includes/isadmin.jsp" %>
        <%@ include file="../includes/header.jsp" %> 
        <%@ include file="../includes/adminnav.jsp" %>
        <div class="container-fixed">
            <div class="content">
                <!-- Begin Content -->
                <div class="row">
                    <div class="span12">
                        <img class="logo" src="../images/Techtoberfest2013.png" alt="Techtoberfest 2013"/>  <!-- Techtoberfest logo-->
                        <h1 class = "bordered">Sessions</h1>
                        <br/>
                        <br/>
                        <h3>Sessions</h3>
                        <%
                            //Displaying error or success messages -- clear it out when done
                            String message = (String) session.getAttribute("message");
                            if (message != null) {
                                out.print("<p>" + message + "</p>");
                                session.removeAttribute("message");
                            }
                        %>
                        <br/>
                        <div id="tabs-1">
                            <div class="row">
                                <div class="span1">
                                    <br/>
                                    <%
                                        SessionPersistence sp = new SessionPersistence();
                                        ArrayList<Session> sessions = sp.getAllSessionsWithKeys(" ");
                                    %>
                                </div>
                                <div class="span6 offset1">
                                    <section>
                                        <table>
                                            <tr>
                                                <th>Session Name</th>
                                                <th>Date</th>
                                                <th>Time</th>
                                                <th>Location</th>
                                                <th>Key</th>
                                            </tr>

                                            <%
                                                for (int i = 0; i < sessions.size(); i++) {
                                            %>
                                            <tr>
                                                <td><% out.print(sessions.get(i).getName());%>
                                                    <input name="list" type="hidden" value="<% out.print(sessions.get(i).getId());%>" />
                                                <td><% out.print(sessions.get(i).getSessionDate());%></td>
                                                <td><% out.print(sessions.get(i).getStartTime());%></td>
                                                <td><% out.print(sessions.get(i).getLocation());%></td>
                                                <td><% out.print(sessions.get(i).getKey());%></td>
                                            </tr>


                                            <% } //close for loop
%>
                                        </table>
                                    </section>
                                </div>
                                <div class="span7">
                                    <p></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End Content -->
            </div>	
        </div>
        <div class="row">
            <div class="span8">
                <p></p>
            </div>
            <div class="span2">
            </div>
        </div>

        <%@ include file="../includes/footer.jsp" %> 
        <%@ include file="../includes/scriptlist.jsp" %>
    </body>
</html>
