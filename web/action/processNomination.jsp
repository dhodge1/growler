<%-- 
    Document   : processNomination
    Created on : Aug 7, 2013, 11:17:55 AM
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
    } catch (Exception e) {
    }
    
    //Get the parameters
    String topic = request.getParameter("topic");
    String description = request.getParameter("description");
    java.sql.Time duration = java.sql.Time.valueOf(request.getParameter("duration"));
    int theme = Integer.parseInt(request.getParameter("theme"));
    //Create the containers
    NominationPersistence np = new NominationPersistence();
    Nomination n = new Nomination();
    //Set the values
    n.setTopic(topic);
    n.setDescription(description);
    n.setDuration(duration);
    n.setTheme(theme);
    //Check to see if the person nominating is already a speaker. If they aren't insert them into the 
    SpeakerPersistence sp = new SpeakerPersistence();
    Speaker test = sp.getSpeakerByName(request.getHeader("sn_first_name"), request.getHeader("sn_last_name"));
    if (test == null) {
        Speaker add = new Speaker();
        add.setFirstName(request.getHeader("sn_first_name"));
        add.setLastName(request.getHeader("sn_last_name"));
        add.setType("Business");
        sp.addSpeaker(add);
        add = sp.getSpeakerByName(request.getHeader("sn_first_name"), request.getHeader("sn_last_name"));
        n.setSpeaker(add.getId());
    }
    else {
        n.setSpeaker(test.getId());
    }
    
    np.addNomination(n);
    session.setAttribute("message", "Success: Your nomination has been submitted successfully!");
    response.sendRedirect("../private/employee/nominate-confirm.jsp");
    %>