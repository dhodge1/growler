<%-- 
    Document   : adminnav
    Created on : Apr 4, 2013, 4:25:29 PM
    Author     : Justin Bauguess
    Purpose    : The adminnav file goes under the header.jsp file on the pages
                in the admin folder.  It contains links that only the admin should 
                be able to look at.
--%>
<link href="http://growler.elasticbeanstalk.com/css/navbar.css" rel="stylesheet">
<link href="../../../css/bootstrap-responsive.css" rel="stylesheet">
<%
    String pageURI = request.getRequestURI();
    String active = " selected ";
    String themeTab = "";
    String speakerTab = "";
    String sessionTab = "";
    String roomTab = "";
    String reportTab = "";
    String home = "";
    String blogTab = "";
    if (pageURI.contains("theme")) {
        themeTab = active;
    } else if (pageURI.contains("Report") || pageURI.contains("speakerReport")) {
        reportTab = active;
    } else if (pageURI.contains("speaker")) {
        speakerTab = active;
    } else if (pageURI.contains("session") || pageURI.contains("comments")) {
        sessionTab = active;
    } else if (pageURI.contains("room")) {
        roomTab = active;
    } else if (pageURI.contains("home")) {
        home = active;
    }
%>
<nav class="topnav">
    <nav class="globalNavigation modify-pages" id="navigation">
        <ul>
            <li class="non_drop <%= home%>" style="padding-right:12px" ><a href="../../../private/employee/admin/home.jsp"><span>Home</span></a></li>
            <li class="brand_nav <%= themeTab%>" style="padding-left:12px"><a href="#"><span>Themes</span><em></em></a>
                <ul class="child-menu child-menu-ul firstnav" style="left:11px;">
                    <li><a href="../../../private/employee/admin/theme.jsp">Manage Themes</a></li>
                    <li><a href="../../../private/employee/admin/themeentry.jsp">Suggest a New Theme</a></li>
                </ul>
            </li>
            <li class="brand_nav <%= speakerTab%>"><a href="#"><span class="nav_drop">Speakers</span><em></em></a>
                <ul class="child-menu child-menu-ul">
                    <li><a href="../../../private/employee/admin/speaker.jsp">Manage Speakers</a></li>
                    <li><a href="../../../private/employee/admin/speakerentry.jsp">Suggest a New Speaker</a></li>
                </ul>
            </li>
            <li class="brand_nav <%= roomTab%>"><a href="#"><span class="nav_drop">Rooms</span><em></em></a>
                <ul class="child-menu child-menu-ul">
                    <li><a href="../../../private/employee/admin/room.jsp">Manage Rooms</a></li>
                </ul>
            </li>
            <li class="brand_nav <%= sessionTab%>"><a href="#"><span class="nav_drop">Sessions</span><em></em></a>
                <ul class="child-menu child-menu-ul">
                    <li><a href="../../../private/employee/admin/session.jsp">Manage Session Schedule</a></li>
                </ul>
            </li>
               <li class="brand_nav <%= blogTab%>"><a href="http://techtoberfest.scrippsnetworks.com/"><span>Blog</span><em></em></a>
                </li>  
                <li class="brand_nav <%= reportTab%>"><a href="#"><span class="nav_drop">Reports</span><em></em></a>
                <ul class="child-menu child-menu-ul">
                    <li><a href="../../../private/employee/admin/overallReport.jsp">Best Overall Session</a></li>
                    <li><a href="../../../private/employee/admin/presentationReport.jsp">Best Presentation Skills</a></li>
                    <li><a href="../../../private/employee/admin/confirmationReport.jsp">Confirmed Attendance</a></li>
                    <li><a href="../../../private/employee/admin/interestReport.jsp">Session Interest</a></li>
                    <li><a href="../../../private/employee/admin/expectationReport.jsp">Session Met Expectations</a></li>
                    <li><a href="../../../private/employee/admin/surveyReport.jsp">Surveys</a></li>
                    
                </ul>
            </li>
             
  
        </ul>
    </nav>
</nav>