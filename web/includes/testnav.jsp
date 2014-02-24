<%@page import="java.util.Calendar"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<link href="http://growler.elasticbeanstalk.com/css/navbar.css" rel="stylesheet">
<link href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" rel="stylesheet">
<%
    String active = " selected ";
    String pageURI = request.getRequestURI();
    String home = "";
    String themeTab = "";
    String speakerTab = "";
    String sessionTab = "";
    String blogTab = "";
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
    
    FeaturePersistence fp = new FeaturePersistence();
    Feature rankThemes = fp.getFeatureState(6); 
    Feature suggestTheme = fp.getFeatureState(3);
    Feature rankSpeaker = fp.getFeatureState(7);
    Feature nominateSpeaker = fp.getFeatureState(2);
    Feature suggestSpeaker = fp.getFeatureState(4);
    Feature surveySession = fp.getFeatureState(1);
    Feature scheduleSession = fp.getFeatureState(5);
%>
<nav class="topnav navbar">
        <nav class="globalNavigation modify-pages" id="navigation">
            <ul class="nav">
                <li class="non_drop <%= home%>" style="padding-right:12px" ><a href="../../private/employee/home.jsp"><span>Home</span></a></li>
                <li class="brand_nav <%= themeTab%>" style="padding-left:12px"><a href="#"><span>Themes</span><em></em></a>
                    <ul class="child-menu child-menu-ul firstnav" style="left:11px;">
                        <!--<li><a href="../../private/employee/theme.jsp">Rank Preferred Themes</a></li>-->
                        <% if (rankThemes.getFeatureState()) { %>
                            <%@ include file="../../includes/superRankTheme.jsp" %>
                        <% } %>
                        <!--<li><a href="../../private/employee/themeentry.jsp">Suggest a New Theme</a></li>-->
                        <% if (suggestTheme.getFeatureState()) { %>
                            <%@ include file="../../includes/superSuggestTheme.jsp" %>
                        <% } %>
                    </ul>
                </li>
                <li class="brand_nav <%= speakerTab%>"><a href="#" style='padding-left:8px;'><span class="nav_drop">Speakers</span><em></em></a>
                    <ul class="child-menu child-menu-ul">
                        <!--<li><a href="../../private/employee/speaker.jsp">Rank Preferred Speakers</a></li>-->
                        <% if (rankSpeaker.getFeatureState()) { %>
                            <%@ include file="../../includes/superRankSpeaker.jsp" %>
                        <% } %>
                        <!--<li><a href="../../private/employee/speakerentry.jsp">Suggest a New Speaker</a></li>-->
                        <% if (suggestSpeaker.getFeatureState()) { %>
                            <%@ include file="../../includes/superSuggestSpeaker.jsp" %>
                        <% } %>
                        <!--<li><a href="../../private/employee/nominate.jsp">Nominate Yourself As A Speaker</a></li>-->
                        <% if (nominateSpeaker.getFeatureState()) { %>
                            <%@ include file="../../includes/superNominateSpeaker.jsp" %>
                        <% } %>
                    </ul>
                </li>
                <li class="brand_nav <%= sessionTab%>"><a href="#" style='padding-left:8px;'><span class="nav_drop">Sessions</span><em></em></a>
                    <ul class="child-menu child-menu-ul">
                        <!--<li><a href="../../private/employee/sessionschedule.jsp">View Session Schedule</a></li>-->
                        <% if (scheduleSession.getFeatureState()) { %>
                            <%@ include file="../../includes/superSessionSchedule.jsp" %>
                        <% } %>
                        <!--<li><a href="../../private/employee/surveys.jsp">Submit Session Feedback</a></li>-->
                        <% if (surveySession.getFeatureState()) { %>
                            <%@ include file="../../includes/superSurvey.jsp" %>
                        <% } %>
                    </ul>
                </li>             
                
            </ul>
        </nav>
</nav>