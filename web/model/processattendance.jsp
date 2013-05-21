<%-- 
    Document   : processattendance
    Created on : Apr 17, 2013, 11:00:30 PM
    Author     : Justin Bauguess
    Purpose    : Adds the record of attendance
                 into the database.
--%>
<%@page import="com.sun.org.apache.regexp.internal.REUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
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
        Calendar today = Calendar.getInstance();
        String date = today.get(Calendar.YEAR) + "-" + (today.get(Calendar.MONTH)+1) + "-" + today.get(Calendar.DATE);
        String time = today.get(Calendar.HOUR) + ":" + today.get(Calendar.MINUTE) + ":" + today.get(Calendar.SECOND);
        String sessionId = request.getParameter("session");
        String key = request.getParameter("key");
        String user = String.valueOf(session.getAttribute("id"));
        
        
        Connection connection = dataConnection.sendConnection();
        Statement statement = connection.createStatement();
        //Ensure time is still current, so user didn't just leave page up to enter erroneous data
        ResultSet result = statement.executeQuery("select id, name from session where (select addtime(start_time, '00;15:00') from " + 
                "session where id = '" + sessionId + "') < '" + time + "' and " +
                " session_date = '" + date + "' and survey_key = '" + key + "'");
        
        if(result.first()) {
            session.setAttribute("message", "Invalid Session Key for session " + sessionId);
                   }
               else {
            
            //Prevent the same time slot registration
            ResultSet duplicate = statement.executeQuery("select a.session_id from attendance a, session s where " +
                    "a.user_id = " + user + " and s.start_time = (select start_time from session where id = " + sessionId +
                    " ) and s.session_date = '" + date + "'");
            if (!duplicate.first()){
                //if there aren't any sessions there, add attendance record to DB
                boolean success = statement.execute("insert into attendance (user_id, session_id) values (" +
               user + ", " + sessionId + ")" );
                session.setAttribute("message","Sucessfully registered!  Now you're eligible for a fantastic prize!");
            }
                       else {
                
                session.setAttribute("message", "Already registered in that time slot!");
                       }
            duplicate.close();
        }
        
        
        
        connection.close();
        statement.close();
        result.close();
        response.sendRedirect("../view/attendance.jsp");
        %>
	<%@ include file="../includes/scriptlist.jsp" %>
    </body>
</html>