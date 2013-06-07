<%-- 
    Document   : login
    Created on : Mar 12, 2013, 12:15:42 PM
    Author     : Justin Bauguess
--%>

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
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            // Here you put the check on the username and password            
            MessageDigest sha = MessageDigest.getInstance("sha-1");
            sha.update(password.getBytes());
            byte pwd[] = sha.digest();
            String pw = dataConnection.bytesToHex(pwd);
            Connection connection = dataConnection.sendConnection();
            Statement statement = connection.createStatement();
            ResultSet result = statement.executeQuery("select id, name, password from user where id = '" + username
                    + "' and password = '" + pw + "'");
            //Redirect, and set the user's identity in the header
            if (result.next()) {
                //If it's an admin, go to the admin side
                if (result.getInt(1) == 808300) {
                    session.setAttribute("user", "admin");
                    session.setAttribute("id", new Integer(result.getInt("id")));
                    session.setMaxInactiveInterval(1800); //30 minutes before it kicks you off
                    connection.close();
                    statement.close();
                    result.close();
                    response.sendRedirect("../admin/home.jsp");
                } //Otherwise, go to the user side
                else {

                    session.setAttribute("user", result.getString("name"));
                    session.setAttribute("id", new Integer(result.getInt("id")));
                    session.setMaxInactiveInterval(600); //10 minutes before it kicks you off
                    connection.close();
                    statement.close();
                    result.close();
                    response.sendRedirect("../view/home.jsp");
                }
            } else {
                connection.close();
                statement.close();
                result.close();
                session.setAttribute("message", "Invalid Login");
                response.sendRedirect("../index.jsp");

            }
        %>
        <%@ include file="../includes/scriptlist.jsp" %>
    </body>
</html>
