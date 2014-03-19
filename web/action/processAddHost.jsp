<%-- 
    Document   : processAddHost
    Created on : Mar 19, 2014, 4:06:27 PM
    Author     : Chelsea Grindstaff
    Purpose    : The purpose of processAddHost is to allow admins to enter a host
                and session into the database.  
                It uses the host table, and the fields user_id and session_id
--%>

<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<jsp:useBean id="persist" class="com.scripps.growler.SessionPersistence" scope="page" />
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page" />
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
%>



<% 
    String host = request.getParameter("host");
    String sessionForHost = request.getParameter("sessionForHost");
    //int sessionForHost = Integer.parseInt(String.valueOf(request.getParameter("sessionForHost")));
    
    SessionPersistence sp = new SessionPersistence();
    
    Session s = new Session();   
    
    sp.addHost(s);

    s.setSpeakerId(host);
    s.setSessionId(sessionForHost);

    
    //persist.addAttendees(s);
    
    session.setAttribute("message", "Success: The host has been successfully to the session!");
    response.sendRedirect("../private/admin/hostEntry-confirm.jsp");
    
    %>
