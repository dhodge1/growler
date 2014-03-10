<%-- 
    Document   : removemapping
    Created on : Mar 10, 2014, 6:11:45 PM
    Author     : David
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>

<%
    String roomPassed = "TBD";
    try {
        roomPassed = (request.getParameter("roomId"));
    } catch (Exception e){
                
    }
    
    LocationPersistence lp3 = new LocationPersistence();
    
    try {
        lp3.deleteMappings(roomPassed);
    } catch (Exception e) {
        
    }
    
    response.sendRedirect("../private/employee/admin/room.jsp");
%>