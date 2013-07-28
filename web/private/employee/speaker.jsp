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
        <title>Rank Your Preferred Speakers</title><!-- Title -->
        <link rel="shortcut icon" type="image/png" href="http://sni-techtoberfest.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/speakers/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="http://sni-techtoberfest.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <style>
            #speakers li {
                list-style-type: none;
                cursor: move;
                border: 1px solid #ccc;
                overflow: auto;
                padding: 3px;
                margin: 5px;
                border-top: 6px solid #79BDEB;
                box-shadow: 2px 2px 2px 2px #ccc;
                -webkit-box-shadow: 2px 2px 2px 2px #ccc;
            }
            #ranked li {
                list-style-type: decimal-leading-zero;
                cursor: move;
                border: 1px solid #ccc;
                overflow: auto;
                padding: 3px;
                margin: 5px;
                border-top: 6px solid #79BDEB;
                box-shadow: 2px 2px 2px 2px #ccc;
                -webkit-box-shadow: 2px 2px 2px 2px #ccc;
                background: #fff;
            }
            #ranked {
                list-style-position: inside;
                height: 368px;
                background: #ddd;
            }
            #filter {
                width: 97.5%;
                margin-left: 1.28%;
            }
            #speakers {
                margin:0;
                border: 1px solid #ccc;
                overflow-y:auto;
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
        <script>
            $(function() {
                $("#speakers, #ranked").sortable({
                    connectWith: ".connectedSortable",
                    placeholder: "ui-state-highlight",
                    update: function(event, ui) {
                        $(this).find(".placeholder").remove();
                        $("#speakers").find(":hidden").prop("name", "none");
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
                $("#ranked").mouseenter(function() {
                    if ($("#ranked li").length > 9) {
                        $("#speakers").sortable('enable');
                        $("#speakers li").css("cursor", "move");
                    }
                });
                $("#ranked").mouseleave(function() {
                    if ($("#ranked li").length > 9) {
                        $("#speakers").sortable('disable');
                        $("#speakers li").css("cursor", "default");
                    }
                });
                $("#send").click(function(event) {
                    $("#ranked").find(".placeholder").remove(); //Remove the placeholder
                    if ($("#ranked li").length === 0) {
                        event.preventDefault();
                        alert("Please rank at least one speaker before submitting.");
                    }
                    if (parseInt($("#previously").val()) > 0) {
                        event.preventDefault();
                        alert("Please reset your rankings before submitting again.")
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
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="../../private/employee/home.jsp">Home</a></li>
                    <li>Rank Speakers</li>
                </ul>
            </div>
            <% if (speakers.size() > 0) {  %>
            <div class="mediumBottomMargin">
                <p class="feedbackMessage-warning">You have already submitted a ranking for your preferred speakers.  In order to submit a different ranking, you must reset your previous one.
                    <% out.print("<a href='../../action/removeSpeakerRanks.jsp?id=" + user + "'>Reset your previous ranking now.</a>");%>
                </p>
            </div>
            <% } //end if  %>
            <div class="row mediumBottomMargin">
                <h1 style="font-weight:normal;">Rank Speakers</h1>
            </div>
            <div class='row largeBottomMargin'>
                <p style='font-size: 16px; font-family: Arial;'>We want to hear from you!  Please let us know the top 10 speakers you would be interested in listening to for this year's Techtoberfest.</p>
            </div>
            <div class='row mediumBottomMargin'></div>
            <div class="row mediumBottomMargin">
                <h2 class='bordered mediumBottomMargin'><img style='padding-bottom:0;padding-left:0;' src='http://sni-techtoberfest.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class='titlespan'>Which speakers are you most interested in?</span></h2>
                <span>Please drag and drop the speakers you are most interested in and rank them 1-10. If desired, you can provide a ranking for less than 10 speakers. Once your ranking has been submitted, you can not submit another unless you choose to reset/clear your previous one.  <br/><strong>Note:</strong>There is also a <a href=../../private/employee/nondragspeaker.jsp>non drag and drop version</a> available.</span>
                <div class='row mediumBottomMargin'></div>

            </div>

            <form action='../../action/processSpeakerRanking.jsp'>
                <div class='row mediumBottomMargin'>
                    <div class='span5 smallBottomMargin'>
                        <span><strong>Available Speakers</strong></span><span class='pullRight'><a href='#'>Last years ranking</a></span>
                    </div>
                    <div class='span5 smallBottomMargin'>
                        <span class='interestLabel'><strong>Speakers I'm Interested In</strong></span>
                    </div>
                    <div class='span5'>
                        <div class='row'>
                            <select id='filter'>
                                <option value='1'>All Speakers</option>
                                <option value='2'>Business Speakers</option>
                                <option value='3'>Technical Speakers</option>
                            </select>
                        </div>
                        <ul id='speakers' class='connectedSortable'>
                            <%
                        for (int j = 0; j < vspeakers.size(); j++) {
                            out.print("<li class=\"" + vspeakers.get(j).getType() + "\">");
                            out.print("<span><strong>" + vspeakers.get(j).getLastName() + ", " + vspeakers.get(j).getFirstName() + "</strong></span>");
                            out.print("<input type=\"hidden\" name=\"list\" value=\"" + vspeakers.get(j).getId() + "\" />");
                            out.print("</li>");
                        }
                            %>
                        </ul>
                    </div>
                    <div class='span5'>
                        <ol id='ranked' class='connectedSortable'>
                            <li class='placeholder'>Place speakers here</li>
                        </ol>
                    </div>
                </div>
                <div class=form-actions><input id='send' type='submit' value='Submit My Ranking' class='button button-primary'/><a href=../../private/employee/home.jsp>Cancel</a></div>
                <strong>Speaker not listed? </strong><a href='../../private/employee/speakerentry.jsp'>Click here to suggest a new speaker</a>
                <input id='previously' name='previously' type='hidden' value=<%= speakers.size() %>/>
</form>
</div><!-- End Container Fixed -->
<%@ include file="../../includes/footer.jsp" %>
</body>
</html>

