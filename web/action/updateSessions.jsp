<%-- 
    Document   : updateSessions
    Created on : Jul 18, 2013, 2:50:55 PM
    Author     : 162107
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.scripps.growler.*"%>
<%
    SessionPersistence sp = new SessionPersistence();
    LocationPersistence lp = new LocationPersistence();
    int pageNo = Integer.parseInt(request.getParameter("pageNo"));
    pageNo *= 15;
    SimpleDateFormat dates = new SimpleDateFormat("MM/dd/yyyy");
    SimpleDateFormat fmt = new SimpleDateFormat("h:mm a");
    SimpleDateFormat fmt2 = new SimpleDateFormat("mm 'minutes'");
    ArrayList<Session> sessions = sp.getThisYearSessions(2013, " order by session_date, start_time, name ", pageNo);
    for (int i = 0; i < sessions.size(); i++) {
        response.getWriter().write("<tr>");
        response.getWriter().write("<td>");
        response.getWriter().write(dates.format(sessions.get(i).getSessionDate()));
        response.getWriter().write("</td>");
        response.getWriter().write("<td>");
        try {
            response.getWriter().write(fmt.format(sessions.get(i).getStartTime()));
        } catch (Exception e) {
            response.getWriter().write("No Time");
        }
        response.getWriter().write("</td>");
        response.getWriter().write("<td>");
        response.getWriter().write(sessions.get(i).getName());
        response.getWriter().write("</td>");
        response.getWriter().write("<td>");
        response.getWriter().write("VIEW");
        response.getWriter().write("</td>");
        response.getWriter().write("<td>");
        response.getWriter().write("SPEAKERS");
        response.getWriter().write("</td>");
        response.getWriter().write("<td>");
        response.getWriter().write(fmt2.format(sessions.get(i).getDuration()));
        response.getWriter().write("</td>");
        response.getWriter().write("<td>");
        response.getWriter().write(lp.getLocationById(sessions.get(i).getLocation()).getDescription() + "<br/>" + lp.getLocationById(sessions.get(i).getLocation()).getBuilding());
        response.getWriter().write("</td>");
        response.getWriter().write("<td>");
        response.getWriter().write(lp.getLocationById(sessions.get(i).getLocation()).getCapacity());
        response.getWriter().write("</td>");
        response.getWriter().write("</tr>");
    }
%>