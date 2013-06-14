<%-- 
    Document   : processattendance
    Created on : Apr 17, 2013, 11:00:30 PM
    Author     : Justin Bauguess
    Purpose    : Adds the record of attendance
                 into the database.
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
<%@page import="com.scripps.growler.SessionPersistence" %>
<%@page import="com.scripps.growler.Session" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page" />
<!DOCTYPE html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> 
<html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>Growler Project</title><!-- Title -->
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="css/draganddrop.css" /><!--Drag and drop style-->
        <script src="js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body>
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
        <%
            Calendar today = Calendar.getInstance();
            String date = today.get(Calendar.YEAR) + "-" + (today.get(Calendar.MONTH) + 1) + "-" + today.get(Calendar.DATE);
            String time = today.get(Calendar.HOUR) + ":" + today.get(Calendar.MINUTE) + ":" + today.get(Calendar.SECOND);
            int sessionId = Integer.parseInt(request.getParameter("session"));
            String key = request.getParameter("skey");

            boolean success = false;

            Connection connection = dataConnection.sendConnection();
            Statement statement = connection.createStatement();
            //Ensure time is still current, so user didn't just leave page up to enter erroneous data
            int duration = 0;
            ResultSet durRes = statement.executeQuery("select duration from session where id = " + sessionId);
            while (durRes.next()) {
                duration = durRes.getInt("duration");
            }
            //Convert the duration into a usable format
            int hours = duration / 60;
            int minutes = duration % 60;
            String durString = hours + ":" + minutes + ":" + "00";
            Calendar cal = Calendar.getInstance();
            SimpleDateFormat df = new SimpleDateFormat("HH:mm:ss");
            java.util.Date d = df.parse(durString);
            cal.setTime(d);
            //Add 15 minutes to the end of the session
            cal.add(Calendar.MINUTE, 15);
            durString = cal.get(Calendar.HOUR) + "0:" + cal.get(Calendar.MINUTE) + ":0" + cal.get(Calendar.SECOND);;
            //Query against the end of a session + the 15 minutes
            ResultSet result = statement.executeQuery("select id, name from session where session_date = curdate() and addtime(start_time, duration) <= curtime() and addtime(addtime(start_time,duration), '00:15:00') >= curtime() and id = " + sessionId);
            result.next();
            int check = result.getInt(1);
            if (check == 0) {
                session.setAttribute("message", "Error: Too late to acknowledge for this session");
            } else {
                //Ensure the key matches
                Statement newStatement = connection.createStatement();
                ResultSet keycheck = newStatement.executeQuery("select count(id) from session where session_key = '" + key + "'");
                keycheck.next();
                if (keycheck.getInt(1) == 0) {
                    session.setAttribute("message", "Error: Invalid Session Key");
                } else {
                    //Prevent the same time slot registration
                    ResultSet duplicate = statement.executeQuery("select count(a.session_id) from attendance a, session s where a.user_id = " + user + " and s.start_time = (select start_time from session where id = " + sessionId + ") and s.session_date = curdate() and a.session_id = s.id");
                    duplicate.next();
                    int check2 = duplicate.getInt(1);
                    if (check2 == 0) {
                        //if there aren't any sessions there, add attendance record to DB
                        statement.execute("insert into attendance (user_id, session_id, isSurveyTaken, surveySubmitTime) values ("
                                + user + ", " + sessionId + ", false, null)");
                        session.setAttribute("message", "Success: Sucessfully acknowledged!");
                        SessionPersistence sp = new SessionPersistence();
                        session.setAttribute("sessionName", sp.getSessionByID(sessionId).getName());
                        session.setAttribute("page", "../view/attendance.jsp");
                        success = true;


                    } else {
                        session.setAttribute("message", "Error: Already registered in that time slot!");


                    }
                    duplicate.close();
                }
            }

            connection.close();
            statement.close();
            result.close();
            if (success) {
                response.sendRedirect("../model/emailer.jsp?session=" + sessionId);
            } else {
                response.sendRedirect("../view/attendance.jsp");
            }
        %>
        <%@ include file="../includes/scriptlist.jsp" %>

    </body>
</html>