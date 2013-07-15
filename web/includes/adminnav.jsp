<%-- 
    Document   : adminnav
    Created on : Apr 4, 2013, 4:25:29 PM
    Author     : Justin Bauguess
    Purpose    : The adminnav file goes under the header.jsp file on the pages
                in the admin folder.  It contains links that only the admin should 
                be able to look at.
--%>

<link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
<link href="http://sni-techtoberfest.elasticbeanstalk.com/css/navbar.css" rel="stylesheet">
<style>
    body {
        padding-bottom: 30px;
    }
</style>
<%
    String pageURI = request.getRequestURI();
    String active = " selected ";
    String themeTab = "";
    String speakerTab = "";
    String sessionTab = "";
    String roomTab = "";
    String reportTab = "";
    String home = "";
    if (pageURI.contains("theme")) {
        themeTab = active;
    } else if (pageURI.contains("speaker")) {
        speakerTab = active;
    } else if (pageURI.contains("session") || pageURI.contains("comments")) {
        sessionTab = active;
    } else if (pageURI.contains("room")) {
        roomTab = active;
    } else if (pageURI.contains("Report")) {
        sessionTab = active;
    } else if (pageURI.contains("home")) {
        home = active;
    }
%>
<link href="http://sni-techtoberfest.elasticbeanstalk.com/css/responsive.1.2.0.css" rel="stylesheet">
<nav class="topnav">
<nav class="globalNavigation modify-pages" id="navigation">
  <ul>
	<li class="non_drop <%= home %>" style="padding-right:12px" ><a href="home.jsp"><span>Home</span></a></li>
	<li class="brand_nav <%= themeTab %>" style="padding-left:12px"><a href="#"><span>Themes</span><em></em></a>
		<ul class="child-menu child-menu-ul">
			<li><a href="theme.jsp">Edit Themes</a></li>
			<li><a href="themeentry.jsp">Suggest a New Theme</a></li>
		</ul>
	</li>
	<li class="brand_nav <%= speakerTab %>"><a href="#"><span class="nav_drop">Speakers</span><em></em></a>
		<ul class="child-menu child-menu-ul">
			<li><a href="speaker.jsp">Edit Speakers</a></li>
			<li><a href="speakerentry.jsp">Suggest a New Speaker</a></li>
                        <li><a href="assignspeaker.jsp">Assign Speaker to a Session</a></li>
		</ul>
	</li>
	<li class="brand_nav <%= roomTab %>"><a href="#"><span class="nav_drop">Rooms</span><em></em></a>
		<ul class="child-menu child-menu-ul">
			<li><a href="addroom.jsp">Add a Room</a></li>
                        <li><a href="room.jsp">View Rooms</a></li>
                        <li><a href="assignroom.jsp">Assign Room to a Session</a></li>
		</ul>
	</li>
	<li class="brand_nav <%= sessionTab %>"><a href="#"><span class="nav_drop">Sessions</span><em></em></a>
		<ul class="child-menu child-menu-ul">
			<li><a href="sessionScheduler.jsp">Schedule Sessions</a></li>
			<li><a href="session.jsp">View Sessions</a></li>
                        <li><a href="comments.jsp">Session Comments</a></li>
		</ul>
	</li>
	<li class="brand_nav <%= reportTab %>"><a href="#"><span class="nav_drop">Reports</span><em></em></a>
		<ul class="child-menu child-menu-ul">
			<li><a href="surveyReport.jsp">Users Who Completed Surveys</a></li>
                        <li><a href="interestReport.jsp">Interest in Sessions</a></li>
			<li><a href="registrationAttendanceReport.jsp">Registration vs. Attendance</a></li>
                        <li><a href="expectationReport.jsp">Session Met Expectations</a></li>
			<li><a href="speakerReport.jsp">Speaker Was Knowledgeable</a></li>
                        <li><a href="presentationReport.jsp">Best Presentation Skills</a></li>
                        <li><a href="overallReport.jsp">Best Overall Session</a></li>
		</ul>
	</li>
  </ul>
</nav>
</nav>