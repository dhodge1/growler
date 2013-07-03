<%-- 
    Document   : adduser
    Created on : Apr 17, 2013, 9:50:54 PM
    Author     : Justin Bauguess
    Purpose    : Processes adding a user to the Growler Project
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
        <%
            //Find if the user already exists
            String user = request.getParameter("corporate");
            String firstname = request.getParameter("firstname");
            firstname = firstname.trim();
            String lastname = request.getParameter("lastname");
            lastname = lastname.trim();
            Connection connection = dataConnection.sendConnection();
            Statement statement = connection.createStatement();
            //Add the user if they aren't already there
            //In the future, we will validate the password against SiteMinder, then proceed to
            //getting the information from SiteMinder and adding into the database.
            String password = request.getParameter("password");
            //Removed the following because it's changing while waiting for the SiteMinder information
            //String email = request.getParameter("email");
            //boolean success = statement.execute("insert into user (name, password, email, corporate_id) values ('"
            //        + user + "',sha1('" + password + "'),'" + email + "', '" + corporate + "')");
            //For now we'll make the User's name the same as their corporate Id
            try {
                statement.execute("insert into user(name, password, corporate_id, id) values ('" + firstname + " " + lastname + "', sha1('" + password + "'), " + user + ", " + user + ")");

                session.setAttribute("user", firstname + " " + lastname);
                session.setAttribute("id", user);
                session.setAttribute("message", "Success: You have been successfully registered!");
                
            } catch (Exception e) {
                session.setAttribute("message", "Error: That corporate id is already registered!");
            } finally {
                statement.close();
                connection.close();
            }
            
            
            response.sendRedirect("../private/employee/home.jsp");
        %>