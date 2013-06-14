<%-- 
    Document   : processSession
    Created on : May 23, 2013, 9:40:24 AM
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
        <title>JSP Page</title>
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
            String date = request.getParameter("date");
            String description = request.getParameter("description");
            String time = request.getParameter("time");
            String duration = request.getParameter("duration");
            int dur = Integer.parseInt(duration);
            int hours = dur / 60;
            int minutes = dur % 60;
            String durString = hours + ":" + minutes + ":00";
            String name = request.getParameter("name");
            String location = request.getParameter("location");
            Session s = new Session();
            s.setName(name);
            s.setDescription(description);
            s.setSessionDate(java.sql.Date.valueOf(date));
            s.setStartTime(java.sql.Time.valueOf(time));
            s.setDuration(java.sql.Time.valueOf(durString));
            s.setLocation(location);
            SessionPersistence sp = new SessionPersistence();
            ArrayList<Session> ses = sp.getSessionsByDateAndTime(java.sql.Date.valueOf(date), java.sql.Time.valueOf(time), " ");
            boolean ok = true;
            for (int i = 0; i < ses.size(); i++) {
                if (ses.get(i).getLocation().equals(location)) {
                    session.setAttribute("message", "Error: There is already a session scheduled for that room at that time");
                    ok = false;
                }
            }
            if (ok) {
                sp.addSession(s);
                session.setAttribute("message", "Success: Session " + s.getName() + " for " + s.getSessionDate() + " added successfully!");
            }
            response.sendRedirect("../admin/session.jsp");
        %>
</html>
