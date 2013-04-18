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
<%@page import="com.scripps.growler.DataConnection" %>
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
  <title>Growler Project</title><!-- Title -->
  <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
  <link rel="stylesheet" href="css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
	<link rel="stylesheet" href="draganddrop.css" /><!--Drag and drop style-->
  <script src="js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
</head>
<body id="growler1">
 <%@ include file="../includes/header.jsp" %> 
 <form method="post" action="../model/processattendance.jsp">
 <table>
     <tr>
         <td>Name</td>
         <td>Date</td>
         <td>Time</td>
         <td>Register</td>
     </tr>
    <%
    Connection connection = dataConnection.sendConnection();
    Statement statement = connection.createStatement();
    ResultSet result = statement.executeQuery("select id, name, session_date, start_time from session");
    while(result.next()) {
        %>
        <tr>
            <td><% result.getString("name"); %>
            <input type="hidden" name="session" value="<% out.print(result.getInt("id")); %>"/></td>
            <td><% result.getDate("session_date"); %></td>
            <td><% result.getTime("start_time"); %></td>
            <td><input type="submit" value="Attend"/></td>
        </tr>
        <%
    }
        result.close();
        statement.close();
        connection.close();
%>
 </table>
 </form>
<%@ include file="../includes/footer.jsp" %> 
<%@ include file="../includes/scriptlist.jsp" %>
<%@ include file="../includes/draganddrop.jsp" %>
    </body>
</html>