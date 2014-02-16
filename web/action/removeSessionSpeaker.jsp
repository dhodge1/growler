<%-- 
    Document   : removeSessionSpeaker
    Created on : Feb 16, 2014, 1:34:42 PM
    Author     : David
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    int user = 0;
    if (null == session.getAttribute("id") || null == session.getAttribute("role")) {
        response.sendRedirect("../../../index.jsp");
    }
    try {
      user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
    } catch (Exception e) {
    }
    
    SessionPersistence sp = new SessionPersistence();
    
    int speakerID = Integer.parseInt(request.getParameter("speaker_id"));
    int sessionID = Integer.parseInt(request.getParameter("session_id"));
    
    sp.undoAssignSpeaker(speakerID, sessionID);
%>