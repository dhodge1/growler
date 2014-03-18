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
<jsp:useBean id="persist" class="com.scripps.growler.SpeakerPersistence" scope="page" />
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
    String speaker = request.getParameter("speaker");
    String localAttendees = request.getParameter("localAttendees");
    String remoteAttendees = request.getParameter("remoteAttendees");
    
    Session t = new Session();
    t.setSpeaker(speaker);
    t.setLocalAttendees(localAttendees);
    t.setRemoteAttendees(remoteAttendees);
    
    persist.addAttendees(t)
    
    session.setAttribute("message", "Success: The number of attendees has been submitted successfully!");
    response.sendRedirect("../private/employee/attendeeEntry-confirm.jsp");
    
    %>
    
    
    <%--
    
    String first_name = request.getParameter("first_name");
    String last_name = request.getParameter("last_name");
    String type = request.getParameter("type");
    String reason = request.getParameter("reason");
    //****************************************************
    //*************Code added*******************************
    String email = request.getParameter("email");
    //****************************************************
    Speaker s = new Speaker();
    s.setFirstName(first_name);
    s.setLastName(last_name);
    s.setType(type);
    s.setSuggestedBy(user);
    s.setReason(reason);
    s.setEmail(email);
    s.setVisible(false);

    persist.addSpeaker(s);

    session.setAttribute("message", "Success: Your suggestion has been submitted successfully!");
    response.sendRedirect("../private/employee/speakerentry-confirm.jsp");

    
--%>
