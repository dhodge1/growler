<%-- 
    Document   : usernav
    Created on : Apr 4, 2013, 4:25:29 PM
    Author     : Justin Bauguess & Jonathan C. McCowan
    Purpose    : The usernav file goes below the header.jsp file.  It contains 
                 the navigation for users.
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
  </nav><!-- /.globalNavigation -->
