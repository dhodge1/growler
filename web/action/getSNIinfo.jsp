<%-- 
    Document   : getSNIinfo
    Created on : May 23, 2013, 11:56:28 AM
    Author     : 162107
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.scripps.growler.*" %>
<%
    String first_name = request.getHeader("SN_FIRST_NAME");
    String last_name = request.getHeader("SN_LAST_NAME");
    String email = request.getHeader("SN_EMAIL");
    String name = first_name + ", " + last_name;
    
    UserPersistence up = new UserPersistence();
    User u = up.getUserByEmail(email);
    
    if (u != null) {
        session.setAttribute("user", u.getUserName());
        session.setAttribute("id", u.getCorporateId());
        response.sendRedirect("../private/employee/theme.jsp");
    }
    else {
        String message = "Please register your SNI Id";
        response.sendRedirect("../index.jsp");
    }
    
    
    
%>
