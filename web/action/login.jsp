<%-- 
    Document   : login
    Created on : Mar 12, 2013, 12:15:42 PM
    Author     : Justin Bauguess
	Purpose	   : Checks to see if a user entered valid credentials for the system.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page" />
        <%
            String username = request.getParameter("USER");
            String password = request.getParameter("PASSWORD");
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
                    session.setAttribute("role", "admin");
                    session.setAttribute("email", "techtoberfest-help@gmail.com");
                    session.setAttribute("id", new Integer(result.getInt("id")));
                    session.setMaxInactiveInterval(1800); //30 minutes before it kicks you off
                    connection.close();
                    statement.close();
                    result.close();
                    //response.sendRedirect("../private/employee/admin/home.jsp");
                    //response.sendRedirect("../private/employee/home.jsp");
                    response.sendRedirect("../home");
                } //Otherwise, go to the user side
                else {
                    session.setAttribute("user", result.getString("name"));
                    session.setAttribute("role", "user");
                    session.setAttribute("id", new Integer(result.getInt("id")));
                    session.setAttribute("email", "techtoberfest-help@gmail.com");
                    session.setMaxInactiveInterval(1800); //30 minutes before it kicks you off
                    connection.close();
                    statement.close();
                    result.close();
                    //response.sendRedirect("../private/employee/home.jsp");
                    response.sendRedirect("../home");
                }
            } else {
                connection.close();
                statement.close();
                result.close();
                session.setAttribute("message", "Error: The Employee ID or Password you entered is incorrect.");
                response.sendRedirect("../index.jsp");

            }
        %>