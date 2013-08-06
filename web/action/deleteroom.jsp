<%-- 
    Document   : deleteroom
    Created on : Jun 11, 2013, 1:20:09 PM
    Author     : 162107
	Purpose	   : Accepts a room ID from the room page and deletes that room from the database.
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
        String id = request.getParameter("id");
        Location l = new Location();
        l.setId(id);
        LocationPersistence lp = new LocationPersistence();
        l = lp.getLocationById(id);
        try {
            lp.deleteLocation(l);
            //session.setAttribute("message", "Success: Room " + l.getDescription() + " successfully deleted!");
        }
        catch (Exception e) {
            //session.setAttribute("message", "Error: Deleting Room " + l.getDescription() + " failed.");
        }
        finally {
        }
    %>
</html>
