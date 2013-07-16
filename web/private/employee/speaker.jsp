<%-- 
    Document   : speaker
    Created on : Feb 28, 2013, 7:15:03 PM
    Author     : Justin Bauguess & Jonathan C. McCowan
    Purpose    : The theme (user) page is for users to rank speakers according to 
                their preferences.  The ranks are saved in the isolated_theme_ranking
                table for now.  Once users are remembered, it will be saved in the 
                theme_ranking table.  A record in that table will contain a user_id,
                theme_id, and rank.  Ranks can only be between 1 and 10.  Once a user
                has submitted rankings, they can change them later.
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page" />
<jsp:useBean id="giveStars" class="com.scripps.growler.GiveStars" scope="page" />
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
        <title>Speakers</title><!-- Title -->
        <link rel="shortcut icon" type="image/png" href="http://sni-techtoberfest.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/speakers/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <style>
            #speakers li{
                list-style-type: none;
            }
        </style>
        <script>
            $(function() {
               $("#speakerss, #ranked").sortable({
                    connectWith: ".connectedSortable",
                    placeholder: "ui-state-highlight",
                    update: function(event, ui) {
                        $(this).find(".placeholder").remove();
                        $("#speakerss").find(":hidden").prop("name", "none");
                        $("#ranked").find(":hidden").prop("name", "list");
                    },
                    stop: function(event, ui) {
                        if ($("#ranked li").length > 9) {
                            $("#speakers").sortable('disable');
                        }
                    }
                }).disableSelection();
                $("#filter").change(function() {
                    if ($("#filter").val() == 1) {
                        $('#speakers li').filter('.Business').show();
                        $('#speakers li').filter('.Technical').show();
                    }
                    else if ($("#filter").val() == 2) {
                        $('#speakers li').filter('.Business').show();
                        $('#speakers li').filter('.Technical').hide();
                    }
                    else if ($("#filter").val() == 3) {
                        $('#speakers li').filter('.Business').hide();
                        $('#speakers li').filter('.Technical').show();
                    }
                });
                $("#ranked").mouseenter(function(){
                   if ($("#ranked li").length > 9 ) {
                       $("#speakers").sortable('enable');
                   }
                });
                $("#ranked").mouseleave(function(){
                   if ($("#ranked li").length > 9 ) {
                       $("#speakers").sortable('disable');
                   }
                });
            });
        </script>
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
            SpeakerPersistence persist = new SpeakerPersistence();
            ArrayList<Speaker> speakers = persist.getUserRanks(user);
            ArrayList<Speaker> vspeakers = persist.getSpeakersByVisibility(true, persist.SORT_BY_LAST_NAME_ASC);
        %>
        <%@ include file="../../includes/header.jsp" %> 
        <%@ include file="../../includes/testnav.jsp" %>
        <div class="container-fixed largeBottomMargin">
            <div class="row mediumBottomMargin"></div>
            <div class="row mediumBottomMargin">
                <ul class="breadcrumb">
                    <li><a href="home.jsp">Home</a></li>
                    <li>Speaker Ranking</li>
                </ul>
            </div>

            <div class="row largeBottomMargin">
                <h1 style="font-weight:normal;">Rank Speakers</h1>
            </div>
            <% if (speakers == null || speakers.size() == 0) {
                    out.print("<div class='row largeBottomMargin'>");
                    out.print("<p style='font-size: 16px; font-family: Arial;'>We want to hear from you!  Please let us know the top 10 speakers you would be interested in listening to for this year's Techtoberfest.</p>");
                    out.print("</div>");
                }
            %>
            <div class="row mediumBottomMargin">
                <%
                    if (speakers == null || speakers.size() == 0) {
                        out.print("<h2 class='bordered mediumBottomMargin'><img style=\"padding-bottom:0;padding-left:0;\" src='http://sni-techtoberfest.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class=\"titlespan\">Which speakers are you most interested in?</span></h2>");
                        out.print("<span class=\"mediumBottomMargin\">Please note: If desired, you can provide a ranking for less than 10 presentation speakers.  There is also a <a href=\"nondragspeaker.jsp\">non drag and drop version</a> available.</span>");

                    } else {
                        out.print("<h2 class=bordered><img style=\"padding-bottom:0;padding-left:0;\" src='http://sni-techtoberfest.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class=\"titlespan\">Your Speaker Rankings</span></h2>");
                    }
                %>
            </div>
            <div class="row">
                <%
                    if (speakers.size() > 0) {
                        out.print("<table class=\"propertyGrid\">");
                        for (int i = 0; i < speakers.size(); i++) {
                            out.print("<tr><th>Rank " + (i + 1) + "</th><td>" + speakers.get(i).getLastName()
                                    + ", " + speakers.get(i).getFirstName() + "</td></tr>");
                        }
                        out.print("</table>");
                        out.print("<a href=\"../../action/removeSpeakerRanks.jsp?id=" + user + "\">Reset Ranks</a>");
                    }
                    if (speakers == null || speakers.size() == 0) {

                        out.print("<form action='../../action/processSpeakerRanking.jsp'>");
                        out.print("<div class='row'>");
                        out.print("<div class='span5' style='overflow:auto;'>");
                        out.print("<span><strong>Available Speakers</strong></span><br/>");
                        out.print("<select id='filter'>");
                        out.print("<option value='1'>All Speakers</option>");
                        out.print("<option value='2'>Business Speakers</option>");
                        out.print("<option value='3'>Technical Speakers</option>");
                        out.print("</select>");
                        out.print("<ul id='speakers' class='connectedSortable'>");

                        for (int j = 0; j < vspeakers.size(); j++) {
                            out.print("<li class=\"" + vspeakers.get(j).getType() + "\">");
                            out.print(vspeakers.get(j).getLastName() + ", " + vspeakers.get(j).getFirstName());
                            out.print(giveStars.return2012Rank(vspeakers.get(j).getId()));
                            out.print(giveStars.returnCount(vspeakers.get(j).getId()));
                            out.print("<input type=\"hidden\" name=\"list\" value=\"" + vspeakers.get(j).getId() + "\" />");
                            out.print("</li>");
                        }
                        out.print("</ul>");
                        out.print("</div>");
                        out.print("<div class='span5'>");
                        out.print("<span><strong>Speakers I'm Interested In</strong></span>");
                        out.print("<ol id='ranked' class='connectedSortable'>");
                        out.print("<li class='placeholder'>Place speakers here</li>");
                        out.print("</ol>");
                        out.print("</div>");
                        out.print("</div>");
                    }
                %>
            </div>
            <% if (speakers == null || speakers.size() == 0) {
                    out.print("<div class='row'>");
                    out.print("<div class=\"form-actions\"><input id=\"send\" type=\"submit\" value=\"Submit My Ranking\" class=\"button button-primary\"/><a href=\"home.jsp\">Cancel</a></div>");
                    out.print("</form>");
                    out.print("</div>");
                    out.print("<div class='row'>");
                    out.print("<strong>Speaker not listed? </strong><a href='speakerentry.jsp'>Click here to suggest a new speaker</a>");
                    out.print("</div>");
                }
            %>
        </div><!-- End Container Fixed -->
        <%@ include file="../../includes/footer.jsp" %>
    </body>
</html>

