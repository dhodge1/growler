<%-- 
    Document   : usernav
    Created on : Apr 4, 2013, 4:25:29 PM
    Author     : Justin Bauguess & Jonathan C. McCowan
    Purpose    : The usernav file goes below the header.jsp file.  It contains 
                 the navigation for users.
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
</style>
<nav class="globalNavigation">
        <div class="menu">
        
    <ul>
        <li>
                <%//Get the user's info, and post a welcome!
		 if (!String.valueOf(session.getAttribute("user")).isEmpty()) {
			String navuser = String.valueOf(session.getAttribute("user"));
			out.print("    Welcome, " + navuser + "!");
			}
		 //If they aren't logged in, we want them to go back and log in.
		 else {
			response.sendRedirect("../index.jsp");
		 }
		%>
        </li>
        <li>Themes
            <ul>
                <li><a href="../view/theme.jsp">Rank Preferred Themes</a></li>
                <li><a href="../view/themeentry.jsp">Suggest New Themes</a></li>
            </ul>
        </li>
        <li>Speakers
            <ul>
                <li><a href="../view/speaker.jsp">Rank Preferred Speakers</a></li>
                <li><a href="../view/speakerentry.jsp">Suggest new Speaker</a></li>
            </ul>
        </li>
        <li>Sessions
            <ul>
                <li><a href="../view/attendance.jsp">Acknowledge Attendance</a></li>
                <li><a href="../view/surveylist.jsp">Rate a Session</a></li>
            </ul>
        </li>
        <li>Help
            <ul>
                <li><a href="../view/help.jsp">Help</a></li>
            </ul>
        </li>
        <li>Logout
            <ul>
                <li><a href="../model/logout.jsp">Logout</a></li>
            </ul>
        </li>
    </ul>
        
    </div>
            </nav>
    
    <%        //This redirects a user to the login page if they aren't logged in, and prevents jumping straight into the application
        if (String.valueOf(session.getAttribute("user")).isEmpty() || String.valueOf(session.getAttribute("user")).equals("null")) {
          response.sendRedirect("../index.jsp");
         }
    %>
