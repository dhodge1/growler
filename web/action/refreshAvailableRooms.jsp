<%-- 
    Document   : refreshAvailableRooms
    Created on : Sep 18, 2013, 10:39:12 AM
    Author     : 162107
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="com.scripps.growler.*"%>
<%
    String roomPassed = request.getParameter("room");
    SessionPersistence sessionPersist = new SessionPersistence();
    LocationPersistence locationPersist = new LocationPersistence();
    Location location = locationPersist.getLocationById(roomPassed);
    ArrayList<Session> sessions = sessionPersist.getThisYearSessions(2013, " order by session_date, start_time");

    SimpleDateFormat fmt = new SimpleDateFormat("h:mm a");
    SimpleDateFormat dates = new SimpleDateFormat("MM/dd");
    //Get a list of all sessions
    for (int i = 0; i < sessions.size(); i++) {
        out.print("<li>");
        if (!sessions.get(i).getLocation().equals(location.getId())) {
            out.print("<input type='radio' name='sessionId' value=\"" + sessions.get(i).getId() + "\"");
            out.print(">");
        } else {
            out.print("<i class='icon16-success' style='margin-left: 5px; margin-right: 5px;'></i>");
        }
        out.print(dates.format(sessions.get(i).getSessionDate()) + ", " + fmt.format(sessions.get(i).getStartTime()) + ", " + sessions.get(i).getName());
        out.print("</li>");
    }
%>