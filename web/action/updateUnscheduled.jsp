<%-- 
    Document   : updateUnscheduled
    Created on : Jun 28, 2013, 8:47:53 AM
    Author     : 162107
	Purpose	   : Uses AJAX to update the unscheduled list for the sessionScheduler.jsp page.
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.scripps.growler.Session"%>
<%@page import="com.scripps.growler.SessionPersistence"%>
<%
    SessionPersistence pp = new SessionPersistence();
    ArrayList<Session> unscheduled = pp.getUnscheduledSessions();
    response.getWriter().write("<table><tr><th>Name</th><th>Description</th></tr>");
    for (int i = 0; i < unscheduled.size(); i++) {
        response.getWriter().write("<tr><td>" + unscheduled.get(i).getName() + "</td><td>" + unscheduled.get(i).getDescription() + "</td></tr>");
    }
    response.getWriter().write("</table>");
%>
