<%-- 
    Document   : nondragspeaker
    Created on : Jun 14, 2013, 11:31:26 AM
    Author     : 162107
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.Speaker" %>
<%@page import="com.scripps.growler.SpeakerPersistence" %>
<jsp:useBean id="persist" class="com.scripps.growler.SpeakerPersistence" scope="page" />
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
        <title>Rank Your Preferred Speakers</title><!-- Title -->
        <link rel="shortcut icon" type="image/png" href="http://sni-techtoberfest.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/speakers/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="http://sni-techtoberfest.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <!--Additional Script-->
        <script>
            $().ready(function() {
                //What happens when you click an available theme
                $(":checkbox").click(function() {
                    $("#ranked").find(".placeholder").remove(); //Remove the placeholder
                    var id = ($(this).prop("id")); //Get the ID of the checkbox
                    if ($(this).prop("checked") === true) {
                        ($("#ranked")).append($(this).parent().clone(true)); //Add it to the ranked list
                    }
                    else {
                        $("#ranked").find("#" + id).parent().remove(); //Remove it from the list
                    }
                    $("#speakers").find(":hidden").prop("name", "none");
                    $("#ranked").find(":hidden").prop("name", "list");
                });
                $("#filter").on("keyup", function() {
                    var text = $("#filter").val();
                    if (text !== "") {
                        $("#speakers li").filter(":contains('" + text + "')").show();
                        $("#speakers li").filter(":not(:contains('" + text + "'))").hide();
                    }
                    else if (text === "") {
                        $("#speakers li").show();
                    }
                });
                $("#send").click(function(event) {
                    $("#ranked").find(".placeholder").remove(); //Remove the placeholder
                    if ($("#ranked li").length === 0) {
                        event.preventDefault();
                        alert("Please rank at least one speaker before submitting.");
                    }
                });
            });
        </script>
        <style>
            #speakers li {
                list-style-type: none;
                border: 1px solid #ccc;
                overflow: auto;
                padding: 3px;
                margin: 5px;
                border-top: 6px solid #0067b1;
                box-shadow: 2px 2px 2px 2px #ccc;
                -webkit-box-shadow: 2px 2px 2px 2px #ccc;
            }
            #ranked li {
                list-style-type: decimal-leading-zero;
                border: 1px solid #ccc;
                overflow: auto;
                padding: 3px;
                margin: 5px;
                border-top: 6px solid #0067b1;
                box-shadow: 2px 2px 2px 2px #ccc;
                -webkit-box-shadow: 2px 2px 2px 2px #ccc;
            }
            #ranked {
                list-style-position: inside;
            }
            #filtertext {
                margin-left:1.28%
            }
            #filter {
                width: 87.5%;
                margin-left: 2px;
            }
            #speakers {
                margin:0;
                border: 1px solid #ccc;
                overflow-y:scroll;
                height:345px;
            }
            #ranked {
                border: 1px solid #ccc;
            }
            .centerRow {
                margin-left: 4px;
            }
            .interestLabel {
                margin-left:25px;
            }
            .pullRight {
                float: right;
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
            ArrayList<Speaker> vspeakers = persist.getSpeakersByVisibility(true, persist.SORT_BY_LAST_NAME_ASC);
            if (speakers.size() > 0) {
                response.sendRedirect("../../private/employee/speaker-confirm.jsp");
            }
        %>
        <%@ include file="../../includes/header.jsp" %> 
        <%@ include file="../../includes/testnav.jsp" %>
        <div class="container-fixed largeBottomMargin">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="../../private/employee/home.jsp">Home</a></li>
                    <li>Rank Speakers</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="font-weight:normal;">Rank Speakers</h1>
            </div>
            <% if (speakers == null || speakers.size() == 0) {
                    out.print("<div class='row largeBottomMargin'>");
                    out.print("<p style='font-size: 16px; font-family: Arial;'>We want to hear from you!  Please let us know the top 10 speakers you would be interested in attending for this year's Techtoberfest.</p>");
                    out.print("</div>");
                    out.print("<div class='row mediumBottomMargin'></div>");
                }
            %>
            <div class="row mediumBottomMargin">
                <%
                    //If we didn't get any ranks, we tell the user to rank the speakers
                    if (speakers == null || speakers.size() == 0) {
                        out.print("<h2 class=\"bordered mediumBottomMargin\"><img style=\"padding-bottom:0;padding-left:0;\" id=\"logo\" src='http://sni-techtoberfest.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class=\"titlespan\">Which speakers are you most interested in?</span></h2>");
                        out.print("<span>Select the speakers you are most interested in.  If desired, you can provide a ranking for less than 10 speakers.  There is also a <a href='../../private/employee/speaker.jsp'>drag and drop version</a> available.</span><br/>");
                        out.print("<span><strong>Note:</strong> The order in which you select the item is the order they will be ranked.</span>");
                        out.print("<div class='mediumBottomMargin'></div>");
                    }
                %>
            </div>
            <%
                out.print("<div class='row'>");
                if (speakers == null || speakers.size() == 0) {
                    out.print("<form action='../../action/processSpeakerRanking.jsp'>");
                    out.print("<div class='row mediumBottomMargin'>");                    
                    out.print("<div class='span5 smallBottomMargin'>");
                    out.print("<span><strong>Available Speakers</strong></span>");
                    out.print("</div>");
                    out.print("<div class='span5 smallBottomMargin'>");
                    out.print("<span class='interestLabel'><strong>Speakers I'm Interested In</strong></span><span class='pullRight'><a href='#'>View Bios</a></span>");
                    out.print("</div>");
                    out.print("<div class='span5'>");
                    out.print("<div class='row'>");
                    out.print("<span id='filtertext'><strong>Filter:</strong></span>");
                    out.print("<input id='filter' type='text' name='filter' />");
                    out.print("</div>");
                    out.print("<ul id='speakers'>");
                    for (int i = 0; i < vspeakers.size(); i++) {
                        out.print("<li class=\"" + vspeakers.get(i).getType() + "\">");
                        out.print("<input type='checkbox' id='" + vspeakers.get(i).getId() + "'/>");
                        out.print(vspeakers.get(i).getFullName());
                        out.print("<input type=\"hidden\" name=\"list\" value=\"" + vspeakers.get(i).getId() + "\" />");
                        out.print("</li>");
                    }
                    out.print("</ul>");
                    out.print("</div>");
                    out.print("<div class='span5'>");
                    out.print("<ol id='ranked'>");
                    out.print("<li class='placeholder'>Ranked Speakers</li>");
                    out.print("</ol>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("<div class=\"form-actions\"><input id=\"send\" type=\"submit\" value=\"Submit My Ranking\" class=\"button button-primary\"/><a href=\"../../private/employee/home.jsp\">Cancel</a></div>");
                    out.print("<strong>Speaker not listed? </strong><a href='../../private/employee/speakerentry.jsp'>Click here to suggest a new speaker</a>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</form>");
                }
            %>
        </div>
        <%@ include file="../../includes/footer.jsp" %>
    </body>
</html>
