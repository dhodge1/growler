<%-- 
    Document   : adminnav
    Created on : Apr 4, 2013, 4:25:29 PM
    Author     : Justin Bauguess
    Purpose    : The adminnav file goes under the header.jsp file on the pages
                in the admin folder.  It contains links that only the admin should 
                be able to look at.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .menu{border:none;border:0px;margin:0px;padding:0px;font: 67.5% Arial, Helvetica, sans-serif;font-size:14px;font-weight:bold;}
    .menu ul{color:#FFFFFF;height:50px;list-style:none;margin:0;padding:0;-webkit-border-radius: 15px;-moz-border-radius: 15px;border-radius: 15px;-webkit-box-shadow: inset 0px 16px 0px 0px rgba(255, 255, 255, .1);-moz-box-shadow: inset 0px 16px 0px 0px rgba(255, 255, 255, .1);box-shadow: inset 0px 16px 0px 0px rgba(255, 255, 255, .1);}
    .menu li{color:#FFFFFF;float:left;padding:0px 0px 0px 15px; }
    .menu li a{color:#FFFFFF;display:block;font-weight:normal;line-height:50px;margin:0px;padding:0px 25px;text-align:center;text-decoration:none;}
    .menu li a:hover{background:#00467C;color:#FFFFFF;text-decoration:none;-webkit-box-shadow: inset 0px 0px 7px 2px rgba(0, 0, 0, .3);-moz-box-shadow: inset 0px 0px 7px 2px rgba(0, 0, 0, .3);box-shadow: inset 0px 0px 7px 2px rgba(0, 0, 0, .3);}
    .menu ul li:hover a{background:#00467C;color:#FFFFFF;text-decoration:none;}
    .menu li ul{display:none;height:auto;padding:0px;margin:0px;border:0px;position:absolute;width:200px;z-index:200;}
    .menu li:hover ul{display:block; }
    .menu li li {display:block;float:none;margin:0px;padding:0px;width:200px;background:#002D56;/*this is where the rounded corners for the dropdown disappears*/}
    .menu li:hover li a{background:none;}
    .menu li ul a{display:block;height:50px;font-size:12px;font-style:normal;margin:0px;padding:0px 10px 0px 15px;text-align:left;}
    .menu li ul a:hover, .menu li ul li:hover a{border:0px;color:#ffffff;text-decoration:none;background:#002D56;-webkit-box-shadow: inset 0px 0px 7px 2px rgba(0, 0, 0, .3);-moz-box-shadow: inset 0px 0px 7px 2px rgba(0, 0, 0, .3);box-shadow: inset 0px 0px 7px 2px rgba(0, 0, 0, .3); }
    
    .menu1{border:none;border:0px;margin:0px;padding:0px;font: 67.5% Arial, Helvetica, sans-serif;font-size:12px;font-weight:bold;}
    .menu1 ul{color:#FFFFFF;height:25px;list-style:none;margin:0;padding:0;-webkit-border-radius: 7px;-moz-border-radius: 7px;border-radius: 7px;-webkit-box-shadow: inset 0px 8px 0px 0px rgba(255, 255, 255, .1);-moz-box-shadow: inset 0px 8px 0px 0px rgba(255, 255, 255, .1);box-shadow: inset 0px 8px 0px 0px rgba(255, 255, 255, .1);}
    .menu1 li{color:#FFFFFF;float:left;padding:0px 0px 0px 8px;font-size:10px; }
    .menu1 li a{color:#FFFFFF;display:block;font-weight:normal;line-height:25px;margin:0px;padding:0px 12px;text-align:center;text-decoration:none;}
    .menu1 li a:hover{background:#00467C;color:#FFFFFF;text-decoration:none;-webkit-box-shadow: inset 0px 0px 7px 2px rgba(0, 0, 0, .3);-moz-box-shadow: inset 0px 0px 7px 2px rgba(0, 0, 0, .3);box-shadow: inset 0px 0px 7px 2px rgba(0, 0, 0, .3);}
    .menu1 ul li:hover a{background:#00467C;color:#FFFFFF;text-decoration:none;}
    .menu1 li ul{display:none;height:auto;padding:0px;margin:0px;border:0px;position:absolute;width:100px;z-index:100;}
    .menu1 li:hover ul{display:block; }
    .menu1 li li {display:block;float:none;margin:0px;padding:0px;width:100px;background:#002D56;/*this is where the rounded corners for the dropdown disappears*/}
    .menu1 li:hover li a{background:none;}
    .menu1 li ul a{display:block;height:25px;font-size:8px;font-style:normal;margin:0px;padding:0px 5px 0px 7px;text-align:left;}
    .menu1 li ul a:hover, .menu li ul li:hover a{border:0px;color:#ffffff;text-decoration:none;background:#002D56;-webkit-box-shadow: inset 0px 0px 7px 2px rgba(0, 0, 0, .3);-moz-box-shadow: inset 0px 0px 7px 2px rgba(0, 0, 0, .3);box-shadow: inset 0px 0px 7px 2px rgba(0, 0, 0, .3); }    

</style>
<% 
    String pageURI = request.getRequestURI();
    String themeTab = "";
    String speakerTab = "";
    String sessionTab = "";
    String roomTab = "";
    String reportTab = "";
    if (pageURI.contains("theme")) {
        themeTab = " class=\"selected\" ";
    }
    else if (pageURI.contains("speaker")) {
        speakerTab = " class=\"selected\" ";
    }
    else if (pageURI.contains("session") || pageURI.contains("comments")){
        sessionTab = " class=\"selected\" ";
    }
    else if (pageURI.contains("room")){
        sessionTab = " class=\"selected\" ";
    }
    else if (pageURI.contains("Report")){
        sessionTab = " class=\"selected\" ";
    }
%>
<nav class="globalNavigation hidden-tablet hidden-phone">
        <div id="header" class="menu">
    <ul>
        <li><p></p></li>
        <li<%= themeTab %>>Themes
            <ul>
                <li><a href="../admin/theme.jsp">Edit Themes</a></li>
                <li><a href="../admin/themeentry.jsp">Add a Theme</a></li>
            </ul>
        </li>
        <li<%= speakerTab %>>Speakers
            <ul>
                <li><a href="../admin/speaker.jsp">Edit Speakers</a></li>
                <li><a href="../admin/userspeaker.jsp">Suggested Speakers</a></li>
                <li><a href="../admin/speakerentry.jsp">Add a Speaker</a></li>
                <li><a href="../admin/assignspeaker.jsp">Assign Speaker to Session</a></li>
            </ul>
        </li>
        <li<%= sessionTab %>>Sessions
            <ul>
                <li><a href="../admin/addsession.jsp">Add a Session</a></li>
                <li><a href="../admin/session.jsp">View Sessions</a></li>
                <li><a href="../admin/sessionScheduler.jsp">Schedule Sessions</a></li>
                <li><a href="../admin/comments.jsp">Comments By Session</a></li>
            </ul>
        </li>
        <li<%= roomTab %>>Rooms
            <ul>
                <li><a href="../admin/room.jsp">View Rooms</a></li>
                <li><a href="../admin/addroom.jsp">Add a Room</a></li>
                <li><a href="../admin/assignroom.jsp">Assign Room to a Session</a></li>
            </ul>
        </li>
        <li<%= reportTab %>>Reports
            <ul>
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
    </div>
</nav><!-- /.globalNavigation -->
<script src="../js/respond.min.js"></script>