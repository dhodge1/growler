<%-- 
    Document   : processTrackAttendees
    Created on : March 18, 2013
    Author     : Chelsea Grindstaff
    Purpose    : The purpose of processTrackAttendees is to allow speakers to 
                enter the # of attendees into the database.  
                It uses the attendees table, and the fields session_id, user_id,
                local_Attendees, and remote_Atendees
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
    //String speaker = request.getParameter("speaker");
    String localAttendees = request.getParameter("localAttendees");
    String remoteAttendees = request.getParameter("remoteAttendees");
    int sessionSelected = Integer.parseInt(String.valueOf(request.getParameter("session")));
    
    SessionPersistence sp = new SessionPersistence();
    
    Session s = new Session();   
    
    sp.addAttendees(s);

    s.setId(sessionSelected);
    //s.setSpeakerId(speaker);
    s.setLocalAttendees(localAttendees);
    s.setRemoteAttendees(remoteAttendees);
    
    //persist.addAttendees(s);
    
    session.setAttribute("message", "Success: The number of attendees has been submitted successfully!");
    response.sendRedirect("../private/employee/admin/attendeeEntry-confirm.jsp");
    
    %>
    

