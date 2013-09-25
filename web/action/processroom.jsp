<%-- 
    Document   : processroom
    Created on : Jun 11, 2013, 2:10:02 PM
    Author     : 162107
	Purpose    : Allows the admin to change features of a room.
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
        String id = request.getParameter("id");
        String description = request.getParameter("name");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        String building = request.getParameter("building");
        Location l = new Location();
        l.setId(id);
        l.setDescription(description);
        l.setCapacity(capacity);
        l.setBuilding(building);
        LocationPersistence lp = new LocationPersistence();
        try {
            lp.updateLocation(l);
            session.setAttribute("message", "Success: The following room has been edited successfully!");
        } catch (Exception x) {
            session.setAttribute("message", "Error: The following room was not edited successfully.");
        } finally {
            session.setAttribute("room", l.getDescription());
            session.setAttribute("roomId", l.getId());
            response.sendRedirect("../private/employee/admin/roomedit-confirm.jsp");
        }
    %>