<%-- 
    Document   : processNomination
    Created on : Aug 7, 2013, 11:17:55 AM
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
    
    //Get the parameters
    String topic = request.getParameter("topic");
    String description = request.getParameter("description");
    java.sql.Time duration = java.sql.Time.valueOf(request.getParameter("duration"));
    int theme = Integer.parseInt(request.getParameter("theme"));
    
    NominationPersistence np = new NominationPersistence();
    Nomination n = new Nomination();
    
    n.setTopic(topic);
    n.setDescription(description);
    n.setDuration(duration);
    n.setTheme(theme);
    n.setSpeaker(user);
    np.addNomination(n);
    session.setAttribute("message", "Success: Your nomination has been submitted successfully!");
    response.sendRedirect("../private/employee/nominate-confirm.jsp");
    %>