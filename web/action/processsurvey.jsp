<%-- 
    Document   : processattendance
    Created on : Apr 17, 2013, 11:00:30 PM
    Author     : Justin Bauguess
    Purpose    : Adds the record of survey
                 into the database.
--%>
<%@page import="com.sun.org.apache.regexp.internal.REUtil"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.*"%>
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
            } catch (Exception e) {
            }
            String sessionId = (String) session.getAttribute("sessionId");
            //Make sure user didn't click back and try to take survey again
            AttendancePersistence ap = new AttendancePersistence();
            ArrayList<Attendance> attendances = ap.getAttendanceBySession(Integer.parseInt(sessionId));
            for (int a = 0; a < attendances.size(); a++) {
                if (user == attendances.get(a).getUserId() && attendances.get(a).getIsSurveyTaken() == true) {
                    session.setAttribute("message", "Error: You have already taken this survey");
                    response.sendRedirect("../private/employee/surveylist.jsp");
                }

            }
            String question1 = String.valueOf(request.getParameter("q1"));
            String question2 = String.valueOf(request.getParameter("q2"));
            String question3 = String.valueOf(request.getParameter("q3"));
            String question4 = String.valueOf(request.getParameter("q4"));
            try {
                String comment = String.valueOf(request.getParameter("comment"));
                comment = comment.trim();
                if (!comment.isEmpty()) {
                    CommentPersistence cp = new CommentPersistence();
                    Comment c = new Comment(Integer.parseInt(sessionId), comment);
                    cp.addComment(c);
                }
            } catch (Exception e) {
                //No comment found
            }
            Connection connection = dataConnection.sendConnection();
            Statement statement = connection.createStatement();
            statement.execute("insert into session_ranking (question_id, session_id, ranking) values "
                    + "(" + 1 + ", " + sessionId + ", " + question1 + "),"
                    + "(" + 2 + ", " + sessionId + ", " + question2 + "),"
                    + "(" + 3 + ", " + sessionId + ", " + question3 + "),"
                    + "(" + 4 + ", " + sessionId + ", " + question4 + ")");
            Statement statement2 = connection.createStatement();
            statement2.execute("update attendance set isSurveyTaken = true, surveySubmitTime = NOW() where user_id = " + user + " and session_id = " + sessionId);
            connection.close();
            statement.close();
            session.removeAttribute("session");
            SessionPersistence sp = new SessionPersistence();
            session.setAttribute("message", "Success: Survey for " + sp.getSessionByID(Integer.parseInt(sessionId)).getName() + " complete!");
            response.sendRedirect("../private/employee/surveylist.jsp");
        %>