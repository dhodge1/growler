<%-- 
    Document   : unlikeSession
    Created on : Aug 8, 2013, 11:07:09 AM
    Author     : 162107
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%
    int user = 0;
    if (null == session.getAttribute("id")) {
        response.sendRedirect("../index.jsp");
    }
    try {
        user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
        String name = String.valueOf(session.getAttribute("user"));
    } catch (Exception e) {
    }
    int sessionId = Integer.parseInt(request.getParameter("sid"));
    
    RegistrationPersistence rp = new RegistrationPersistence();
    com.scripps.growler.Registration reg = new com.scripps.growler.Registration();
    reg.setUserId(user);
    reg.setSessionId(sessionId);
    rp.deleteRegistration(reg);

%>