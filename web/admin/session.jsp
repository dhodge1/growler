<%-- 
    Document   : session
    Created on : Feb 27, 2013, 11:23:26 PM
    Author     : Justin Bauguess
    Purpose    : The purpose of session(admin) is to show a list of session keys.
                The session keys are derived from using the sha1 hash algorithm
                on the session id and taking the first 4 letters.
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
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="description" content="" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <title>Techtoberfest Sessions</title><!-- Title -->

        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/demo.css" />  
        <link rel="stylesheet" type="text/css" href="../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="../css/speaker.css" /><!--Survey CSS-->
        <link rel="stylesheet" href="/resources/demos/style.css" />
        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%
            int user = 0;
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../index.jsp");
            } else if (!session.getAttribute("user").equals("admin")) {
                response.sendRedirect("../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
        %>
        <%@ include file="../includes/header.jsp" %> 
        <%@ include file="../includes/adminnav.jsp" %>
        <div class="row">
            <div class="span3">
                <img class="logo" src="../images/Techtoberfest2013admin.png" alt="Techtoberfest 2013 admin"/><!-- Techtoberfest logo-->
            </div>
            <div class="span6 largeBottomMargin">
                <h1 class = "bordered">Sessions</h1>
            </div>

        </div>
        <div class="container-fluid">
            <div class="content">
                <!-- Begin Content -->
                <div class="row"><!--row-->

                    <div class="span9 offset1"><!--span-->
                        <%@include file="../includes/messagehandler.jsp" %>
                        <%
                            //Get the year
                            int year = 2013;
                            try {
                                year = Integer.parseInt(request.getParameter("year"));
                            } catch (Exception e) {
                            }
                            SessionPersistence sp = new SessionPersistence();
                            LocationPersistence lp = new LocationPersistence();
                            RegistrationPersistence rp = new RegistrationPersistence();
                            ArrayList<Session> sessions = sp.getThisYearSessions(year);
                        %>
                        <form action="session.jsp" method="post">
                            <select name="year">
                                <option value="2013">2013</option>
                                <option value="2012">2012</option>
                                <!--Provisioned for future years! -->
                            </select>
                            <input value="Change Year" type="submit" class="button button-primary"/>
                        </form>
                        <section>

                            <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                                <tr>
                                    <th>Session Name</th>
                                    <th>Description</th>
                                    <th>Date</th>
                                    <th>Time</th>
                                    <th>Duration</th>
                                    <th>Room #</th>
                                    <th>Room Name</th>
                                    <th>Building</th>
                                    <th>Capacity</th>
                                    <th>Key</th>
                                    <th>Speaker(s)</th>
                                    <th>Edit</th>
                                </tr>

                                <%
                                    SpeakerPersistence spkr = new SpeakerPersistence();
                                    for (int i = 0; i < sessions.size(); i++) {
                                %>
                                <tr>

                                    <td><% out.print(sessions.get(i).getName());%></td>
                                    <td><% try {
                                            if (!sessions.get(i).getDescription().equals(null)) {
                                                out.print(sessions.get(i).getDescription());
                                            }
                                        } catch (Exception e) {
                                            out.print("");
                                        }
                                        %></td>
                                        <td><% SimpleDateFormat dates = new SimpleDateFormat("E, MM-dd-yyyy");
                                        out.print(dates.format(sessions.get(i).getSessionDate()));%></td>
                                        <td><% SimpleDateFormat fmt = new SimpleDateFormat("h:mm a");
                                        out.print(fmt.format(sessions.get(i).getStartTime()));%></td>
                                        <td><% SimpleDateFormat fmt2 = new SimpleDateFormat("K ' hours and ' mm ' minutes'");
                                        out.print(fmt2.format(sessions.get(i).getDuration()));%></td>
                                    <td><% Location l = lp.getLocationById(sessions.get(i).getLocation());
                                            out.print(l.getId());%> </td>
                                    <td><% out.print(l.getDescription());%></td>
                                    <td><% out.print(l.getBuilding());%></td>
                                    <td><% out.print(l.getCapacity());%></td>
                                    <td><% out.print(sessions.get(i).getKey());%></td>
                                    <td>
                                        <% ArrayList<Speaker> speakers = spkr.getSpeakersBySession(sessions.get(i).getId());
                                            ListIterator<Speaker> iterator = speakers.listIterator();
                                            while (iterator.hasNext()) {
                                                Speaker s = iterator.next();
                                                out.print("<strong>" + s.getLastName() + ", " + s.getFirstName() + "</strong>");
                                                if (iterator.hasNext()) {
                                                    out.print(" and <br/>");
                                                } else {
                                                    out.print("<br/><a href=\"../admin/removespeaker.jsp?sessionId=" + sessions.get(i).getId() + "\">Remove a Speaker</a>");
                                                }
                                            }
                                            out.print("<br/><a href=\"../admin/assignspeaker.jsp?sessionId=" + sessions.get(i).getId() + "\">Assign a Speaker</a>");
                                        %>
                                    </td>
                                    <td><% out.print("<a href=\"../admin/sessionEdit.jsp?id=" + sessions.get(i).getId() + "\">Edit</a>");%></td>
                                </tr>
                                <% } //close for loop
                                %>
                            </table>


                        </section>
                    </div>
                </div><!--end row-->



            </div><!-- End Content -->	
        </div><!--/.container-fluid-->

        <%@ include file="../includes/footer.jsp" %> 
        <%@ include file="../includes/scriptlist.jsp" %>


    </body>
</html>
