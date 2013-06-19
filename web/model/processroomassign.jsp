<%-- 
    Document   : processroomassign
    Created on : Jun 11, 2013, 2:39:45 PM
    Author     : 162107
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <title>Admin Rooms</title><!-- Title -->

        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/demo.css" />  
        <link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
        <link rel="stylesheet" type="text/css" href="../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="../css/theme.css" /><!--Theme CSS-->
        <link rel="stylesheet" href="/resources/demos/style.css" />

        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
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
        String roomId = request.getParameter("roomId");
        int sessionId = Integer.parseInt(request.getParameter("sessionId"));
        
        SessionPersistence sp = new SessionPersistence();
        LocationPersistence lp = new LocationPersistence();
        Location l = lp.getLocationById(roomId);
        boolean success = sp.validateSessionSlot(sessionId, roomId);
        Session h = sp.getSessionByID(sessionId);
        if (success) {
            try {
                //Get the session's current info, then update the location
                Session s = new Session();
                s = sp.getSessionByID(sessionId);
                s.setLocation(roomId);
                sp.updateSession(s);
                session.setAttribute("message", "Success: Room " + l.getDescription() + " successfully assigned to Session " + h.getName() + "!");
            }
            catch (Exception e) {
                
                session.setAttribute("message", "Error: Room " + l.getDescription() + " already assigned to Session " + h.getName());
            }
                
        }
        else {
            session.setAttribute("message", "Error: Room " + l.getDescription() + " already assigned to another Session at that time.");
        }
            response.sendRedirect("../admin/session.jsp");
        
    %>
</html>

