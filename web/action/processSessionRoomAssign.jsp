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
    } catch (Exception e) {
    }
%>
<%
    String roomId = request.getParameter("location");
    int sessionId = Integer.parseInt(request.getParameter("sessionId"));

    SessionPersistence sp = new SessionPersistence();
    LocationPersistence lp = new LocationPersistence();
    Location l = lp.getLocationById(roomId);
    sp.swapSessionLocations(sessionId, roomId);

    
        try {
            //Get the session's current info, then update the location
            Session s = new Session();
            s = sp.getSessionByID(sessionId);
            s.setLocation(roomId);
            sp.updateSession(s);
            SpeakerPersistence sk = new SpeakerPersistence();
            ArrayList<Speaker> speakers = sk.getSpeakersBySession(sessionId);
            Speaker sendSpeakerInfo = new Speaker();
            if (speakers.size() != 2) {
                sendSpeakerInfo = sk.getSpeakerByID(speakers.get(0).getId());
                session.setAttribute("sessionSpkr", sendSpeakerInfo.getFullName());
            } else {
                sendSpeakerInfo = sk.getSpeakerByID(speakers.get(0).getId());
                session.setAttribute("sessionSpkr", sendSpeakerInfo.getFullName());
                sendSpeakerInfo = sk.getSpeakerByID(speakers.get(1).getId());
                session.setAttribute("sessionSpkr2", sendSpeakerInfo.getFullName());
            }
            s = sp.getSessionByID(sessionId);
            session.setAttribute("sessionName", s.getName());
            session.setAttribute("sessionDesc", s.getDescription());
            session.setAttribute("sessionDate", s.getSessionDate());
            session.setAttribute("sessionTime", s.getStartTime());
            session.setAttribute("locationName", l.getDescription());
            session.setAttribute("locationBuilding", l.getBuilding());
            session.setAttribute("locationCapacity", l.getCapacity());
            session.setAttribute("message", "Success: The room has been assigned successfully!");
        } catch (Exception e) {
            // session.setAttribute("message", "Error: Room " + l.getDescription() + " already assigned to Session " + h.getName());
        }
    response.sendRedirect("../private/employee/admin/sessionroom-confirm.jsp");

%>