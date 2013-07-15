<link href="http://sni-techtoberfest.elasticbeanstalk.com/css/navbar.css" rel="stylesheet">
<link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->

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
	<li class="non_drop <%= home %>" style="padding-right:12px" ><a href="home.jsp" style='padding-bottom:8px;'><span>Home</span></a></li>
	<li class="brand_nav <%= themeTab %>" style="padding-left:12px"><a href="#"><span>Themes</span><em></em></a>
		<ul class="child-menu child-menu-ul">
			<li><a href="theme.jsp">Rank Preferred Themes</a></li>
			<li><a href="themeentry.jsp">Suggest a New Theme</a></li>
		</ul>
	</li>
	<li class="brand_nav <%= speakerTab %>"><a href="#" style='padding-left:8px;'><span class="nav_drop">Speakers</span><em></em></a>
		<ul class="child-menu child-menu-ul">
			<li><a href="speaker.jsp">Rank Preferred Speakers</a></li>
			<li><a href="speakerentry.jsp">Suggest a New Speaker</a></li>
		</ul>
	</li>
	<li class="brand_nav <%= sessionTab %>"><a href="#" style='padding-left:8px;'><span class="nav_drop">Sessions</span><em></em></a>
		<ul class="child-menu child-menu-ul">
			<li><a href="sessionschedule.jsp">View Session Schedule</a></li>
			<li><a href="attendance.jsp">Acknowledge Attendance</a></li>
			<li><a href="surveylist.jsp">Take a Survey</a></li>
		</ul>
	</li>
  </ul>
</nav>
</nav>