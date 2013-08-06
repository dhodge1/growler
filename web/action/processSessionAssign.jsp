<%-- 
    Document   : processSessionAssign
    Created on : Jun 10, 2013, 11:07:32 AM
    Author     : 162107
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
                %>
        <%

            int speakerId = Integer.parseInt(request.getParameter("speaker"));
            int sessionId = Integer.parseInt(request.getParameter("sessionId"));
            
            
            DataConnection dc = new DataConnection();
            Connection connection = dc.sendConnection();
            
            
                PreparedStatement statement = connection.prepareStatement("insert into speaker_team (speaker_id, session_id) values (?, ?)");
                statement.setInt(1, speakerId);
                statement.setInt(2, sessionId);
                SpeakerPersistence sk = new SpeakerPersistence();
                SessionPersistence sp = new SessionPersistence();
                Speaker k = sk.getSpeakerByID(speakerId);
                Session s= sp.getSessionByID(sessionId);
                try {
                    statement.execute();
                  //  session.setAttribute("message", "Success: Speaker " + k.getLastName() + ", " + k.getFirstName() + " successfully assigned to Session " + s.getName() + "!");
                } catch (Exception e) {
                    //If the insert fails, it's a primary key violation, so display that message gracefully
                   // session.setAttribute("message", "Error: Speaker " + k.getLastName() + ", " + k.getFirstName() + " was already assigned to Session " + s.getName());
                } finally {
                    statement.close();
                    connection.close();
                }
            
            response.sendRedirect("../private/employee/admin/session.jsp");
        %>