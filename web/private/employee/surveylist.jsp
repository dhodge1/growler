<%-- 
    Document   : surveylist
    Created on : Apr 25, 2013, 7:15:03 PM
    Author     : Justin Bauguess
    Purpose    : List the surveys for sessions a user has attended
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page" />
<jsp:useBean id="giveStars" class="com.scripps.growler.GiveStars" scope="page" />
<jsp:useBean id="persist" class="com.scripps.growler.AttendancePersistence" scope="page" />
<jsp:useBean id="spersist" class="com.scripps.growler.SessionPersistence" scope="page" />
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
        <meta name="description" content="" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <title>Survey</title><!-- Title -->

        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="../../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../../css/demo.css" />  
        <link rel="stylesheet" href="../../css/draganddrop.css" /><!--Drag and drop style-->
        <link rel="stylesheet" type="text/css" href="../../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="../../css/survey.css" /><!--Survey CSS-->
        <link rel="stylesheet" href="/resources/demos/style.css" />

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
                    }
                    catch (Exception e) {
                        
                    }
                %>
        <%@ include file="../../includes/header.jsp" %> 
        <%@ include file="../../includes/testnav.jsp" %>
        <div class="container-fixed">
            <br/><br/><br/>
            <div class="row">
                <div class='span8'>
				<%
                    
                    int surveystaken = 0;
                    int surveysleft = 0;
                    ArrayList<Attendance> attendances = persist.getAttendanceByUser(user);
                    if (attendances.size() > 0) {
                        
                        for (int i = 0; i < attendances.size(); i++) {
                            if (attendances.get(i).getIsSurveyTaken() == true) {
                                surveystaken++;
                            }
                            else {
                                surveysleft++;
                            }
                        }
                        if (surveysleft == 0) {
                            out.print("<h2 class=bordered><img src='../../images/Techtoberfest2013small.png'/>You have no Surveys</h2>");
                        }
                        else {
                            out.print("<h2 class=bordered><img src='../../images/Techtoberfest2013small.png'/>You have taken " + surveystaken + " surveys and have " + surveysleft + " left to take.</h2>");
                        }
                    } else {
                        out.print("<h2 class=bordered><img src='../../images/Techtoberfest2013small.png'/>You have not attended any sessions</h2>");
                    }
                %>
                </div>
            </div>
            <br/>
            <div class="row">
                <div class="span8">
                    <form action="../../action/processsurveyrequest.jsp" method="get" >
                                            <table>
                                                <tr>
                                                    <%
                                                        if (surveysleft > 0) {
                                                        out.print("<th>Session Name</th>");
                                                         out.print("<th>Take Survey</th>");
                                                                }
                                                    %>
                                                </tr>
                                                <%
                                                    for (int i = 0; i < attendances.size(); i++) {
                                                        if (attendances.get(i).getIsSurveyTaken() == false) {

                                                            out.print("<tr>");
                                                            out.print("<td>" + spersist.getSessionByID(attendances.get(i).getSessionId()).getName() + "</td>");
                                                            out.print("<td><a href=\"survey.jsp?sessionId=" + attendances.get(i).getSessionId() + "\">Survey</a></td>");
                                                            out.print("</tr>");
                                                        } //close if statement
                                                    } //close for loop
%>
                                            </table>
                                        </form>
                </div>
            </div>
        </div>
        <br/>
        <br/>


        <%@ include file="../../includes/footer.jsp" %>
        <%@ include file="../../includes/scriptlist.jsp" %>

        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>         
    </body>
</html>