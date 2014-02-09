<%@page import="java.util.Calendar"%>
<link href="http://growler.elasticbeanstalk.com/css/navbar.css" rel="stylesheet">
<link href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" rel="stylesheet">
<%
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
    Calendar calendar = Calendar.getInstance();
%>
<nav class="topnav navbar">
        <nav class="globalNavigation modify-pages" id="navigation">
            <ul class="nav">
                <li class="non_drop <%= home%>" style="padding-right:12px" ><a href="../../private/employee/home.jsp"><span>Home</span></a></li>
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
                <li class="brand_nav <%= sessionTab%>"><a href="#" style='padding-left:8px;'><span class="nav_drop">Sessions</span><em></em></a>
                    <ul class="child-menu child-menu-ul">
                        <li><a href="../../private/employee/sessionschedule.jsp">View Session Schedule</a></li>
                        <li><a href="../../private/employee/surveys.jsp">Submit Session Feedback</a></li>
                    </ul>
                </li>
                                <li class="brand_nav <%= blogTab%>"><a href="http://techtoberfest.scrippsnetworks.com/" style='padding-left:8px;'><span class="nav_drop">Blog</span><em></em></a>
                </li>
            </ul>
        </nav>
</nav>