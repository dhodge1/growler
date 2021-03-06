<%-- 
    Document   : trackAttendeesEdit
    Author     : Chelsea Grindstaff
    Purpose    : Allow admin to track attendees, both at local and remote locations
                Meant for updating # of attendees. Can't add initial # here. 
--%>

<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> 
<html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>Track Attendees</title><!-- Title -->
        <link rel="shortcut icon" type="image/png" href="http://growler.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%
            int user = 0;
            int sessionId = 0;
            if (null == session.getAttribute("id")) {
                response.sendRedirect("http://sniforms.scrippsnetworks.com/siteminderagent/sniforms/logout.html");
            } else if (!session.getAttribute("role").equals("admin")) {
                response.sendRedirect("http://sniforms.scrippsnetworks.com/siteminderagent/sniforms/logout.html");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));  
                sessionId = Integer.parseInt(request.getParameter("sessionId"));
            } catch (Exception e) {
            }

            AttendeePersistence ap = new AttendeePersistence();
            Attendees a = ap.getAttendeesBySessionId(sessionId);

        %>
        <%@ include file="../../../includes/adminheader.jsp" %>
        <% if (String.valueOf(session.getAttribute("role")).equals("admin")) { %>
            <%--<jsp:include page="../../includes/supernav.jsp" flush="true"/>--%>
            <%@ include file="../../../includes/supernav.jsp" %>
        <% } else {%>
            <%--<jsp:include page="../../includes/adminnav.jsp" flush="true"/>--%>
            <%@ include file="../../../includes/adminnav.jsp" %>
        <% } %>



        <div class="container-fixed mediumBottomMargin">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li>Track Attendees Form</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="font-weight:normal;">Track Attendees</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>Enter the number of people attending the session.</h3>
            </div>
            <div class="row mediumBottomMargin">
                <label><span style="color: red;">*</span>Required field</label>
            </div>
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-left:0px;padding-bottom:0px;" src="${pageContext.request.contextPath}/images/Techtoberfest2013small.png"/><span class="titlespan">Number of Attendees</span></h2>
            </div>
            <div class="row">
                    <form method="POST" id="action" action="${pageContext.request.contextPath}/action/processAttendeesEdit.jsp">
                        <fieldset>
                            <div class="form-group">
                                <label class="required">Local Attendees</label>
                                <input required="required" name="localAttendees" class="input-xlarge" type="text" id="localAttendees" data-content="" maxlength="3" />
                                <br/><span id="error_last" class="message_container">
                                    <span>Please update the number of local attendees. </br> Number is currently set to <% out.print(a.getLocalAttendees());%>.</span>
                                </span>
                            </div>
                            <div class="form-group">
                                <label class="required">Remote Attendees</label>
                                <input required="required" name="remoteAttendees" class="input-xlarge" type="text" id="remoteAttendees" data-content="" maxlength="3"  />
                                <br/><span id="error_last" class="message_container">
                                    <span>Please update the number of remote attendees. </br> Number is currently set to <% out.print(a.getRemoteAttendees());%>.</span>
                                </span>
                            </div>
                         <% 
                            out.print("<input type='hidden' id='sessionId' name='sessionId' value='" + sessionId + "'/>");
                        %>


                            <div class="form-actions">
                                <input type="submit" id="send" class="button button-primary" value="Update Attendees"/>
                                <a id="cancel" href="${pageContext.request.contextPath}/home">Cancel</a>
                            </div>
                        </fieldset>
                </form>
            </div>
        </div>
        <%@ include file="../../../includes/footer.jsp" %>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/sniui.dialog.1.2.0.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>



    </body>
</html>

