<%-- 
    Document   : processRemoteRooms
    Created on : Mar 10, 2014, 3:47:37 PM
    Author     : David
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
        <%
            int user = 0;
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../index.jlp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
            
            String localRoom = String.valueOf(session.getAttribute("localID"));
            String room = request.getParameter("room");
            String room2 = "blorg";
            String room3 = "blorg";
            String room4 = "blorg";
            String room5 = "blorg";
            String room6 = "blorg";
            try {
                room2 = request.getParameter("room2");
                room3 = request.getParameter("room3");
                room4 = request.getParameter("room4");
                room5 = request.getParameter("room5");
                room6 = request.getParameter("room6");
            } catch (Exception e){
                
            }

            LocationPersistence lp = new LocationPersistence();
            try {
                //9-8 commented out the location checks, since they are currently not part of the adding session page
                //ArrayList<Session> ses = lp.getSessionsByDateAndTime(java.sql.Date.valueOf(date), java.sql.Time.valueOf(time));

                //boolean ok = true;
                //for (int i = 0; i < ses.size(); i++) {
                    //Gets the session scheduled for that time, then compares them to the location parameter
                    //Excuses TBD, because any number of sessions can have TBD as the location
                //    if (ses.get(i).getLocation().equals(location) && !location.equals("TBD")) {
                //        session.setAttribute("message", "Error: There is already a session scheduled for that room at that time");
                //        ok = false;
                //    }
                //}
               // if (ok) {
                    lp.assignRemoteRoom(room, localRoom);
                    if(room2 != null && !room2.isEmpty() && room2 != "blorg") {
                        lp.assignRemoteRoom(room2, localRoom);
                    }
                    if(room3 != null && !room3.isEmpty() && room3 != "blorg") {
                        lp.assignRemoteRoom(room3, localRoom);
                    }
                    if(room4 != null && !room4.isEmpty() && room4 != "blorg") {
                        lp.assignRemoteRoom(room4, localRoom);
                    }
                    if(room5 != null && !room5.isEmpty() && room5 != "blorg") {
                        lp.assignRemoteRoom(room5, localRoom);
                    }
                    if(room6 != null && !room6.isEmpty() && room6 != "blorg") {
                        lp.assignRemoteRoom(room6, localRoom);
                    }
                    

               // }
            } catch (Exception e) {
                //lp.addSession(s);
                //session.setAttribute("message", "Success: Session " + s.getName() + " for " + s.getSessionDate() + " added successfully!");
            }
            response.sendRedirect("../private/employee/admin/room.jsp");
        %>