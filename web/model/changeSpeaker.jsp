<%-- 
    Document   : changeSpeaker
    Created on : Jun 12, 2013, 4:21:55 PM
    Author     : 162107
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <%
                    int user = 0;
                    if (null == session.getAttribute("id")) {
                        response.sendRedirect("../index.jsp");
                    }
                    try {
                        user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                        String name = String.valueOf(session.getAttribute("user"));                  
                    }
                    catch (Exception e) {
                        
                    }
                %>
    <%
        
        int speaker_id = Integer.parseInt(request.getParameter("id"));
        SpeakerPersistence sp = new SpeakerPersistence();
        Speaker s = sp.getSpeakerByID(speaker_id);
        s.setSuggestedBy(808300);
        sp.updateSpeaker(s);
        session.setAttribute("message", "Success: " + s.getLastName() + ", " + s.getFirstName() + " was given \"Suggested\" status!");
        response.sendRedirect("../admin/speaker.jsp");
        
        %>
</html>
