<%-- 
    Document   : processTrackAttendeesEdit
    Author     : Chelsea Grindstaff
    Purpose    : The purpose of processTrackAttendees is to allow speakers to 
                enter the # of attendees into the database.  
                It uses the attendees table, and the fields session_id, 
                local_Attendees, and remote_Atendees
--%>

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
%>



<% 
    Attendees s = new Attendees();
    
    String localAttendees = String.valueOf(request.getParameter("localAttendees"));
    String remoteAttendees = String.valueOf(request.getParameter("remoteAttendees"));
    int sessionId = Integer.valueOf(request.getParameter("sessionId"));

    
    AttendeePersistence ap = new AttendeePersistence();

    
    ap.editAttendees(localAttendees, remoteAttendees, sessionId);
    
    
    session.setAttribute("message", "Success: The number of attendees has been updated successfully!");
    response.sendRedirect("../private/employee/admin/attendeeEntry-confirm.jsp");
    
    %>
    

