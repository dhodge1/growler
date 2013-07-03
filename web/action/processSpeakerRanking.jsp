<%-- 
    Document   : processSpeakerRanking
    Created on : Mar 5, 2013, 8:13:49 PM
    Author     : Justin Bauguess
    Purpose    : The purpose of processSpeakerRanking is to process the data 
                that users give us on what speakers they would like to hear.  It
                goes into the speaker_ranking table.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
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
                %>
        <% String list[] = request.getParameterValues("list");
            int ids[] = new int[list.length];
            for (int i = 0; i < list.length; i++) {
                ids[i] = Integer.parseInt(list[i]);
            }
            SpeakerPersistence sp = new SpeakerPersistence();
            ArrayList<Speaker> speakers = sp.getUserRanks(user);
            if (speakers.size() > 0) {
                session.setAttribute("message", "Error: You have already voted!");
            }
            else {
                //If they haven't voted, take their votes and put them in the database
                ArrayList<Speaker> newSpeakers = new ArrayList<Speaker>();
                for (int i = 0; i < ids.length; i++) {
                    Speaker s = sp.getSpeakerByID(ids[i]);
                    newSpeakers.add(s);
                }
                sp.setUserRanks(newSpeakers, user);
                

                session.setAttribute("message", "Success: Your votes have been recorded");
            }
            response.sendRedirect("../private/employee/speaker.jsp");
        %>
