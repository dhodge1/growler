<%-- 
    Document   : adminnav
    Created on : Apr 4, 2013, 4:25:29 PM
    Author     : Justin Bauguess
    Purpose    : The adminnav file goes under the header.jsp file on the pages
                in the admin folder.  It contains links that only the admin should 
                be able to look at.
--%>

<link href="../../../css/bootstrap.css" rel="stylesheet">
<style>
    body {
        padding-bottom: 30px;
    }
</style>
<%
    String pageURI = request.getRequestURI();
    String active = "active";
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
        sessionTab = active;
    } else if (pageURI.contains("Report")) {
        sessionTab = active;
    } else if (pageURI.contains("home")) {
        home = "class=\"active\"";
    }
%>
<link href="../../../css/bootstrap-responsive.css" rel="stylesheet">
<div class="navbar">
    <div class="navbar-inner">
        <div class="container">
            <a class="btn btn-navbar pull-right" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>
            <a class="brand" href="../admin/home.jsp">Techtoberfest Information System</a>
            <div class="nav-collapse collapse">
                <ul class="nav">
                    <li <%= home%>><a href="../admin/home.jsp">Home</a></li>
                    <li class="dropdown <%= themeTab%>">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Themes <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../admin/theme.jsp">Edit Themes</a></li>
                            <li><a href="../admin/themeentry.jsp">Add New Themes</a></li>
                        </ul>
                    </li>
                    <li class="dropdown <%= speakerTab%>">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Speakers <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../admin/speaker.jsp">Edit Speakers</a></li>
                            <li><a href="../admin/speakerentry.jsp">Add New Speakers</a></li>
                            <li><a href="../admin/userspeaker.jsp">Suggested Speakers</a></li>
                            <li><a href="../admin/assignspeaker.jsp">Assign Speaker to a Session</a></li>
                        </ul>
                    </li>
                    <li class="dropdown <%= sessionTab%>">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Sessions <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../admin/addsession.jsp">Add a Session</a></li>
                            <li><a href="../admin/session.jsp">View Sessions</a></li>
                            <li><a href="../admin/sessionScheduler.jsp">Schedule Sessions</a></li>
                            <li><a href="../admin/comments.jsp">Comments By Session</a></li>
                        </ul>
                    </li>
                    <li class="dropdown <%= roomTab%>">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Rooms <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../admin/room.jsp">View Rooms</a></li>
                            <li><a href="../admin/addroom.jsp">Add a Room</a></li>
                            <li><a href="../admin/assignroom.jsp">Assign Room to a Session</a></li>
                        </ul>
                    </li>
                    <li class="dropdown <%= reportTab%>">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Reports <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../admin/surveyReport.jsp">Surveys By Submission Time</a></li>
                            <li><a href="../admin/interestReport.jsp">Interest in a Session</a></li>
                            <li><a href="../admin/expectationReport.jsp">Session Met Expectations</a></li>
                            <li><a href="../admin/speakerReport.jsp">Speaker Knowledge</a></li>
                            <li><a href="../admin/presentationReport.jsp">Best Presentation Skills</a></li>
                            <li><a href="../admin/overallReport.jsp">Best Overall</a></li>
                            <li><a href="../admin/registrationAttendanceReport.jsp">Registration vs. Attendance</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!--/.nav-collapse -->
        </div>
    </div>
</div>
<script src="../../../js/jquery.js"></script>
<script src="../../../js/bootstrap-transition.js"></script>
<script src="../../../js/bootstrap-alert.js"></script>
<script src="../../../js/bootstrap-modal.js"></script>
<script src="../../../js/bootstrap-dropdown.js"></script>
<script src="../../../js/bootstrap-scrollspy.js"></script>
<script src="../../../js/bootstrap-tab.js"></script>
<script src="../../../js/bootstrap-tooltip.js"></script>
<script src="../../../js/bootstrap-popover.js"></script>
<script src="../../../js/bootstrap-button.js"></script>
<script src="../../../js/bootstrap-collapse.js"></script>
<script src="../../../js/bootstrap-carousel.js"></script>
<script src="../../../js/bootstrap-typeahead.js"></script>