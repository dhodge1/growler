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
            session.setAttribute("message", "Success: Room successfully updated!");
        } catch (Exception x) {
            session.setAttribute("message", "Error: Room did not update.");
        } finally {
            session.setAttribute("room", l.getDescription());
            response.sendRedirect("../private/employee/admin/roomedit-confirm.jsp");
        }
    %>