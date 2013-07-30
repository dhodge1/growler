<%-- 
    Document   : speaker-confirm
    Created on : Jul 17, 2013, 9:02:37 PM
    Author     : 162107
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.Speaker" %>
<%@page import="com.scripps.growler.SpeakerPersistence" %>
<%@page import="com.scripps.growler.DataConnection" %>
<jsp:useBean id="speaker" class="com.scripps.growler.Speaker" scope="page" />
<jsp:useBean id="persist" class="com.scripps.growler.SpeakerPersistence" scope="page" />
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Your Ranked Speakers</title><!-- Title -->
        <link rel="shortcut icon" type="image/png" href="http://growler-dev.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://growler-dev.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler-dev.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="http://growler-dev.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <script src="http://growler-dev.elasticbeanstalk.com/js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
        <script src="http://growler-dev.elasticbeanstalk.com/js/libs/sniui.tool-tip.1.2.0.min.js" type="text/javascript"></script>
        <style>
            .firstLink {
                padding-right: 12px;
            }
        </style>
    </head>
    <body id="growler1">  

        <%
            int user = 0;
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
            ArrayList<Speaker> speakers = persist.getUserRanks(user);
        %>
        <%@ include file="../../includes/header.jsp" %> 
        <%@ include file="../../includes/testnav.jsp" %>
        <div class="container-fixed largeBottomMargin">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <%@include file="../../includes/messagehandler.jsp" %>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="font-weight:normal;">Speaker Ranking Confirmation</h1>
            </div>
            <div style="border:1px dashed #ddd;" class=" row mediumBottomMargin"></div>
            <div class="row mediumBottomMargin">
                <%
                    //If we didn't get any ranks, we tell the user to rank the speakers
                    if (speakers == null || speakers.size() == 0) {
                        response.sendRedirect("../../private/employee/speaker.jsp");
                    } else { //If we got speakers, we let the user see them
                        out.print("<div class='row largeBottomMargin' style='margin-left:4px'>");
                        out.print("<span>Thank you for providing us with the speakers you are most interested in for this years' Techtoberfest! We value your opinion and participation. Below is a listing of the speakers and rankings you provided.</span><br/><br/>");
                        out.print("<span><strong>Remember:</strong> Now that your ranking has been submitted, you can not submit another unless you <a href='../../action/removeSpeakerRanks.jsp?id=" + user + "'>reset/clear</a> this one. An option to reset your previous ranking will now be provided via the ranking page.</span>");
                        out.print("</div>");
                    }
                %>
            </div>
            <%
                if (speakers.size() > 0) {
                    out.print("<div class='row mediumBottomMargin'>");
                    out.print("<div class='span3'>");
                    out.print("<table class=\"table table-alternatingRow\">");
                    out.print("<thead><tr><th>Rank</th><th>Speaker</th></tr></thead><tbody>");
                    for (int i = 0; i < speakers.size(); i++) {
                        out.print("<tr><td>" + (i + 1) + "</td><td>" + speakers.get(i).getFullName() + "</td></tr>");
                    }
                    out.print("</tbody></table>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("<div class='row'>");
                    out.print("<a class='firstLink' href=\"../../private/employee/home.jsp\">Return to homepage</a>");
                    out.print("<a class='firstLink' href=\"../../private/employee/speakerentry.jsp\">Suggest a new speaker</a>");
                    out.print("</div>");
                }
            %>
        </div>
        <%@ include file="../../includes/footer.jsp" %>
    </body>
</html>
