<%-- 
    Document   : processSpeakerRemove
    Created on : Jun 13, 2013, 4:02:50 PM
    Author     : 162107
    Purpose    : Removes a speaker from a speaker_team, which means they are no
                longer assigned to speak for a session.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
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
            response.sendRedirect("../private/employee/admin/session.jsp");
        %>