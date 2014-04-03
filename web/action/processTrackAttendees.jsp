<%-- 
    Document   : processTrackAttendees
    Created on : March 18, 2013
    Author     : Chelsea Grindstaff
    Purpose    : The purpose of processTrackAttendees is to allow speakers to 
                enter the # of attendees into the database.  
                It uses the attendees table, and the fields session_id, user_id,
                local_Attendees, and remote_Atendees
--%>

<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<jsp:useBean id="persist" class="com.scripps.growler.SessionPersistence" scope="page" />
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
%>



<% 
    Session s = new Session();
    
    //int localAttendees = Integer.parseInt(String.valueOf(request.getParameter("localAttendees")));
    //int remoteAttendees = Integer.parseInt(String.valueOf(request.getParameter("remoteAttendees")));
    //String sessionName = request.getParameter("session");
    //String sessionName = String.valueOf(session.getAttribute("sessionName"));
    int sessionId = Integer.parseInt(String.valueOf(session.getAttribute("sessionId")));
    int localAttendees = Integer.parseInt(String.valueOf(session.getAttribute("localAttendees")));
    int remoteAttendees = Integer.parseInt(String.valueOf(session.getAttribute("remoteAttendees")));

    
    SessionPersistence sp = new SessionPersistence();
    
    //Session ses = sp.getSessionByName(sessionName);
    //int session_Id = ses.getId();
    
    
   
    
    sp.addAttendees(sessionId, localAttendees, remoteAttendees);
    


    //session.setAttribute("session_id", ses.getId());
    //session.setAttribute("local_Attendees", localAttendees);
    //session.setAttribute("remote_Attendees", remoteAttendees);
 
    /*s.setId(ses.getId());
    s.setLocalAttendees(localAttendees);
    s.setRemoteAttendees(remoteAttendees);*/
    
    //persist.addAttendees(s);
    
    session.setAttribute("message", "Success: The number of attendees has been submitted successfully!");
    response.sendRedirect("../private/employee/admin/attendeeEntry-confirm.jsp");
    
    %>
    

