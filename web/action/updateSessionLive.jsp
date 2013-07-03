<%-- 
    Document   : updateSessionLive
    Created on : Jun 28, 2013, 7:31:22 AM
    Author     : 162107
	Purpose	   : Uses AJAX to update for the sessionScheduler.jsp page.
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.scripps.growler.Session"%>
<%@page import="com.scripps.growler.SessionPersistence"%>
<%
    SessionPersistence sp = new SessionPersistence();
    int sessionId = Integer.parseInt(request.getParameter("id"));
    java.sql.Date date = java.sql.Date.valueOf(request.getParameter("date"));
    java.sql.Time time = java.sql.Time.valueOf(request.getParameter("time"));
    //If it's not 0, we're updating a session
    if (sessionId != 0) {
        Session current = sp.getSessionByID(sessionId);
        current.setSessionDate(date);
        current.setStartTime(time);
        sp.updateSession(current);
    } //If it's 0, someone put NO SESSION in place of an existing session
    else {
        Session removal = sp.getSessionByDateAndTime(date, time, " ");
        removal.setSessionDate(java.sql.Date.valueOf("2013-10-01"));
        removal.setStartTime(null);
        sp.updateSession(removal);
    }
%>
