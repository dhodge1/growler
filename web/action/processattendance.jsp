<%-- 
    Document   : processattendance
    Created on : Apr 17, 2013, 11:00:30 PM
    Author     : Justin Bauguess
    Purpose    : Adds the record of attendance into the database.  
                 Checks against current time to ensure a user
                 didn't just leave the attendance page up, then checks against other sessions 
                 to ensure the user isn't registering for a session in the same time slot.
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
<%@page import="com.scripps.growler.SessionPersistence" %>
<%@page import="com.scripps.growler.Session" %>
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
            Calendar today = Calendar.getInstance();
            String date = today.get(Calendar.YEAR) + "-" + (today.get(Calendar.MONTH) + 1) + "-" + today.get(Calendar.DATE);
            String time = today.get(Calendar.HOUR) + ":" + today.get(Calendar.MINUTE) + ":" + today.get(Calendar.SECOND);
            int sessionId = Integer.parseInt(request.getParameter("session"));
            String key = request.getParameter("skey");
            String sessionName = "";

            boolean success = false;

            DataConnection dataConnection = new DataConnection();
            Connection connection = dataConnection.sendConnection();
            PreparedStatement changeTime = connection.prepareStatement("set time_zone = 'US/Eastern'");
            changeTime.execute();
            Statement statement = connection.createStatement();
            //Query against the end of a session + the 15 minutes
            ResultSet result = statement.executeQuery("select id, name from session where session_date = curdate() and addtime(start_time, duration) <= curtime() and addtime(addtime(start_time,duration), '00:15:00') >= curtime() and id = " + sessionId);
            result.next();
            int check = result.getInt(1);
            if (check == 0) {
                session.setAttribute("message", "Error: Too late to acknowledge for this session");
            } else {
                //Ensure the key matches
                Statement newStatement = connection.createStatement();
                ResultSet keycheck = newStatement.executeQuery("select count(id) from session where session_key = '" + key + "'");
                keycheck.next();
                if (keycheck.getInt(1) == 0) {
                    session.setAttribute("message", "Error: Invalid Session Key ");
                } else {
                    //Prevent the same time slot registration
                    ResultSet duplicate = statement.executeQuery("select count(a.session_id) from attendance a, session s where a.user_id = " + user + " and s.start_time = (select start_time from session where id = " + sessionId + ") and s.session_date = curdate() and a.session_id = s.id");
                    duplicate.next();
                    int check2 = duplicate.getInt(1);
                    if (check2 == 0) {
                        //if there aren't any sessions there, add attendance record to DB
                        statement.execute("insert into attendance (user_id, session_id, isSurveyTaken, surveySubmitTime) values ("
                                + user + ", " + sessionId + ", false, null)");
                        session.setAttribute("message", "Success: Attendance sucessfully acknowledged!");
                        SessionPersistence sp = new SessionPersistence();
                        session.setAttribute("sessionName", sp.getSessionByID(sessionId).getName());
                        session.setAttribute("page", "../private/employee/attendance.jsp");
                        success = true;
                    } else {
                        session.setAttribute("message", "Error: Already registered in that time slot!");
                    }
                    duplicate.close();
                }
            }
            
            connection.close();
            statement.close();
            result.close();
            
            if (success) {
                //Email the user a message that they should take a survey
                response.sendRedirect("../action/emailer.jsp?session=" + sessionId);
            } else {
                response.sendRedirect("../private/employee/attendance.jsp");
            }
        %>