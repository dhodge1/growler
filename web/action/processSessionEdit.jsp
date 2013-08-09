<%-- 
    Document   : processSessionEdit
    Created on : June 10, 2013, 9:40:24 AM
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
    
    int id = Integer.parseInt(request.getParameter("id"));
    String name = request.getParameter("name");
    String description = request.getParameter("description");
    int speaker = Integer.parseInt(request.getParameter("speaker"));
    java.sql.Date date;
    try {
        date = java.sql.Date.valueOf(request.getParameter("date"));
    } catch (Exception e) {
        date = null;
    }
    java.sql.Time time = java.sql.Time.valueOf(request.getParameter("time"));

    SessionPersistence sp = new SessionPersistence();
    Session s = sp.getSessionByID(id);
    s.setId(id);
    s.setName(name);
    s.setDescription(description);
    s.setSessionDate(date);
    s.setStartTime(time);
    sp.updateSession(s);
    sp.assignSpeaker(speaker, id);
    response.sendRedirect("../private/employee/admin/session.jsp");
%>
</html>
