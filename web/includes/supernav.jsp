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
<link href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" rel="stylesheet">
<!--<link href="${pageContext.request.contextPath}/css/bootstrap-responsive.css" rel="stylesheet">-->
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
    String volunteerTab ="";
    
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
    } else if (pageURI.contains("volunteer")){
        volunteerTab = active;
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
    Feature mealSurvey = fp.getFeatureState(9);
    Feature volunteers = fp.getFeatureState(10);
    Feature prize = fp.getFeatureState(11);
    Feature callToAction = fp.getFeatureState(12);
    Feature emailParticipants = fp.getFeatureState(13);
    Feature emailSurvey = fp.getFeatureState(14);
    Feature emailCurrent = fp.getFeatureState(15);
    Feature emailSpeakers = fp.getFeatureState(16);
    Feature reports = fp.getFeatureState(17);
    Feature trackAttendees = fp.getFeatureState(18);
    Feature sessionKey = fp.getFeatureState(19);
    Feature sessionFeedback = fp.getFeatureState(20);
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
                    <li><a href="${pageContext.request.contextPath}/likedSessions">My Sessions</a></li> 
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
                    <% if (mealSurvey.getFeatureState()) { %>
                            <%@ include file="../../includes/superMealSurvey.jsp" %>
                    <% } %>
                    <li><a href="${pageContext.request.contextPath}/manageSessions">Manage Session Schedule</a></li>
                    <%
                        if (trackAttendees.getFeatureState()) {
                            out.print("<li><a href='" + request.getContextPath() + "/trackAttendees'>Track Attendees for a Session</a></li>");
                        }
                        if (sessionKey.getFeatureState()) {
                            out.print("<li><a href='" + request.getContextPath() + "/sendingSessionKeyEmails'>Email Session Key</a></li>");
                        }
                        if (sessionFeedback.getFeatureState()) {
                            out.print("<li><a href='" + request.getContextPath() + "/sessionFeedbackEmail-confirm'>Email Session Feedback</a></li>");
                        }
                    %>
                </ul>
            </li> 
            <%
                if(reports.getFeatureState()) {
                    out.print("<li class='brand_nav" + reportTab + "'><a href='#'><span class='nav_drop'>Reports</span><em></em></a>");
                        out.print("<ul class='child-menu child-menu-ul'>");
                            out.print("<li><a href='" + request.getContextPath() + "/overallReport'>Best Overall Session</a></li>");
                            out.print("<li><a href='" + request.getContextPath() + "/overallSurveyReport'>Overall Survey Report</a></li>");
                            out.print("<li><a href='" + request.getContextPath() + "/presentationReport'>Best Presentation Skills</a></li>");
                            out.print("<li><a href='" + request.getContextPath() + "/commentsReport'>Comments by Session</a></li>");
                            out.print("<li><a href='" + request.getContextPath() + "/confirmationReport'>Confirmed Attendance</a></li>");
                            out.print("<li><a href='" + request.getContextPath() + "/interestReport'>Session Interest</a></li>");
                            out.print("<li><a href='" + request.getContextPath() + "/sessionKeys'>Session Keys</a></li>");
                            out.print("<li><a href='" + request.getContextPath() + "/expectationReport'>Session Met Expectations</a></li>");
                            out.print("<li><a href='" + request.getContextPath() + "/surveyReport'>Surveys</a></li>");
                            out.print("<li><a href='" + request.getContextPath() + "/surveyCompleters'>Completed Survey Names</a></li>");
                            out.print("<li><a href='" + request.getContextPath() + "/facilitiesReport'>Facilities Report</a></li>");
                            out.print("<li><a href='" + request.getContextPath() + "/mealReport'>Meal Report</a></li>");
                            out.print("<li><a href='" + request.getContextPath() + "/attendeeReport'>Attendee Report</a></li>");
                        out.print("</ul>");
                    out.print("</li>");
                }
            %>
            
            <%--------------------------------------
            THUY: ADDED CODE FOR THE COMMUNICATION THEME
            ----------------------------------------%>
            
            <li class="brand_nav <%= emailTab%>"><a href="#"><span class="nav_drop">Emails</span><em></em></a>
                <ul class="child-menu child-menu-ul">
                    <% 
                        if (volunteers.getFeatureState()) {   
                            out.print("<li><a href='" + request.getContextPath() + "/email'>Call To Action</a></li>");
                        } 
                        if (emailParticipants.getFeatureState()) {
                            out.print("<li><a href='" + request.getContextPath() + "/emailFormOfParticipants'>Participants 'Liked' a Session</a></li>");
                        }
                        if (emailSurvey.getFeatureState()) {
                            out.print("<li><a href='" + request.getContextPath() + "/emailBySurvey'>Participants 'Submitted' Survey</a></li>");
                        }
                        if (emailCurrent.getFeatureState()) {
                            out.print("<li><a href='" + request.getContextPath() + "/emailToAllParticipants'>Participants of the Current Year</a></li>");
                        }
                        if (emailSpeakers.getFeatureState()) {
                            out.print("<li><a href='" + request.getContextPath() + "/emailToAllSpeakers'>Speakers of the Current Year</a></li>");
                        }
                    %>
                 </ul> <!--END OF THE child-menu child-menu-ul div -->
            </li> <!--END OF THE email tab li -->
            
            <%--------------------------------------------
            END OF ADDED CODE
            ---------------------------------------------%>  
            <% if (volunteers.getFeatureState()) { %>                  
            <%--Added Volunteers tab. Awaiting Approval -Shaun --%>
            <%
                out.print("<li class='brand_nav  " + volunteerTab + "'><a href='#'><span class='nav_drop'>Volunteers</span><em></em></a>");
                out.print("<ul class='child-menu child-menu-ul'>");
                out.print("<li><a href='" + request.getContextPath() + "/volunteerSignUp'>Volunteer Sign-up</a></li>");
                out.print("</ul>");
                out.print("</li>");
            %>
            <% } %>
            
            <li class="brand_nav <%= adminTab%>"><a href="#"><span class="nav_drop">System Admin</span><em></em></a>
                <ul class="child-menu child-menu-ul">
                    <li><a href="${pageContext.request.contextPath}/features">System Features</a></li>
                    <% 
                        if (prize.getFeatureState()) {  
                            out.print("<li><a href='" + request.getContextPath() + "/prize'>Prize Drawing</a></li>");
                        } 
                    %>
                </ul>
            </li>
            
        </ul>
    </nav>
</nav>
