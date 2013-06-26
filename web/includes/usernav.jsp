<%-- 
    Document   : usernav
    Created on : Apr 4, 2013, 4:25:29 PM
    Author     : Justin Bauguess & Jonathan C. McCowan
    Purpose    : The usernav file goes below the header.jsp file.  It contains 
                 the navigation for users.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
<style>
    .menu{border:none;border:0px;margin:0px;padding:0px;font: 67.5% Arial, Helvetica, sans-serif;font-size:14px;font-weight:bold;}
    .menu ul{color:#FFFFFF;height:50px;list-style:none;margin:0;padding:0;-webkit-border-radius: 15px;-moz-border-radius: 15px;border-radius: 15px;-webkit-box-shadow: inset 0px 16px 0px 0px rgba(255, 255, 255, .1);-moz-box-shadow: inset 0px 16px 0px 0px rgba(255, 255, 255, .1);box-shadow: inset 0px 16px 0px 0px rgba(255, 255, 255, .1);}
    .menu li{color:#FFFFFF;float:left;padding:0px 0px 0px 15px; }
    .menu li a{color:#FFFF00;display:block;font-weight:normal;line-height:50px;margin:0px;padding:0px 25px;text-align:center;text-decoration:none;}
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
    String selected = "";
    String themeTab = "";
    String speakerTab = "";
    String sessionTab = "";
    if (pageURI.contains("theme")) {
        themeTab = " class=\"selected\" ";
    }
    else if (pageURI.contains("speaker")) {
        speakerTab = " class=\"selected\" ";
    }
    else if (pageURI.contains("session") || pageURI.contains("attendance") || pageURI.contains("survey") ){
        sessionTab = " class=\"selected\" ";
    }
%>
<nav class="globalNavigation menu">
<ul>
        <li><p></p>
        </li>
        <li <%= themeTab %>>Themes
            <ul>
                <li><a href="../view/theme.jsp">Rank Preferred Themes</a></li>
                <li><a href="../view/themeentry.jsp">Suggest New Themes</a></li>
            </ul>
        </li>
        <li <%= speakerTab %>>Speakers
            <ul>
                <li><a href="../view/speaker.jsp">Rank Preferred Speakers</a></li>
                <li><a href="../view/speakerentry.jsp">Suggest new Speaker</a></li>
            </ul>
        </li>
        <li <%= sessionTab %>>Sessions
            <ul>
                <li><a href="../view/sessionschedule.jsp">View Session Schedule</a></li>
                <li><a href="../view/attendance.jsp">Acknowledge Attendance</a></li>
                <li><a href="../view/surveylist.jsp">Rate a Session</a></li>
            </ul>
        </li>
    </ul>
    </nav>
        <script src="../js/respond.min.js"></script>