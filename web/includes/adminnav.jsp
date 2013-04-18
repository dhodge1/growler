<%-- 
    Document   : adminnav
    Created on : Apr 4, 2013, 4:25:29 PM
    Author     : Justin Bauguess
    Purpose    : The adminnav file goes under the header.jsp file on the pages
                in the admin folder.  It contains links that only the admin should 
                be able to look at.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <nav class="globalNavigation">
        <ul>
            <li><a href="../admin/theme.jsp">Themes</a></li>
            <li><a href="../admin/themeentry.jsp">Add a Theme</a></li>
            <li><a href="../admin/speaker.jsp">Speakers</a></li>
            <li><a href="../admin/userspeaker.jsp">Suggested Speakers</a></li>
            <li><a href="../admin/speakerentry.jsp">Add a Speaker</a></li>
            <li><a href="../admin/session.jsp">Sessions</a></li>
            <li><a href="../admin/attendance.jsp">Attendance</a></li>
            <li><a href="">Help</a></li>
        </ul>
          <%
     //Get the user's info, and post a welcome!
     if (!String.valueOf(session.getAttribute("user")).isEmpty()) {
        String user = String.valueOf(session.getAttribute("user"));
        out.print("    Welcome, " + user + "!");
        }
     //If they aren't logged in, we want them to go back and log in.
     else {
        response.sendRedirect("../index.jsp");
     }
     %>
     <a href="../model/logout.jsp">    Logout</a>
  </nav><!-- /.globalNavigation -->
