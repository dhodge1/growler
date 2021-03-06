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
    String volunteerTab = "";
    if (pageURI.contains("theme")) {
        themeTab = active;
    } else if (pageURI.contains("speaker")) {
        speakerTab = active;
    } else if (pageURI.contains("session") || pageURI.contains("attendance") || pageURI.contains("survey")) {
        sessionTab = active;
    } else if (pageURI.contains("volunteer")){
        volunteerTab = active;
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
    Feature overallSurvey = fp.getFeatureState(8);
    Feature mealSurvey = fp.getFeatureState(9);
    Feature volunteers = fp.getFeatureState(10);


 
%>
<nav class="topnav navbar">
        <nav class="globalNavigation modify-pages" id="navigation">
            <ul class="nav">
                <li class="non_drop <%= home%>" style="padding-right:12px" ><a href="${pageContext.request.contextPath}/home"><span>Home</span></a></li>
                <li class="brand_nav <%= themeTab%>" style="padding-left:12px"><a href="#"><span>Themes</span><em></em></a>
                    <ul class="child-menu child-menu-ul firstnav" style="left:11px;">
                        <!--<li><a href="${pageContext.request.contextPath}/private/employee/theme.jsp">Rank Preferred Themes</a></li>-->
                        <% if (rankThemes.getFeatureState()) { %>
                            <%@ include file="../../includes/regRankTheme.jsp" %>
                        <% } %>
                        <!--<li><a href="${pageContext.request.contextPath}/private/employee/themeentry.jsp">Suggest a New Theme</a></li>-->
                        <% if (suggestTheme.getFeatureState()) { %>
                            <%@ include file="../../includes/regSuggestTheme.jsp" %>
                        <% } %>
                    </ul>
                </li>
                <li class="brand_nav <%= speakerTab%>"><a href="#" style='padding-left:8px;'><span class="nav_drop">Speakers</span><em></em></a>
                    <ul class="child-menu child-menu-ul">
                        <!--<li><a href="${pageContext.request.contextPath}/private/employee/speaker.jsp">Rank Preferred Speakers</a></li>-->
                        <% if (rankSpeaker.getFeatureState()) { %>
                            <%@ include file="../../includes/regRankSpeaker.jsp" %>
                        <% } %>
                        <!--<li><a href="${pageContext.request.contextPath}/private/employee/speakerentry.jsp">Suggest a New Speaker</a></li>-->
                        <% if (suggestSpeaker.getFeatureState()) { %>
                            <%@ include file="../../includes/regSuggestSpeaker.jsp" %>
                        <% } %>
                        <!--<li><a href="${pageContext.request.contextPath}/private/employee/nominate.jsp">Nominate Yourself As A Speaker</a></li>-->
                        <% if (nominateSpeaker.getFeatureState()) { %>
                            <%@ include file="../../includes/regNominateSpeaker.jsp" %>
                        <% } %>
                    </ul>
                </li>
                <li class="brand_nav <%= sessionTab%>"><a href="#" style='padding-left:8px;'><span class="nav_drop">Sessions</span><em></em></a>
                    <ul class="child-menu child-menu-ul">
                        <!--<li><a href="${pageContext.request.contextPath}/private/employee/sessionschedule.jsp">View Session Schedule</a></li>-->
                        <li><a href="${pageContext.request.contextPath}/likedSessions">My Sessions</a></li> 
                        <% if (scheduleSession.getFeatureState()) { %>
                            <%@ include file="../../includes/regSessionSchedule.jsp" %>
                        <% } %>
                        <!--<li><a href="${pageContext.request.contextPath}/private/employee/surveys.jsp">Submit Session Feedback</a></li>-->
                        <% if (surveySession.getFeatureState()) { %>
                            <%@ include file="../../includes/regSurvey.jsp" %>
                        <% } %>
                        <% if (overallSurvey.getFeatureState()) { %>
                            <%@ include file="../../includes/regOverallSurvey.jsp" %>
                        <% } %>
                        <% if (mealSurvey.getFeatureState()) { %>
                            <%@ include file="../../includes/regMealSurvey.jsp" %>
                        <% } %>
                        

                        
                    </ul>
                <% if (volunteers.getFeatureState()) { %>                  
                <%--Added Volunteers tab. Awaiting Approval -Shaun --%>
                <%
                    out.print("<li class='brand_nav  " + volunteerTab + "'><a href='#' style='padding-left:8px;'><span class='nav_drop'>Volunteers</span><em></em></a>");
                    out.print("<ul class='child-menu child-menu-ul'>");
                    out.print("<li><a href='" + request.getContextPath() + "/volunteerSignUp'>Volunteer Sign-up</a></li>");
                    out.print("</ul>");
                    out.print("</li>");
                %>
                <% } %>
                
            </ul>
        </nav>
</nav>