<%-- 
    Document   : processSessionAssign
    Created on : Jun 10, 2013, 11:07:32 AM
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
%>
<%

    int speakerId = Integer.parseInt(request.getParameter("speaker"));
    int sessionId = Integer.parseInt(request.getParameter("sessionId"));


    DataConnection dc = new DataConnection();
    Connection connection = dc.sendConnection();
    
    SpeakerPersistence sk = new SpeakerPersistence();
    SessionPersistence sp = new SessionPersistence();


    PreparedStatement statement = connection.prepareStatement("insert into speaker_team (speaker_id, session_id) values (?, ?)");
    PreparedStatement statement2 = connection.prepareStatement("insert into speaker_team (speaker_id, session_id) values (?, ?)");
    if (request.getParameter("speaker2") != null) {
        int speaker2 = Integer.parseInt(request.getParameter("speaker2"));
        statement2.setInt(1, speaker2);
        statement2.setInt(2, sessionId);
        try {
            statement2.execute();
            //  session.setAttribute("message", "Success: Speaker " + k.getLastName() + ", " + k.getFirstName() + " successfully assigned to Session " + s.getName() + "!");
        } catch (Exception e) {
            //If the insert fails, it's a primary key violation, so display that message gracefully
            // session.setAttribute("message", "Error: Speaker " + k.getLastName() + ", " + k.getFirstName() + " was already assigned to Session " + s.getName());
        }
        Speaker l = sk.getSpeakerByID(speaker2);
        session.setAttribute("speaker2", l.getLastName() + ", " + l.getFirstName());
    }
    statement.setInt(1, speakerId);
    statement.setInt(2, sessionId);
    try {
        statement.execute();
        //  session.setAttribute("message", "Success: Speaker " + k.getLastName() + ", " + k.getFirstName() + " successfully assigned to Session " + s.getName() + "!");
    } catch (Exception e) {
        //If the insert fails, it's a primary key violation, so display that message gracefully
        // session.setAttribute("message", "Error: Speaker " + k.getLastName() + ", " + k.getFirstName() + " was already assigned to Session " + s.getName());
    } finally {
        statement.close();
        connection.close();
    }
    
    Speaker k = sk.getSpeakerByID(speakerId);
    Session s = sp.getSessionByID(sessionId);
    session.setAttribute("speaker", k.getLastName() + ", " + k.getFirstName());
    session.setAttribute("sessionInfo", s.getName() + " | " + s.getSessionDate() + " | " + s.getStartTime());
    session.setAttribute("message", "Success: The following speaker(s) have been assigned successfully!");
    response.sendRedirect("../private/employee/admin/speakerassign-confirm.jsp");
%>