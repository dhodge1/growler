<%-- 
    Document   : processSession
    Created on : May 23, 2013, 9:40:24 AM
    Author     : 162107
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%
            String user = (String)session.getAttribute("user");
            //String id = (String)session.getAttribute("id");
            String date = request.getParameter("date");
            String time = request.getParameter("time");
            String duration = request.getParameter("duration");
            String name = request.getParameter("name");
            String location = request.getParameter("location");
            Session s = new Session();
            s.setName(name);
            s.setSessionDate(java.sql.Date.valueOf(date));
            s.setStartTime(java.sql.Time.valueOf(time));
            s.setDuration(Integer.parseInt(duration));
            s.setLocation(Integer.parseInt(location));
            SessionPersistence sp = new SessionPersistence();
            sp.addSession(s);
            session.setAttribute("message", "Session " + s.getName() + " added successfully!");
            response.sendRedirect("../admin/session.jsp");
        %>
</html>
