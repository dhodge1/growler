<%-- 
    Document   : usernav
    Created on : Apr 4, 2013, 4:25:29 PM
    Author     : Justin Bauguess & Jonathan C. McCowan
    Purpose    : The usernav file goes below the header.jsp file.  It contains 
                 the navigation for users.
--%>
<%@page import="java.util.Calendar"%>
<link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
<link href="http://growler.elasticbeanstalk.com/css/navbar.css" rel="stylesheet">
<% 
    Calendar calendar = Calendar.getInstance();
    String active = " selected ";
    String pageURI = request.getRequestURI();
    String home = "";
    String themeTab = "";
    String speakerTab = "";
    String sessionTab = "";
    if (pageURI.contains("theme")) {
        themeTab = active;
    } else if (pageURI.contains("speaker")) {
        speakerTab = active;
    } else if (pageURI.contains("session") || pageURI.contains("attendance") || pageURI.contains("survey")) {
        sessionTab = active;
    } else if (pageURI.contains("home")) {
        home = " selected ";
    }
%>
<link href="http://growler.elasticbeanstalk.com/css/responsive.1.2.0.css" rel="stylesheet">
<nav class="topnav navbar">
        <nav class="globalNavigation modify-pages" id="navigation">
            <ul class="nav">
                <li class="non_drop <%= home%>" style="padding-right:12px" ><a href="../../private/employee/home.jsp"><span>Home</span></a></li>
                <% if ((calendar.get(Calendar.MONTH) == 8 && calendar.get(Calendar.DAY_OF_MONTH) < 19)) { // if it's before September 19th%>
                <li class="brand_nav <%= themeTab%>" style="padding-left:12px"><a href="#"><span>Themes</span><em></em></a>
                    <ul class="child-menu child-menu-ul firstnav" style="left:11px;">
                        <li><a href="../../private/employee/theme.jsp">Rank Preferred Themes</a></li>
                        <li><a href="../../private/employee/themeentry.jsp">Suggest a New Theme</a></li>
                    </ul>
                </li>
                <li class="brand_nav <%= speakerTab%>"><a href="#" style='padding-left:8px;'><span class="nav_drop">Speakers</span><em></em></a>
                    <ul class="child-menu child-menu-ul">
                        <li><a href="../../private/employee/speaker.jsp">Rank Preferred Speakers</a></li>
                        <li><a href="../../private/employee/speakerentry.jsp">Suggest a New Speaker</a></li>
                        <li><a href="../../private/employee/nominate.jsp">Nominate Yourself As A Speaker</a></li>
                    </ul>
                </li>
                <% } //end if %>
                <% if ((calendar.get(Calendar.MONTH) == 8 || calendar.get(Calendar.MONTH) == 9 ) && calendar.get(Calendar.DAY_OF_MONTH) > 19) { // if it's after August%>
                <li class="brand_nav <%= sessionTab%>" style="padding-left:12px"><a href="#" style='padding-left:8px;'><span class="nav_drop">Sessions</span><em></em></a>
                    <ul class="child-menu child-menu-ul firstnav" style="left:11px;">
                        <li><a href="../../private/employee/sessionschedule.jsp">View Session Schedule</a></li>
                        <% if (calendar.get(Calendar.MONTH) > 8) { //if it's after September %>
                        <li><a href="../../private/employee/surveys.jsp">Submit Session Feedback</a></li>
                        <%  } %>
                    </ul>
                </li>
                <% } %>
            </ul>
        </nav>
</nav>