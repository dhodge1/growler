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
            Session s = new Session();
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
            SessionPersistence sp = new SessionPersistence();
            try {
                //9-8 commented out the location checks, since they are currently not part of the adding session page
                //ArrayList<Session> ses = sp.getSessionsByDateAndTime(java.sql.Date.valueOf(date), java.sql.Time.valueOf(time));

                //boolean ok = true;
                //for (int i = 0; i < ses.size(); i++) {
                    //Gets the session scheduled for that time, then compares them to the location parameter
                    //Excuses TBD, because any number of sessions can have TBD as the location
                //    if (ses.get(i).getLocation().equals(location) && !location.equals("TBD")) {
                //        session.setAttribute("message", "Error: There is already a session scheduled for that room at that time");
                //        ok = false;
                //    }
                //}
               // if (ok) {
                    sp.addSession(s);
                    session.setAttribute("message", "Success: Session " + s.getName() + " for " + s.getSessionDate() + " added successfully!");
                    //Get the newly created Session ID and assign the speaker to it
                    Session ses = sp.getSessionByName(name);
                    sp.assignSpeaker(spkrId, ses.getId());
                    session.setAttribute("sessionName", name);
               // }
            } catch (Exception e) {
                //sp.addSession(s);
                //session.setAttribute("message", "Success: Session " + s.getName() + " for " + s.getSessionDate() + " added successfully!");
            }
            response.sendRedirect("../private/employee/admin/sessionadd-confirm.jsp");
        %>
