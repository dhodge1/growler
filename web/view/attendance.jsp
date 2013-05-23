<%-- 
    Document   : attendance
    Created on : Apr 17, 2013, 10:48:45 PM
    Author     : Justin Bauguess
    Purpose    : This will display a list of active sessions a user can attend.
                (Initially, it will display a list of all previous sessions.)
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.*"%>
<%@page import="com.scripps.growler.*" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> 
<html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>Session Attendance</title><!-- Title -->
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="draganddrop.css" /><!--Drag and drop style-->
        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%@ include file="../includes/header.jsp" %>
        <%@ include file="../includes/usernav.jsp" %>
        <div class="row">
            <div class="span3">
                <img class="logo" src="../images/Techtoberfest2013small.png" alt="Techtoberfest 2013 small"/><!-- Techtoberfest logo-->
            </div>
        </div>
        <div class="row">
            <div class="span7 offset3 largeBottomMargin">
                <h1 class="bordered">Attend a Session</h1>
                <%
                    String message = String.valueOf(session.getAttribute("message"));
                    if (!message.equals("null")) {
                        out.print("<p class=feedbackMessage-info>" + message + "</p>");
                        session.removeAttribute("message");
                    }
                %>
                <p>Enter a key, provided by the speaker, and click on the "Attend" link to register your attendance.</p>
                <p>If you do this, you will be registered to win a fantastic prize.</p>
                <p>You will also receive a notification to complete a survey rating the session.</p>
            </div>
        </div>
        <div class="container-fluid">
            <div class="content">
                <!-- Begin Content -->
                <div class="row"><!--row-->
                    <div class="span6 offset3"><!--span-->
                        <div id="tabs-1">
                            <div class="row">
                                <div class="span1">
                                    <br/>					

                                </div>
                                <div class="span6 offset1">
                                    <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                                        <tr>
                                            <th>Name</th>
                                            <th>Date</th>
                                            <th>Time</th>
                                            <th>Key</th>
                                            <th>Register</th>
                                        </tr>
                                        <%
                                            Calendar today = Calendar.getInstance();
                                            String date = today.get(Calendar.YEAR) + "-" + (today.get(Calendar.MONTH) + 1) + "-" + today.get(Calendar.DATE);
                                            String time = today.get(Calendar.HOUR) + ":" + today.get(Calendar.MINUTE) + ":" + today.get(Calendar.SECOND);
                                            Connection connection = dataConnection.sendConnection();
                                            Statement statement = connection.createStatement();
                                            //Select sessions that are today, before the current time
                                            ResultSet result = statement.executeQuery("select id, name, session_date, start_time from session where session_date = '"
                                                    + date + "' and start_time > '" + time + "'");
                                            while (result.next()) {
                                        %>
                                        <tr>
                                            <td><% out.print(result.getString("name"));%>
                                                <input type="hidden" name="session" value="<% out.print(result.getInt("id"));%>"/></td>
                                            <td><% out.print(result.getDate("session_date"));%></td>
                                            <td><% out.print(result.getTime("start_time"));%></td>
                                            <td><input type="text" name="key"/></td>
                                            <td><% out.print("<a href=\"../model/processattendance.jsp?session=" + result.getInt("id") + "\">" + "Attend</a>");%></td>
                                        </tr>
                                        <%
                                            }
                                            result.close();
                                            statement.close();
                                            connection.close();
                                        %>
                                    </table>
                                    </form>
                                </div>
                                <br/>
                            </div>
                        </div>
                    </div><!--end span-->
                </div><!--end row-->
            </div><!-- End Content -->
        </div><!--/.container-fluid-->
        <%@ include file="../includes/footer.jsp" %> 
        <%@ include file="../includes/scriptlist.jsp" %>
        <%@ include file="../includes/draganddrop.jsp" %>
    </body>
</html>