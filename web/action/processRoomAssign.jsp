<%-- 
    Document   : processroomassign
    Created on : Jun 11, 2013, 2:39:45 PM
    Author     : 162107
	Purpose	   : Assigns a room to a session.  Ensures a room can't be used in the same time slot twice.
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        String roomId = request.getParameter("location");
        int sessionId = Integer.parseInt(request.getParameter("session"));
        
        SessionPersistence sp = new SessionPersistence();
        LocationPersistence lp = new LocationPersistence();
        Location l = lp.getLocationById(roomId);
        boolean success = sp.validateSessionSlot(sessionId, roomId);
        Session h = sp.getSessionByID(sessionId);
        if (success) {
            try {
                //Get the session's current info, then update the location
                Session s = new Session();
                s = sp.getSessionByID(sessionId);
                s.setLocation(roomId);
                sp.updateSession(s);
                session.setAttribute("message", "Success: Room " + l.getDescription() + " successfully assigned to Session " + h.getName() + "!");
            }
            catch (Exception e) {
                
                session.setAttribute("message", "Error: Room " + l.getDescription() + " already assigned to Session " + h.getName());
            }
                
        }
        else {
            session.setAttribute("message", "Error: Room " + l.getDescription() + " already assigned to another Session at that time.");
        }
            response.sendRedirect("../private/employee/admin/room.jsp");
        
    %>