<%-- 
    Document   : updateSessions
    Created on : Jul 18, 2013, 2:50:55 PM
    Author     : 162107
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.scripps.growler.Session"%>
<%@page import="com.scripps.growler.SessionPersistence"%>
<%
    SessionPersistence sp = new SessionPersistence();
    int pageNo = Integer.parseInt(request.getParameter("pageNo"));
    pageNo *= 15;
    ArrayList<Session> sessions = sp.getThisYearSessions(2013, " ", pageNo);
    for (int i = 0; i <sessions.size();i++){
        response.getWriter().write("<tr>");
        response.getWriter().write("<td>");
        response.getWriter().write("</td>");
        response.getWriter().write("<td>");
        response.getWriter().write("</td>");
        response.getWriter().write("<td>");
        response.getWriter().write("</td>");
        response.getWriter().write("<td>");
        response.getWriter().write("</td>");
        response.getWriter().write("<td>");
        response.getWriter().write("</td>");
        response.getWriter().write("<td>");
        response.getWriter().write("</td>");
        response.getWriter().write("<td>");
        response.getWriter().write("</td>");
        response.getWriter().write("<td>");
        response.getWriter().write("</td>");
        response.getWriter().write("</tr>");
    }
%>