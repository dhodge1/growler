<%-- 
    Document   : refreshAvailableSessions
    Created on : Sep 18, 2013, 11:04:39 AM
    Author     : 162107
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="com.scripps.growler.*"%>
<%
    int sessionPassed = Integer.parseInt(request.getParameter("sessionId"));

    SessionPersistence sessionPersist = new SessionPersistence();
    LocationPersistence locationPersist = new LocationPersistence();
    ArrayList<Location> locations = locationPersist.getAllLocations("");
    Session sessions = sessionPersist.getSessionByID(sessionPassed);

    for (int i = 0; i < locations.size(); i++) {
        out.print("<li>");
        if (!sessions.getLocation().equals(locations.get(i).getId())) {
            out.print("<input type='radio' name='location' value=\"" + locations.get(i).getId() + "\"");
            out.print(">");
        } else {
            out.print("<i class='icon16-success' style='margin-left: 5px; margin-right: 5px;'></i>");
        }
        out.print(locations.get(i).getDescription() + ", " + locations.get(i).getBuilding() + ", " + locations.get(i).getCapacity());

        out.print("</li>");
    }
%>
