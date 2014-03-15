<%-- 
    Document   : deactivateSession
    Created on : Mar 14, 2014, 8:02:01 PM
    Author     : David
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>

<%
    int sessionPassed = 0;
    if (null == session.getAttribute("id") || null == session.getAttribute("role")) {
        response.sendRedirect("../index.jsp");
    }
    try {
        sessionPassed = Integer.parseInt(request.getParameter("session_id"));
    } catch (Exception e) {
    }
    
    SessionPersistence sp = new SessionPersistence();
    sp.setSessionState(sessionPassed, false);
    response.sendRedirect("../private/employee/admin/session.jsp");
%>
