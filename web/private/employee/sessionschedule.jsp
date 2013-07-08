<%-- 
    Document   : sessionschedule
    Created on : Jun 11, 2013, 8:40:30 AM
    Author     : 162107
    Purpose    : Shows the user a schedule of the events taking place this year, 
                allowing them to register interest in any number of those events.
                Uses registerinterest.jsp to process data.
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
<!--[if gt IE 8]><!--> 
<html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Techtoberfest Session Schedule</title><!-- Title -->
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="../../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../../css/demo.css" />  
        <link rel="stylesheet" href="../../css/draganddrop.css" /><!--Drag and drop style-->
        <link rel="stylesheet" type="text/css" href="../../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="../../css/theme.css" /><!--Theme CSS-->

        <script src="../../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">  
        <%
            int user = 0;
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
        %>
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
        <%@ include file="../../includes/header.jsp" %> 
        <%@ include file="../../includes/testnav.jsp" %>
        <div class="container-fixed">
            <div class="row">
                <br/>
                    <h1>Register Interest In a Session</h1>
                    <h3>Below is a tentative list of events for this year's Techtoberfest.
                    To show interest in a session, click on the checkbox next to an event and 
                    press "Register" when you have selected the sessions you would like to attend.</h3>
                    <h3>Registering does not mean you must attend an event, just that you have
                     interest in that event.</h3>
                
            </div>
            <br/><br/><br/>
            <div class="row">
                
                    <h2 class="bordered"><img src='../../images/Techtoberfest2013small.png'/><span>View The <%= year%> Schedule</span></h2>
                
            </div>
            <br/>
            <div class="row">
                
                    <form method="post" action="../../action/registerinterest.jsp">
                        <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                            <tr>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Date</th>
                                <th>Time</th>
                                <th>Duration</th>
                                <th>Room #</th>
                                <th>Room Name</th>
                                <th>Building</th>
                                <th>Capacity</th>
                                <th>Register Interest</th>
                            </tr>
                            <%
                                for (int i = 0; i < sessions.size(); i++) {
                                    out.print("<tr>");
                                    out.print("<td>");
                                    out.print(sessions.get(i).getName());
                                    out.print("<input type=\"hidden\" value=\"" + sessions.get(i).getId() + "\" name=\"name\">");
                                    out.print("</td>");
                                    out.print("<td>");
                                    try {
                                        if (!sessions.get(i).getDescription().equals(null)) {
                                            out.print(sessions.get(i).getDescription());
                                        }
                                    } catch (Exception e) {
                                        out.print(" ");
                                    }
                                    out.print("</td>");
                                    out.print("<td>");
                                    SimpleDateFormat dates = new SimpleDateFormat("E, MM-dd-yyyy");
                                    out.print(dates.format(sessions.get(i).getSessionDate()));
                                    out.print("</td>");
                                    out.print("<td>");
                                    SimpleDateFormat fmt = new SimpleDateFormat("h:mm a");
                                    try {
                                        out.print(fmt.format(sessions.get(i).getStartTime()));
                                    } catch (Exception e) {
                                        out.print("No Time");
                                    }
                                    out.print("</td>");
                                    out.print("<td>");
                                    SimpleDateFormat fmt2 = new SimpleDateFormat("K ' hours and ' mm ' minutes'");
                                    out.print(fmt2.format(sessions.get(i).getDuration()));
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print(lp.getLocationById(sessions.get(i).getLocation()).getId());
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print(lp.getLocationById(sessions.get(i).getLocation()).getDescription());
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print(lp.getLocationById(sessions.get(i).getLocation()).getBuilding());
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print(lp.getLocationById(sessions.get(i).getLocation()).getCapacity());
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print("<input id=\"" + sessions.get(i).getId() + "\" type=\"checkbox\" value=\"" + sessions.get(i).getId() + "\" name=\"interest\"");
                                    if (rp.isUserRegistered(user, sessions.get(i).getId())) {
                                        out.print(" checked ");
                                    }
                                    out.print(">");
                                    out.print("</td>");
                                    out.print("</tr>");
                                }
                            %>
                        </table>
                        <div class="form-actions">
                            <input value="Register" id="send" type="submit" class="button button-primary"/>
                        </div>
                    </form>
                
            </div>
        </div>
        <br/>
        <br/>

        <%@ include file="../../includes/footer.jsp" %>
        <%@ include file="../../includes/scriptlist.jsp" %>
    </body>
</html>


