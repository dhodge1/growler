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
                    }
                    catch (Exception e) {
                        
                    }
                %>
        <% String first_name = request.getParameter("first_name");
            String last_name = request.getParameter("last_name");
            String reason = request.getParameter("reason");
            String admin = request.getParameter("admin");

            Speaker s = new Speaker();
            s.setFirstName(first_name);
            s.setLastName(last_name);
            s.setSuggestedBy(user);
            s.setVisible(false);
            Speaker s2 = persist.getSpeakerByName(first_name, last_name);
            if (s.getFirstName() == s2.getFirstName() && s.getLastName() == s2.getLastName()) {
                s.setVisible(true);
                persist.updateSpeaker(s);
            }
            else {
                persist.addSpeaker(s);
            }
            if (user == 808300) {
                response.sendRedirect("../private/employee/admin/userspeaker.jsp");
            } else {
                session.setAttribute("message", "Success: Your suggestion has been submitted successfully!");
                response.sendRedirect("../private/employee/speakerentry-confirm.jsp");
            }
        %>