<%-- 
    Document   : processaddroom
    Created on : Jun 11, 2013, 2:10:02 PM
    Author     : 162107
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
                lp.addLocation(l);
                session.setAttribute("message", "Success: The following room was added successfully!");
            } catch (Exception e) {
                session.setAttribute("message", "Error: The following room was not added successfully.");
            } finally {
            session.setAttribute("room", l.getDescription());
            session.setAttribute("roomId", id);
            response.sendRedirect("../private/employee/admin/roomadd-confirm.jsp");
        }
    %>