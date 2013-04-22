<%-- 
    Document   : usernav
    Created on : Apr 4, 2013, 4:25:29 PM
    Author     : Justin Bauguess & Jonathan C. McCowan
    Purpose    : The usernav file goes above the header.jsp file.  It contains 
                the navigation for users.
                As of 4/16, it also will send users who aren't logged in to the
                log in page.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <nav class="globalNavigation">
        <ul>
            <li><a href="../view/theme.jsp">Themes</a></li>
            <li><a href="../view/themeentry.jsp">Suggest a Theme</a></li>
            <li><a href="../view/speaker.jsp">Speakers</a></li>
            <li><a href="../view/speakerentry.jsp">Suggest a Speaker</a></li>
            <li><a href="../view/attendance.jsp">Attendance</a></li>
            <li><a href="../view/surveys.jsp">Surveys</a></li>
            <li><a href="../help/help.jsp">Help</a></li>
			<li><a href="../model/logout.jsp">Logout</a></li>
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
  </nav><!-- /.globalNavigation -->
