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
    if (!String.valueOf(session.getAttribute("user")).equals("admin")) {
            response.sendRedirect("../index.jsp");
        }
%>
