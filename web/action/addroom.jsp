<%-- 
    Document   : addroom
    Created on : Jun 11, 2013, 1:16:11 PM
    Author     : 162107
	Purpose	   : This jsp page takes the Room ID, Name, Capacity, and Building from the Add Room form, and places it in the database, then redirects to the rooms page.
--%>

<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
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
            session.setAttribute("message", "Success: Room " + l.getDescription() + " successfully added!");
        }
        catch (Exception e) {
            session.setAttribute("message", "Error: Adding Room " + l.getDescription() + " failed.");
        }
        finally {
            response.sendRedirect("../private/employee/admin/room.jsp");
        }
    %>
</html>
