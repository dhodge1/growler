<%-- 
    Document   : reset
    Created on : Apr 17, 2013, 10:30:03 PM
    Author     : Justin Bauguess
    Purpose    : Processes a password reset
                 Accepts the user name, and (hopefully) matching password fields
                 from the resetpassword.jsp page.  This also needs to user to have 
                 entered the correct verification code sent by the email.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<%
            String user = request.getParameter("user");
            String email = request.getParameter("email");
            String verify = request.getParameter("verify");
            String p1 = request.getParameter("password");
            String p2 = request.getParameter("password2");
            if (p1.compareTo(p2) != 0) {
                response.sendRedirect("../public/resetpassword.jsp?user_name=" + user);
            }
            Connection connection = dataConnection.sendConnection();
            Statement statement = connection.createStatement();
            //Query for the result
            ResultSet result = statement.executeQuery("select count(id), name, password, email from user where id = " + user
                    + " and password = '" + verify + "' and email = '" + email + "'");
            boolean success = false;
            String name = " ";
            while (result.next()) {
                if (result.getInt(1) != 0) {
                    success = true;
                    name = result.getString("name");
                }
            }
            if (success) {
                statement.execute("update user set password = sha1('" + p1 + "') where id = " + user);
                result.close();
                statement.close();
                connection.close();
                //session.setAttribute("user", name);
                //session.setAttribute("id", user);
                session.setAttribute("message", "Success: Password reset successfully! ");
                response.sendRedirect("../public/reset-successful.jsp");
            } else {
                result.close();
                statement.close();
                connection.close();
                session.setAttribute("message", "Error: Invalid credentials ");
                response.sendRedirect("../index.jsp");
            }

        %>