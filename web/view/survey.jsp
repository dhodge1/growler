<%-- 
    Document   : survey
    Created on : Apr 25, 2013, 7:15:03 PM
    Author     : Justin Bauguess & Jonathan C. McCowan
    Purpose    : 
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page" />
<jsp:useBean id="giveStars" class="com.scripps.growler.GiveStars" scope="page" />
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
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/demo.css" />  
        <link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
        <link rel="stylesheet" type="text/css" href="../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="../css/survey.css" /><!--Speaker CSS-->
        <link rel="stylesheet" href="/resources/demos/style.css" />

        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%
                    int user = 0;
                    if (null == session.getAttribute("id")) {
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
        <%@ include file="../includes/usernav.jsp" %>
        <div class="row">
            <div class="span3">
                <img class="logo" src="../images/Techtoberfest2013small.png" alt="Techtoberfest 2013 small"/><!-- Techtoberfest logo-->
            </div>
            <div class="span6 largeBottomMargin">
                <%
                    String sessionId = request.getParameter("sessionId");
                    SessionPersistence sp = new SessionPersistence();
                    AttendancePersistence ap = new AttendancePersistence();
                    ArrayList<Attendance> attendances = ap.getAttendanceBySession(Integer.parseInt(sessionId));
                    for (int a = 0; a < attendances.size(); a++) {
                        if (user == attendances.get(a).getUserId() && attendances.get(a).getIsSurveyTaken() == true) {
                            session.setAttribute("message", "You have already taken this survey");
                            response.sendRedirect("../view/surveylist.jsp");
                        }
                        
                    }
                    %>
                    <h1 class = "bordered">Confidential Survey - <% out.print(sp.getSessionByID((Integer.parseInt(sessionId))).getName());%></h1>
            </div>
        </div>
        <div class="container-fluid">
            <div class="content">
                <!-- Begin Content -->
                <div class="row"><!--row-->
                            <div class="row">
                                <div class="span1">
                                    <br/>                         
                                    <%
                                        
                                        session.setAttribute("sessionId", sessionId);
                                        Connection newConnect = dataConnection.sendConnection();
                                        Statement newStatement = newConnect.createStatement();
                                        ResultSet qResult = newStatement.executeQuery("select id, text from question");
                                    %>
                                </div>
                                <div class="span6 offset2">
                                    <section>
                                        <form id="action" action="../model/processsurvey.jsp" method="post">
                                            <table>
                                                <tr>
                                                    <td>Question</td>
                                                    <td>Response</td>
                                                </tr>
                                                <%
                                                    while (qResult.next()) {
                                                %>
                                                <tr>
                                                    <td><% out.print(qResult.getString("text"));%></td>
                                                    <td>
                                                        <select class="survey" <% out.print("id = q" + qResult.getInt("id") + " name=q" + qResult.getInt("id"));%>>
                                                            <option value="0"> - Enter a Selection - </option>
                                                            <option value="1">1 - Strongly Disagree</option>
                                                            <option value="2">2 - Disagree</option>
                                                            <option value="3">3 - Neutral</option>
                                                            <option value="4">4 - Agree</option>
                                                            <option value="5">5 - Strongly Agree</option>
                                                        </select>
                                                    </td>
                                                </tr>
                                                <% }
                                                    
                                                    qResult.close();
                                                    newStatement.close();
                                                    newConnect.close();
                                                %>
                                                
                                            </table>
                                                <label>Comments:</label><br/><br/><textarea maxlength="250" cols="50" rows="5" name="comment"></textarea>
                                            <input id="send" class="button button-primary" type="submit" value="Submit Survey" />
                                        </form>
                                    </section>
                                </div>
                                <div class="span7">
                                    <p></p>
                                </div>
                            </div><!--end row-->
                        </div>
                </div><!--end row-->
                <div class="span2 offset3"><!--button div-->
                    
                
            </div><!-- End Content -->	
        </div><!--/.container-fluid-->	

        <%@ include file="../includes/footer.jsp" %>
        <%@ include file="../includes/scriptlist.jsp" %>
        <%@ include file="../includes/draganddrop.jsp" %>

        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script> 

        <!--Additional Script-->
        <script>
            $(document).ready(function(){
                $("#send").click(function(event){
                     if ($("#q1").val() == 0) {
                       alert("Please fill out all questions");
                       $("#q1").focus();
                        event.preventDefault();
                    }
                    else if ($("#q2").val() == 0) {
                       alert("Please fill out all questions");
                       $("#q2").focus();
                        event.preventDefault();
                    }
                    else if ($("#q3").val() == 0) {
                       alert("Please fill out all questions");
                       $("#q3").focus();
                        event.preventDefault();
                    }
                    else if ($("#q4").val() == 0) {
                       alert("Please fill out all questions");
                       $("#q4").focus();
                        event.preventDefault();
                    }
                    else {
                    $("#action").attr("action", "../model/processsurvey.jsp");
                     }
                });
            });
        </script>
    </body>
</html>

