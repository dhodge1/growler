<%-- 
    Document   : supernav
    Created on : Feb 14, 2014, 2:05:48 AM
    Author     : David
--%>

<%@page import="java.util.*"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>

<link href="http://growler.elasticbeanstalk.com/css/navbar.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/bootstrap-responsive.css" rel="stylesheet">
<%
    String pageURI = request.getRequestURI();
    String active = " selected ";
    String themeTab = "";
    String speakerTab = "";
    String sessionTab = "";
    String roomTab = "";
    String reportTab = "";
    String home = "";
    String blogTab = "";
    String emailTab =""; //Thuy: added code for the email tab
    String adminTab = "";
    
    if (pageURI.contains("theme")) {
        themeTab = active;
    } else if (pageURI.contains("Report") || pageURI.contains("speakerReport")) {
        reportTab = active;
    } else if (pageURI.contains("speaker")) {
        speakerTab = active;
    } else if (pageURI.contains("session") || pageURI.contains("comments")) {
        sessionTab = active;
    } else if (pageURI.contains("room")) {
        roomTab = active;
    } else if (pageURI.contains("email")){
        emailTab = active;
    } else if (pageURI.contains("admin")) {
        adminTab = active;
    } else if (pageURI.contains("home")) {
        home = active;
    }
    
    FeaturePersistence fp = new FeaturePersistence();
    Feature rankThemes = fp.getFeatureState(6); 
    Feature suggestTheme = fp.getFeatureState(3);
    Feature rankSpeaker = fp.getFeatureState(7);
    Feature nominateSpeaker = fp.getFeatureState(2);
    Feature suggestSpeaker = fp.getFeatureState(4);
    Feature surveySession = fp.getFeatureState(1);
    Feature scheduleSession = fp.getFeatureState(5);
    Feature overallSurvey = fp.getFeatureState(8);
%>
<nav class="topnav">
    <nav class="globalNavigation modify-pages" id="navigation">
        <ul>
            <li class="non_drop <%= home%>" style="padding-right:12px" ><a href="${pageContext.request.contextPath}/home"><span>Home</span></a></li>
            <%--<%@ include file="../../includes/superTheme.jsp" %>--%>
            <li class="brand_nav <%= themeTab%>" style="padding-left:12px"><a href="#"><span>Themes</span><em></em></a>
                <ul class="child-menu child-menu-ul firstnav" style="left:11px;">
                    <%--<li><a href="${pageContext.request.contextPath}/private/employee/theme.jsp">Rank Preferred Themes</a></li>--%>
                    <% if (rankThemes.getFeatureState()) { %>
                        <%@ include file="../../includes/superRankTheme.jsp" %>
                    <% } %>
                    <li><a href="${pageContext.request.contextPath}/manageThemes">Manage Themes</a></li>
                    <%--<li><a href="${pageContext.request.contextPath}/private/employee/admin/themeentry.jsp">Suggest a New Theme</a></li>--%>
                    <% if (suggestTheme.getFeatureState()) { %>
                        <%@ include file="../../includes/superSuggestTheme.jsp" %>
                    <% } %>
                </ul>
            </li>
            <li class="brand_nav <%= speakerTab%>"><a href="#"><span class="nav_drop">Speakers</span><em></em></a>
                <ul class="child-menu child-menu-ul">
                    <%--<li><a href="${pageContext.request.contextPath}/private/employee/speaker.jsp">Rank Preferred Speakers</a></li>--%>
                    <% if (rankSpeaker.getFeatureState()) { %>
                        <%@ include file="../../includes/superRankSpeaker.jsp" %>
                    <% } %>
                    <%--<li><a href="${pageContext.request.contextPath}/private/employee/nominate.jsp">Nominate Yourself As A Speaker</a></li>--%>
                    <% if (nominateSpeaker.getFeatureState()) { %>
                        <%@ include file="../../includes/superNominateSpeaker.jsp" %>
                    <% } %>
                    <li><a href="${pageContext.request.contextPath}/manageSpeakers">Manage Speakers</a></li>
                    <%--<li><a href="${pageContext.request.contextPath}/private/employee/admin/speakerentry.jsp">Suggest a New Speaker</a></li>--%>
                    <% if (suggestSpeaker.getFeatureState()) { %>
                        <%@ include file="../../includes/superSuggestSpeaker.jsp" %>
                    <% } %>
                </ul>
            </li>
            <li class="brand_nav <%= roomTab%>"><a href="#"><span class="nav_drop">Rooms</span><em></em></a>
                <ul class="child-menu child-menu-ul">
                    <li><a href="${pageContext.request.contextPath}/room">Manage Rooms</a></li>
                </ul>
            </li>
            <li class="brand_nav <%= sessionTab%>"><a href="#"><span class="nav_drop">Sessions</span><em></em></a>
                <ul class="child-menu child-menu-ul">
                    <%--<li><a href="${pageContext.request.contextPath}/private/employee/sessionschedule.jsp">View Session Schedule</a></li>--%>
                    <% if (scheduleSession.getFeatureState()) { %>
                        <%@ include file="../../includes/superSessionSchedule.jsp" %>
                    <% } %>
                    <%--<li><a href="${pageContext.request.contextPath}/private/employee/surveys.jsp">Submit Session Feedback</a></li>--%>
                    <% if (surveySession.getFeatureState()) { %>
                        <%@ include file="../../includes/superSurvey.jsp" %>
                    <% } %>
                    <% if (overallSurvey.getFeatureState()) { %>
                        <%@ include file="../../includes/superOverallSurvey.jsp" %>
                    <% } %>
                    <li><a href="${pageContext.request.contextPath}/manageSessions">Manage Session Schedule</a></li>
                </ul>
            </li> 
            <li class="brand_nav <%= reportTab%>"><a href="#"><span class="nav_drop">Reports</span><em></em></a>
                <ul class="child-menu child-menu-ul">
                    <li><a href="${pageContext.request.contextPath}/overallReport">Best Overall Session</a></li>
                    <li><a href="${pageContext.request.contextPath}/presentationReport">Best Presentation Skills</a></li>
                    <li><a href="${pageContext.request.contextPath}/confirmationReport">Confirmed Attendance</a></li>
                    <li><a href="${pageContext.request.contextPath}/interestReport">Session Interest</a></li>
                    <li><a href="${pageContext.request.contextPath}/expectationReport">Session Met Expectations</a></li>
                    <li><a href="${pageContext.request.contextPath}/surveyReport">Surveys</a></li>
                    
                </ul>
            </li>
            
            <%--------------------------------------
            THUY: ADDED CODE FOR THE COMMUNICATION THEME
            ----------------------------------------%>
            
            <li class="brand_nav <%= emailTab%>"><a href="#"><span class="nav_drop">Emails</span><em></em></a>
                <ul class="child-menu child-menu-ul">
                      
                    <li><a href="${pageContext.request.contextPath}/email">Call To Action</a></li>
                    <li><a href="${pageContext.request.contextPath}/emailFormOfParticipants">Participants "Liked" a Session</a></li>
                    <li><a href="${pageContext.request.contextPath}/emailBySurvey">Participants "Submitted" Survey</a></li>
                    <li><a href="${pageContext.request.contextPath}/emailToAllParticipants">Participants of the Current Year</a></li>
                    
                 </ul> <!--END OF THE child-menu child-menu-ul div -->
            </li> <!--END OF THE email tab li -->
            
            <%--------------------------------------------
            END OF ADDED CODE
            ---------------------------------------------%>  
            
            <li class="brand_nav <%= adminTab%>"><a href="#"><span class="nav_drop">System Admin</span><em></em></a>
                <ul class="child-menu child-menu-ul">
                    <li><a href="${pageContext.request.contextPath}/features">System Features</a></li>
                </ul>
            </li>
            
        </ul>
    </nav>
</nav>
