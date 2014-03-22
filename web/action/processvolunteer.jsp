<%-- 
    Document   : processvolunteer
    Created on : Jun 24, 2013, 9:08:21 AM
    Author     : 162107
    Purpose    : This file processes the parameters given from the view/volunteer.jsp
                file.  It will delete the records of volunteering first, because you can
                only volunteer for one event, and this prevents multiple entries for the same
                 person.  Next, it checks to see if the user selected they didn't want to
                 volunteer.  If that's the case, it skips adding a new task.  Otherwise,
                 it adds the task passed by the previous page, and redirects to the home page.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%
    UserPersistence up = new UserPersistence();
    int id = (Integer) session.getAttribute("id");
    String task = request.getParameter("task");
    up.removeVolunteer(id);
    session.setAttribute("message", "Success: Your interest in volunteering has been removed!");
    if (!task.equals("null")) {
        up.setVolunteer(id, task);
        session.setAttribute("message", "Success: Your interest in volunteering for " + task + " has been recorded!  Thanks!");
    }
    response.sendRedirect("../home");
%>
