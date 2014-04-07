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
    
    int localAttendees = Integer.parseInt(String.valueOf(request.getParameter("localAttendees")));
    int remoteAttendees = Integer.parseInt(String.valueOf(request.getParameter("remoteAttendees")));
    int sessionId = Integer.valueOf(request.getParameter("sessionChosen"));

    
    AttendeePersistence ap = new AttendeePersistence();

    
    ap.addAttendees(sessionId, localAttendees, remoteAttendees);
    
    
    session.setAttribute("message", "Success: The number of attendees has been submitted successfully!");
    response.sendRedirect("../private/employee/admin/attendeeEntry-confirm.jsp");
    
    %>
    

