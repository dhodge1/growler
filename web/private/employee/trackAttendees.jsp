<%--
    Document   : trackAttendees
    Created on : Mar 10, 2014, 9:03:26 PM
    Author     : Chelsea Grindstaff
    Purpose    : Allow host to track attendees, both at local and remote locations
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="description" content="" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <title>Track Attendees</title>
        <link rel="shortcut icon" type="image/png" href="http://growler.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/prettify/prettify.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/general.css" /><!--General CSS-->
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <style>
            .message_container {
                display: none;
                color: red;
                font-weight: bold;
            }
            h3 {
                font-weight:normal;
            }
        </style>
        <script>
            (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
            })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

            ga('create', 'UA-41279528-6', 'scrippsnetworks.com');
            ga('send', 'pageview');
        </script>
    </head>
    <body id="growler1">
            <%      int user = 0;
                    if (null == session.getAttribute("id")) {
                        response.sendRedirect("../../index.jsp");
                    }
                    try {
                        user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                        String name = String.valueOf(session.getAttribute("user"));
                    }
                    catch (Exception e) {

                    }
        %>
        <%@ include file="../../includes/header.jsp" %>
        <% if (String.valueOf(session.getAttribute("role")).equals("admin")) { %>
            <%--<jsp:include page="../../includes/supernav.jsp" flush="true"/>--%>
            <%@ include file="../../includes/supernav.jsp" %>
        <% } else {%>
            <%--<jsp:include page="../../includes/testnav.jsp" flush="true"/>--%>
            <%@ include file="../../includes/testnav.jsp" %>
        <% } %>
        <%--<%@ include file="../../includes/testnav.jsp" %>--%>



        <div class="container-fixed mediumBottomMargin">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li>Track Attendees</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="font-weight:normal;">Track Attendees</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>Enter the number of people attending your session.</h3>
            </div>
            <div class="row mediumBottomMargin">
                <label><span style="color: red;">*</span>Required field</label>
            </div>
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-left:0px;padding-bottom:0px;" src="${pageContext.request.contextPath}/images/Techtoberfest2013small.png"/><span class="titlespan">Number of Attendees</span></h2>
            </div>
            <div class="row">
                    <form method="POST" id="action" action="${pageContext.request.contextPath}/action/processTrackAttendees.jsp">
                        <fieldset>
                            <div class="form-group">
                                <label class="required">Local Attendees</label>
                                <input required="required" name="localAttendees" class="input-xlarge" type="text" id="localAttendees" data-content="" maxlength="3"/>
                                <br/><span id="error_last" class="message_container">
                                    <span>Please enter the number of local attendees</span>
                                </span>
                            </div>
                            <div class="form-group">
                                <label class="required">Remote Attendees</label>
                                <input required="required" name="remoteAttendees" class="input-xlarge" type="text" id="remoteAttendees" data-content="" maxlength="3"/>
                                <br/><span id="error_last" class="message_container">
                                    <span>Please enter the number of remote attendees</span>
                                </span>
                            </div>
  <!--------------------------------------------------------
  Populate with logged-in user's sessions
  ---------------------------------------->
                                <div class="form-group">
                                    <label class="required">What session are you entering attendees for?</label>
                                    <select name='session' id='session' class='input x-large'>
                                        <option value='0'> Please select a session </option>
                                        <% HostPersistence hp = new HostPersistence();
                                        ArrayList<Host> host = hp.getSessionsForHost('user');
                                        for (int i = 0; i < host.size(); i++){
                                            out.print("<option value='" + host.get(i).getSessionId() + "'>");
                                            out.print(host.get(i).getSessionName());
                                            out.print("</option>");
                                        }
                                        %>
                                    </select>
                                    <br/><span id='error_session' class='message_container'>
                                        <span>Please select a session</span>
                                    </span>
                                </div>

  <!--------------------------------------------------------
Submit action needs to add to database
  ---------------------------------------->
                            <div class="form-actions">
                                <input type="submit" id="send" class="button button-primary" value="Submit Attendees"/>
                                <a id="cancel" href="${pageContext.request.contextPath}/home">Cancel</a>
                            </div>
                        </fieldset>
                </form>
            </div>
        </div>
        <%@ include file="../../includes/footer.jsp" %>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/sniui.dialog.1.2.0.min.js"></script>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>



    </body>
</html>
