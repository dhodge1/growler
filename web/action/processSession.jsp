<%-- 
    Document   : processSession
    Created on : May 23, 2013, 9:40:24 AM
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

            String date = request.getParameter("date");
            String time = request.getParameter("time");
            String description = request.getParameter("description");

            String duration = request.getParameter("duration");
            String durString = "";
            try {
                int dur = Integer.parseInt(duration);
                int hours = dur / 60;
                int minutes = dur % 60;
                durString = hours + ":" + minutes + ":00";
            } catch (Exception e) {
                durString = null;
            }
            String name = request.getParameter("name");
            String location = request.getParameter("location");
            Session s = new Session();
            s.setName(name);
            s.setDescription(description);
            try {
                s.setSessionDate(java.sql.Date.valueOf(date));
                s.setStartTime(java.sql.Time.valueOf(time));
                s.setDuration(java.sql.Time.valueOf(durString));
            } catch (Exception e) {
            }
            s.setLocation(location);
            SessionPersistence sp = new SessionPersistence();
            try {
                ArrayList<Session> ses = sp.getSessionsByDateAndTime(java.sql.Date.valueOf(date), java.sql.Time.valueOf(time), " ");

                boolean ok = true;
                for (int i = 0; i < ses.size(); i++) {
                    //Gets the session scheduled for that time, then compares them to the location parameter
                    //Excuses TBD, because any number of sessions can have TBD as the location
                    if (ses.get(i).getLocation().equals(location) && !location.equals("TBD")) {
                        session.setAttribute("message", "Error: There is already a session scheduled for that room at that time");
                        ok = false;
                    }
                }
                if (ok) {
                    sp.addSession(s);
                    session.setAttribute("message", "Success: Session " + s.getName() + " for " + s.getSessionDate() + " added successfully!");
                }
            } catch (Exception e) {
                sp.addSession(s);
                session.setAttribute("message", "Success: Session " + s.getName() + " for " + s.getSessionDate() + " added successfully!");
            }
            response.sendRedirect("../private/employee/admin/session.jsp");
        %>
