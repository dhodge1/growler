<%-- 
    Document   : processSession
    Created on : May 23, 2013, 9:40:24 AM
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
            
            String date = request.getParameter("date");
            String time = request.getParameter("time");
            //Get the 'a' or 'b' from the time string
            char marker = time.charAt(8);
            //Chop off the 'a' or 'b'
            time = time.substring(0, 7);
            String description = request.getParameter("description");
            String name = request.getParameter("name");
            String speaker = request.getParameter("speaker");
            String theme = request.getParameter("theme");
            int themeID = Integer.parseInt(theme);
            int spkrId = Integer.parseInt(speaker);
            int spkrId2 = 0;
            int spkrId3 = 0;
            int spkrId4 = 0;
            int spkrId5 = 0;
            int spkrId6 = 0;
            try {
            String speaker2 = request.getParameter("speaker2");
            spkrId2 = Integer.parseInt(speaker2);
            String speaker3 = request.getParameter("speaker3");
            spkrId3 = Integer.parseInt(speaker3);
            String speaker4 = request.getParameter("speaker4");
            spkrId4 = Integer.parseInt(speaker4);
            String speaker5 = request.getParameter("speaker5");
            spkrId5 = Integer.parseInt(speaker5);
            String speaker6 = request.getParameter("speaker6");
            spkrId6 = Integer.parseInt(speaker6);
            } catch (Exception e){
                
            }
            
            Session s = new Session();
            s.setName(name);
            s.setDescription(description);
            try {
                s.setSessionDate(java.sql.Date.valueOf(date));
                s.setStartTime(java.sql.Time.valueOf(time));
                if (marker == 'b'){
                    s.setDuration(java.sql.Time.valueOf("00:50:00"));
                }
                else {
                    s.setDuration(java.sql.Time.valueOf("00:25:00"));
                }
            } catch (Exception e) {
            }
            SessionPersistence sp = new SessionPersistence();
            ThemePersistence tp = new ThemePersistence();
            try {
                //9-8 commented out the location checks, since they are currently not part of the adding session page
                //ArrayList<Session> ses = sp.getSessionsByDateAndTime(java.sql.Date.valueOf(date), java.sql.Time.valueOf(time));

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
                    sp.addSession(s);
                    session.setAttribute("message", "Success: The following session has been added successfully!");
                    //Get the newly created Session ID and assign the speaker to it
                    Session ses = sp.getSessionByName(name);
                    tp.mapThemeToSession(themeID, ses.getId());
                    sp.assignSpeaker(spkrId, ses.getId());
                    SpeakerPersistence sk = new SpeakerPersistence();
                    Speaker sendSpeakerInfo = sk.getSpeakerByID(spkrId);
                    if (spkrId2 != 0) {
                        sp.assignSpeaker(spkrId2, ses.getId());
                        session.setAttribute("sessionSpkr2", sk.getSpeakerByID(spkrId2).getFullName());
                    }
                    if (spkrId3 != 0) {
                        sp.assignSpeaker(spkrId3, ses.getId());
                        session.setAttribute("sessionSpkr3", sk.getSpeakerByID(spkrId3).getFullName());
                    }
                    if (spkrId4 != 0) {
                        sp.assignSpeaker(spkrId4, ses.getId());
                        session.setAttribute("sessionSpkr4", sk.getSpeakerByID(spkrId4).getFullName());
                    }
                    if (spkrId5 != 0) {
                        sp.assignSpeaker(spkrId5, ses.getId());
                        session.setAttribute("sessionSpkr5", sk.getSpeakerByID(spkrId5).getFullName());
                    }
                    if (spkrId6 != 0) {
                        sp.assignSpeaker(spkrId6, ses.getId());
                        session.setAttribute("sessionSpkr6", sk.getSpeakerByID(spkrId6).getFullName());
                    }
                    session.setAttribute("sessionName", name);
                    session.setAttribute("sessionDesc", description);
                    session.setAttribute("sessionSpkr", sendSpeakerInfo.getFullName());
                    session.setAttribute("sessionDate", date);
                    session.setAttribute("sessionTime", time);
                    session.setAttribute("sessionID", ses.getId());

               // }
            } catch (Exception e) {
                //sp.addSession(s);
                //session.setAttribute("message", "Success: Session " + s.getName() + " for " + s.getSessionDate() + " added successfully!");
            }
            response.sendRedirect("../private/employee/admin/sessionadd-confirm.jsp");
        %>
