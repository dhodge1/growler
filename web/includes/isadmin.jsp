<%-- 
    Document   : isadmin
    Created on : Apr 16, 2013, 9:28:41 PM
    Author     : Justin Bauguess
    Purpose    : Checks the header to see if the user is an admin.
                If the user is not an admin, they are redirected based on
                whether or not the header is set.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //Look for the "user" info in the header
    if (!request.getHeader("user").equals("admin")) {
        //If there is no header data, go to login page
        if (request.getHeader("user").isEmpty()) {
            response.sendRedirect("../index.jsp");
        }
        //If there is header data, then the user is trying to access
        //Something they shouldn't.  Send them to the theme page
        else {
            response.sendRedirect("../view/theme.jsp");
        }
    }
%>
