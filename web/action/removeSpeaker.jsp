<%-- 
    Document   : removeSpeaker
    Created on : May 31, 2013, 10:55:55 AM
    Author     : 162107
	Purpose	   : Deletes a speaker from the database.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page" />
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
            String idString = request.getParameter("id");
            Connection connection = dataConnection.sendConnection();
            Statement statement = connection.createStatement();
            SpeakerPersistence sp = new SpeakerPersistence();
            Speaker s = sp.getSpeakerByID(Integer.parseInt(idString));
            String sql = "delete from speaker where id = " + idString;
            int success = statement.executeUpdate(sql);
            String sql2 = "delete from speaker_team where speaker_id = " + idString;
            statement.executeUpdate(sql2);
            connection.close();
            statement.close();            
            %>