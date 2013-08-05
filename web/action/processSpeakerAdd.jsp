<%-- 
    Document   : processSpeakerSuggestion
    Created on : Feb 27, 2013, 11:56:46 PM
    Author     : Justin Bauguess
    Purpose    : The purpose of processSpeakerSuggesstion is to allow users or 
                admins to enter a speaker into the database.  It uses the speaker 
                table, and the fields first_name, last_name from user input, and 
                visible and suggested_by as non-user input values.
--%>

<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<jsp:useBean id="persist" class="com.scripps.growler.SpeakerPersistence" scope="page" />
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
    } catch (Exception e) {
    }
    Speaker s = new Speaker();
    String first_name = request.getParameter("first_name");
    String last_name = request.getParameter("last_name");
    String type = request.getParameter("type");
    String visible = "";
    int creator = 0;
    try {
        creator = Integer.parseInt(request.getParameter("creator"));
    } catch (Exception e) {
        creator = user;
    }
    try {
        visible = request.getParameter("visible");
        if (visible.equals("true")) {
            s.setVisible(true);
        } else {
            s.setVisible(false);
        }
    } catch (Exception e) {
        s.setVisible(false);
    }
    s.setFirstName(first_name);
    s.setLastName(last_name);
    s.setType(type);
    s.setSuggestedBy(creator);
    persist.addSpeaker(s);

    session.setAttribute("message", "Success: The following speaker has been added successfully!");
    session.setAttribute("speaker", last_name + ", " + first_name);
    response.sendRedirect("../private/employee/admin/speakerentry-confirm.jsp");

%>