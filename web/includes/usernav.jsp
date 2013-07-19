<%-- 
    Document   : usernav
    Created on : Apr 4, 2013, 4:25:29 PM
    Author     : Justin Bauguess & Jonathan C. McCowan
    Purpose    : The usernav file goes below the header.jsp file.  It contains 
                 the navigation for users.
--%>
<link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
<link href="http://sni-techtoberfest.elasticbeanstalk.com/css/navbar.css" rel="stylesheet">
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
%>
<link href="http://sni-techtoberfest.elasticbeanstalk.com/css/responsive.1.2.0.css" rel="stylesheet">
<nav class="topnav">
<nav class="globalNavigation modify-pages" id="navigation">
  <ul>
	<li class="non_drop <%= home %>" style="padding-right:12px" ><a href="../private/employee/home.jsp"><span>Home</span></a></li>
	<li class="brand_nav <%= themeTab %>" style="padding-left:12px"><a href="#"><span>Themes</span><em></em></a>
		<ul class="child-menu child-menu-ul">
			<li><a href="../private/employee/theme.jsp">Rank Preferred Themes</a></li>
			<li><a href="../private/employee/themeentry.jsp">Suggest a New Theme</a></li>
		</ul>
	</li>
	<li class="brand_nav <%= speakerTab %>"><a href="#" style='padding-left:8px;'><span class="nav_drop">Speakers</span><em></em></a>
		<ul class="child-menu child-menu-ul">
			<li><a href="../private/employee/speaker.jsp">Rank Preferred Speakers</a></li>
			<li><a href="../private/employee/speakerentry.jsp">Suggest a New Speaker</a></li>
		</ul>
	</li>
	<li class="brand_nav <%= sessionTab %>"><a href="#" style='padding-left:8px;'><span class="nav_drop">Sessions</span><em></em></a>
		<ul class="child-menu child-menu-ul">
			<li><a href="../private/employee/sessionschedule.jsp">View Session Schedule</a></li>
			<li><a href="../private/employee/attendance.jsp">Acknowledge Attendance</a></li>
			<li><a href="../private/employee/surveylist.jsp">Take a Survey</a></li>
		</ul>
	</li>
  </ul>
</nav>
</nav>