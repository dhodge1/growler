<%-- 
    Document   : checkSession
    Created on : Aug 9, 2013, 1:04:16 PM
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
    SessionPersistence sp = new SessionPersistence();
    if (!sp.validateSlotNoLocation(id)){
        response.getWriter().write("There is already a session scheduled for this time slot!<br/>");
        Session current = sp.getSessionByID(id);
        ArrayList<Session> list = sp.getSessionsByDateAndTime(current.getSessionDate(), current.getStartTime());
        for (int i = 0; i < list.size(); i++){
            response.getWriter().write(list.get(i).getName() + "<br/>");
        }
    }
%>