<%-- 
    Document   : processSessionAssign
    Created on : Jun 10, 2013, 11:07:32 AM
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
        <title>Page</title>
        <%

            int speakerId = Integer.parseInt(request.getParameter("speaker"));
            int sessionId = Integer.parseInt(request.getParameter("sessionId"));
            
            
            DataConnection dc = new DataConnection();
            Connection connection = dc.sendConnection();
            
            
                PreparedStatement statement = connection.prepareStatement("insert into speaker_team (speaker_id, session_id) values (?, ?)");
                statement.setInt(1, speakerId);
                statement.setInt(2, sessionId);
                try {
                    statement.execute();
                    session.setAttribute("message", "Success: Speaker successfully assigned to Session!");
                } catch (Exception e) {
                    //If the insert fails, it's a primary key violation, so display that message gracefully
                    session.setAttribute("message", "Error: Speaker has already been assigned to that Session");
                } finally {
                    statement.close();
                    connection.close();
                }
            
            response.sendRedirect("../admin/session.jsp");
        %>
</html>