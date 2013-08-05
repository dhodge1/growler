<%-- 
    Document   : processThemeEdit
    Created on : Jun 4, 2013, 2:58:43 PM
    Author     : 162107
	Purpose    : Allows an admin to edit a theme's information
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
        int id = Integer.parseInt(request.getParameter("id"));
        String first_name = request.getParameter("first_name");
        String last_name = request.getParameter("last_name");
        String type = request.getParameter("type");
        String creator = request.getParameter("creator");
        String visible;
        SpeakerPersistence sp = new SpeakerPersistence();
        Speaker speaker = sp.getSpeakerByID(id);
        try {
            visible = request.getParameter("visible");
            if (visible.equals("true")) {
                speaker.setVisible(true);
            }
            else {
                speaker.setVisible(false);
            }
        }catch (Exception e) {
            speaker.setVisible(false);
        }
        speaker.setFirstName(first_name);
        speaker.setLastName(last_name);
        speaker.setType(type);
        speaker.setSuggestedBy(Integer.parseInt(creator));
        sp.updateSpeaker(speaker);
        session.setAttribute("message", "Success: The following speaker edited successfully!");
        session.setAttribute("speaker", last_name + ", " + first_name);
        response.sendRedirect("../private/employee/admin/speakeredit-confirm.jsp");
    %>