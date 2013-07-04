<%-- 
    Document   : registrationAttendanceReport
    Created on : Jun 14, 2013, 1:49:57 PM
    Author     : 162107
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
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

        <title>Techtoberfest Report</title>

        <link rel="stylesheet" href="../../../css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="../../../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../../../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../../../css/prettify/prettify.css" /> 
        <link rel="stylesheet" type="text/css" href="../../../css/general.css" /><!--General CSS-->

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
        <%@ include file="../../../includes/header.jsp" %> 
        <%@ include file="../../../includes/adminnav.jsp" %>  
        <div class="container-fixed">
            <br/><br/><br/>
            <div class="row">
                <div class="span8">
                    <h2 class="bordered"><img src='../../../images/Techtoberfest2013small.png'/>Registration vs. Attendance</h2>
                </div>
            </div>
            <br/>
            <div class="row">
                <div class="span8">
                    <div class="row">
                        <h2 class = "bordered largeBottomMargin">Report: Those Who Attended And Registered</h2>
                    </div>
                    <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                        <tr>                    
                            <th>Session Name</th>
                            <th>User Name</th>
                            <th>Date Registered</th>
                            <th>Survey Submitted Time</th>
                        </tr>
                        <%
                            RegistrationPersistence rp = new RegistrationPersistence();
                            ArrayList<Attendance> list = rp.getRegisteredWhoAttended();
                            UserPersistence up = new UserPersistence();
                            SessionPersistence sp = new SessionPersistence();

                            for (int i = 0; i < list.size(); i++) {
                                out.print("<tr>");
                                out.print("<td>");
                                out.print(sp.getSessionByID(list.get(i).getSessionId()).getName());
                                out.print("</td>");
                                out.print("<td>");
                                out.print(up.getUserByID(list.get(i).getUserId()).getUserName());
                                out.print("</td>");
                                out.print("<td>");
                                out.print(list.get(i).getDateRegistered());
                                out.print("</td>");
                                out.print("<td>");
                                java.sql.Timestamp surveyTime = list.get(i).getSurveySubmitTime();
                                if (surveyTime == null) {
                                    out.print("No Survey Taken");
                                } else {
                                    out.print(surveyTime);
                                }
                                out.print("</td>");
                                out.print("</tr>");
                            }
                        %>
                    </table>
                    <div class="row">
                        <h2 class = "bordered largeBottomMargin">Report: Those Who Attended But Didn't Register</h2>
                    </div>
                    <div class="row">
                        <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                            <tr>                    
                                <th>Session Name</th>
                                <th>User Name</th>
                                <th>Survey Submitted Time</th>
                            </tr>
                            <%
                                list = rp.getAttendedWhoDidNotRegister();

                                for (int i = 0; i < list.size(); i++) {
                                    out.print("<tr>");
                                    out.print("<td>");
                                    out.print(sp.getSessionByID(list.get(i).getSessionId()).getName());
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print(up.getUserByID(list.get(i).getUserId()).getUserName());
                                    out.print("</td>");
                                    out.print("<td>");
                                    java.sql.Timestamp surveyTime = list.get(i).getSurveySubmitTime();
                                    if (surveyTime == null) {
                                        out.print("No Survey Taken");
                                    } else {
                                        out.print(surveyTime);
                                    }
                                    out.print("</td>");
                                    out.print("</tr>");
                                }
                            %>
                        </table>
                    </div>
                    <div class="row">
                        <h2 class = "bordered largeBottomMargin">Report: Those Who Registered But Didn't Attend</h2>
                    </div>
                    <div class="row">
                        <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                            <tr>                    
                                <th>Session Name</th>
                                <th>User Name</th>
                                <th>Date Registered</th>
                            </tr>
                            <%
                                list = rp.getRegisteredWhoDidNotAttend();

                                for (int i = 0; i < list.size(); i++) {
                                    out.print("<tr>");
                                    out.print("<td>");
                                    out.print(sp.getSessionByID(list.get(i).getSessionId()).getName());
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print(up.getUserByID(list.get(i).getUserId()).getUserName());
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print(list.get(i).getDateRegistered());
                                    out.print("</td>");
                                    out.print("</tr>");
                                }
                            %>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="../../../includes/footer.jsp" %> 
        <%@ include file="../../../includes/scriptlist.jsp" %>
    </body>
</html>
