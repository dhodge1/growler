<%-- 
    Document   : processSessionEdit
    Created on : June 10, 2013, 9:40:24 AM
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
    
    int id = Integer.parseInt(request.getParameter("sessionId"));
    SessionPersistence sp = new SessionPersistence();
    Session s = sp.getSessionByID(id);
    String date = request.getParameter("date");
            String time = request.getParameter("time");
            //Get the 'a' or 'b' from the time string
            char marker = time.charAt(8);
            //Chop off the 'a' or 'b'
            time = time.substring(0, 7);
            String description = request.getParameter("description");
            String name = request.getParameter("name");
            String speaker = request.getParameter("speaker");
            int spkrId = Integer.parseInt(speaker);
            s.setName(name);
            s.setDescription(description);
            try {
                s.setSessionDate(java.sql.Date.valueOf(date));
                s.setStartTime(java.sql.Time.valueOf(time));
                if (marker == 'b'){
                    s.setDuration(java.sql.Time.valueOf("00:50:00"));
                }
                else {
                    s.setDuration(java.sql.Time.valueOf("00:25:00"));
                }
            } catch (Exception e) {
            }
    s.setId(id);
    s.setName(name);
    s.setDescription(description);
    sp.updateSession(s);
    sp.assignSpeaker(spkrId, id);
    session.setAttribute("message", "Success: Session " + s.getName() + " for " + s.getSessionDate() + " updated successfully!");
    session.setAttribute("sessionName", name);
    response.sendRedirect("../private/employee/admin/sessionedit-confirm.jsp");
%>
