<%-- 
    Document   : checkDuplicateSession
    Created on : Sep 12, 2013, 8:11:05 PM
    Author     : 162107
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.scripps.growler.*"%>

<% 
    
    java.sql.Date date = java.sql.Date.valueOf(request.getParameter("date"));
    java.sql.Time time = java.sql.Time.valueOf(request.getParameter("time"));
    SessionPersistence sp = new SessionPersistence();
    
    ArrayList<Session> sessionList = sp.getSessionsByDateAndTime(date, time);
    
    if (sessionList.size() > 1) {
        for (int i =0; i < sessionList.size(); i++){
            response.getWriter().println(sessionList.get(i).getName() + " | " + sessionList.get(i).getSessionDate() + " | " + sessionList.get(i).getStartTime());
        }
    }
    else {
        response.getWriter().write("no");
        for (int i =0; i < sessionList.size(); i++){
            response.getWriter().println("Name:" + sessionList.get(i).getName());
        }
    }
    
%>