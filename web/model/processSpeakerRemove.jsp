<%-- 
    Document   : processSpeakerRemove
    Created on : Jun 13, 2013, 4:02:50 PM
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



            PreparedStatement statement = connection.prepareStatement("delete from speaker_team where speaker_id = ? and session_id = ?");
            statement.setInt(1, speakerId);
            statement.setInt(2, sessionId);
            try {
                statement.execute();
                session.setAttribute("message", "Success: Speaker successfully removed from Session!");
            } catch (Exception e) {
                session.setAttribute("message", "Error: Speaker was not removed from session!");
            } finally {
                statement.close();
                connection.close();
            }

            response.sendRedirect("../admin/session.jsp");
        %>
</html>
