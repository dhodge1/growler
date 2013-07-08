<%-- 
    Document   : sessionScheduler
    Created on : Jun 24, 2013, 10:33:37 AM
    Author     : 162107
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

        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <link rel="stylesheet" href="/resources/demos/style.css" /> 
        <link rel="stylesheet" href="../../../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../../../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="../../../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <script>
            $(document).ready(function() {
                $("select").change(function() {
                    var current = $(this);
                    $("select").each(function() {
                        if (($(this).val() === current.val()) && ($(this).val() !== "0") && !$(this).is(current)) {
                            alert('That Session has already been scheduled!');
                            $(this).focus();
                            $(this).val('0');
                        }
                    });

                });
            });

        </script>
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
                
                    <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;width:200px;" src='../../../images/Techtoberfest2013small.png'/><span class="titlespan">Session Scheduler Tool</span></h2>
                
            </div>
            <br/>
            <div class="row">
                
                    <%
                        SimpleDateFormat dates = new SimpleDateFormat("E, MM-dd-yyyy");
                        SimpleDateFormat fmt = new SimpleDateFormat("h:mm a");
                        SimpleDateFormat fmt2 = new SimpleDateFormat("K ' hours and ' mm ' minutes'");

                        SessionPersistence sp = new SessionPersistence();
                        LocationPersistence lp = new LocationPersistence();
                        ArrayList<Session> day1 = sp.getSessionsByDate(1, "");
                        ArrayList<Session> day2 = sp.getSessionsByDate(2, "");
                        ArrayList<Session> noDay = sp.getSessionsWithoutADate();
                    %>
                    <form id="myform" action="../../../action/processScheduler.jsp" method="post">
                        <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                            <tr>
                                <th>Time</th>
                                <th>10/17/2013: E130</th>
                                <th>10/17/2013: D304</th>
                                <th>10/18/2013: E130</th>
                                <th>10/18/2013: D304</th>
                            </tr>
                            <%
                                java.sql.Time start = java.sql.Time.valueOf("07:00:00");
                                ArrayList<Session> sessions = sp.getThisYearSessions(2013);

                                for (int i = 0; i < 11; i++) {
                                    out.print("<tr>");
                                    out.print("<td>");
                                    start.setHours(start.getHours() + 1);
                                    out.print(fmt.format(start));
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print("<select name=\"list1\" title=\"" + start + "\" onChange=\"updateSessionList(this)\">");
                                    out.print("<option value=\"0\">NO SESSION</option>");
                                    Session current = sp.getSessionByDateAndTime(java.sql.Date.valueOf("2013-10-17"), start, " ");
                                    for (int j = 0; j < sessions.size(); j++) {
                                        out.print("<option  value=\"" + sessions.get(j).getId() + "\"");
                                        if ((sessions.get(j).getId() == current.getId()) && (sessions.get(j).getLocation().equals("E130"))) {
                                            out.print(" selected >");
                                        } else {
                                            out.print(">");
                                        }
                                        out.print(sessions.get(j).getName() + "</option>");
                                    }
                                    out.print("</select>");
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print("<select name=\"list2\" title=\"" + start + "\" onChange=\"updateSessionList(this)\">");
                                    out.print("<option value=\"0\">NO SESSION</option>");
                                    current = sp.getSessionByDateAndTime(java.sql.Date.valueOf("2013-10-17"), start, " ");
                                    for (int j = 0; j < sessions.size(); j++) {
                                        out.print("<option value=\"" + sessions.get(j).getId() + "\"");
                                        if ((sessions.get(j).getId() == current.getId()) && (sessions.get(j).getLocation().equals("D304"))) {
                                            out.print(" selected >");
                                        } else {
                                            out.print(">");
                                        }
                                        out.print(sessions.get(j).getName() + "</option>");
                                    }
                                    out.print("</select>");
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print("<select name=\"list3\" title=\"" + start + "\" onChange=\"updateSessionList(this)\">");
                                    out.print("<option value=\"0\">NO SESSION</option>");
                                    current = sp.getSessionByDateAndTime(java.sql.Date.valueOf("2013-10-18"), start, " ");
                                    for (int j = 0; j < sessions.size(); j++) {
                                        out.print("<option value=\"" + sessions.get(j).getId() + "\"");
                                        if ((sessions.get(j).getId() == current.getId()) && (sessions.get(j).getLocation().equals("E130"))) {
                                            out.print(" selected >");
                                        } else {
                                            out.print(">");
                                        }
                                        out.print(sessions.get(j).getName() + "</option>");
                                    }
                                    out.print("</select>");
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print("<select name=\"list4\" title=\"" + start + "\" onChange=\"updateSessionList(this)\">");
                                    out.print("<option value=\"0\">NO SESSION</option>");
                                    current = sp.getSessionByDateAndTime(java.sql.Date.valueOf("2013-10-18"), start, " ");
                                    for (int j = 0; j < sessions.size(); j++) {
                                        out.print("<option value=\"" + sessions.get(j).getId() + "\"");
                                        if ((sessions.get(j).getId() == current.getId()) && (sessions.get(j).getLocation().equals("D304"))) {
                                            out.print(" selected >");
                                        } else {
                                            out.print(">");
                                        }
                                        out.print(sessions.get(j).getName() + "</option>");
                                    }
                                    out.print("</select>");

                                    out.print("</td>");
                                    out.print("</tr>");
                                }
                            %>
                        </table>
                        <% ArrayList<Session> uns = sp.getUnscheduledSessions();%>
                        <h2>Unscheduled Sessions</h2>
                        <div id="unscheduled">
                            <table>
                                <tr>
                                    <td>Name</td>
                                    <td>Description</td>
                                </tr>
                                <% for (int j = 0; j < uns.size(); j++) {
                                        out.print("<tr>");
                                        out.print("<td>");
                                        out.print(uns.get(j).getName());
                                        out.print("</td>");
                                        out.print("<td>");
                                        out.print(uns.get(j).getDescription());
                                        out.print("</td>");
                                                out.print("</tr>");
                                            }%>
                            </table>
                        </div><br/><br/>

                        <!-- <input type="submit" id="send" value="Submit Schedule" class="button button-primary"/> -->
                    </form>
                
            </div>
        </div>

        <%@ include file="../../../includes/footer.jsp" %> 
        <%@ include file="../../../includes/scriptlist.jsp" %>
        <script src="../../../js/updateSessionList.js"></script>


    </body>
</html>
