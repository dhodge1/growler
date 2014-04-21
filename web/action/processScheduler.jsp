<%-- 
    Document   : processScheduler
    Created on : Jun 24, 2013, 11:59:45 AM
    Author     : 162107
--%>

<%@page import="com.scripps.growler.Session"%>
<%@page import="com.scripps.growler.SessionPersistence"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <% 
            SessionPersistence sp = new SessionPersistence();
            java.sql.Time start = java.sql.Time.valueOf("08:00:00");
            java.sql.Date day1 = java.sql.Date.valueOf("2014-10-17");
            java.sql.Date day2 = java.sql.Date.valueOf("2014-10-18");
            String[] list1 = request.getParameterValues("list1");
            for (int i = 0; i < list1.length; i++) {
                if (!list1[i].equals(0)) {
                    Session s = sp.getSessionByID(Integer.parseInt(list1[i])); //Get the session info
                    s.setSessionDate(day1);
                    s.setLocation("E130"); //set the room number
                    start.setHours(start.getHours() + i); //Add the appropriate Amount of hours
                    s.setStartTime(start); //Set the new Start
                    sp.updateSession(s); //Update the Session
                    start.setHours(8); //Reset the Start Time
                }
            }
            String[] list2 = request.getParameterValues("list2");
            for (int i = 0; i < list2.length; i++) {
                if (!list2[i].equals(0)) {
                    Session s = sp.getSessionByID(Integer.parseInt(list2[i])); //Get the session info
                    s.setSessionDate(day1);
                    s.setLocation("D304"); //set the room number
                    start.setHours(start.getHours() + i); //Add the appropriate Amount of hours
                    s.setStartTime(start); //Set the new Start
                    sp.updateSession(s); //Update the Session
                    start.setHours(8); //Reset the Start Time
                }
            }
            String[] list3 = request.getParameterValues("list3");
            for (int i = 0; i < list3.length; i++) {
                if (!list3[i].equals(0)) {
                    Session s = sp.getSessionByID(Integer.parseInt(list3[i])); //Get the session info
                    s.setSessionDate(day2);
                    s.setLocation("E130"); //set the room number
                    start.setHours(start.getHours() + i); //Add the appropriate Amount of hours
                    s.setStartTime(start); //Set the new Start
                    sp.updateSession(s); //Update the Session
                    start.setHours(8); //Reset the Start Time
                }
            }
            String[] list4 = request.getParameterValues("list4");
            for (int i = 0; i < list4.length; i++) {
                if (!list4[i].equals(0)) {
                    Session s = sp.getSessionByID(Integer.parseInt(list4[i])); //Get the session info
                    s.setSessionDate(day2);
                    s.setLocation("D304"); //set the room number
                    start.setHours(start.getHours() + i); //Add the appropriate Amount of hours
                    s.setStartTime(start); //Set the new Start
                    sp.updateSession(s); //Update the Session
                    start.setHours(8); //Reset the Start Time
                }
            }
            session.setAttribute("message", "Success: Schedule changes made!");
            response.sendRedirect("../private/employee/admin/session.jsp?year=2014");
        %>