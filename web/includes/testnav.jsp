<link href="../css/bootstrap.css" rel="stylesheet">
<link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
<% 
    String active = "active";
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
        home = "class=\"active\"";
    }
%>
<div class="navbar navbar-static-top globalNavigation">
    
    <div class="navbar-inner">
    <div class="container">    
            <a class="btn btn-navbar pull-right" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>
            <div class="nav-collapse collapse">
                <ul class="nav nav-pills">
                    <li <%= home %>><a href="../view/home.jsp">Home </a></li>
                    <li><span style="border-left: 1px dotted white; margin-left: 6px; margin-right: 6px; line-height:2.5;"></span></li>
                    <li class="dropdown <%= themeTab %>">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Themes <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../view/theme.jsp">Rank Preferred Themes</a></li>
                            <li><a href="../view/themeentry.jsp">Suggest New Themes</a></li>
                        </ul>
                    </li>
                    <li class="dropdown <%= speakerTab %>">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Speakers <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../view/speaker.jsp">Rank Preferred Speakers</a></li>
                            <li><a href="../view/speakerentry.jsp">Suggest New Speakers</a></li>
                        </ul>
                    </li>
                    <li class="dropdown <%= sessionTab %>">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">Sessions <b class="caret"></b></a>
                        <ul class="dropdown-menu">
                            <li><a href="../view/sessionschedule.jsp">View Schedule</a></li>
                            <li><a href="../view/attendance.jsp">Attend A Session</a></li>
                            <li><a href="../view/surveylist.jsp">Rate an Attended Session</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!--/.nav-collapse -->
        </div>
    </div>
</div>
    <script src="../js/jquery.js"></script>
    <script src="../js/bootstrap-transition.js"></script>
    <script src="../js/bootstrap-alert.js"></script>
    <script src="../js/bootstrap-modal.js"></script>
    <script src="../js/bootstrap-dropdown.js"></script>
    <script src="../js/bootstrap-scrollspy.js"></script>
    <script src="../js/bootstrap-tab.js"></script>
    <script src="../js/bootstrap-tooltip.js"></script>
    <script src="../js/bootstrap-popover.js"></script>
    <script src="../js/bootstrap-button.js"></script>
    <script src="../js/bootstrap-collapse.js"></script>
    <script src="../js/bootstrap-carousel.js"></script>
    <script src="../js/bootstrap-typeahead.js"></script>