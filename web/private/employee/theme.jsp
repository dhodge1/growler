<%-- 
    Document   : theme
    Created on : Feb 28, 2013, 7:15:03 PM
    Author     : Justin Bauguess & Jonathan C. McCowan
    Purpose    : The theme (user) page is for users to rank themes according to 
                their preferences.  The ranks are saved in the isolated_theme_ranking
                table for now.  Once users are remembered, it will be saved in the 
                theme_ranking table.  A record in that table will contain a user_id,
                theme_id, and rank.  Ranks can only be between 1 and 10.  Once a user
                has submitted rankings, they can change them later.
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.Theme" %>
<%@page import="com.scripps.growler.ThemePersistence" %>
<%@page import="com.scripps.growler.DataConnection" %>
<jsp:useBean id="theme" class="com.scripps.growler.Theme" scope="page" />
<jsp:useBean id="persist" class="com.scripps.growler.ThemePersistence" scope="page" />
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
        <title>Rank Your Preferred Themes</title><!-- Title -->
        <link rel="shortcut icon" type="image/png" href="http://growler-dev.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://growler-dev.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler-dev.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="http://growler-dev.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <script src="http://growler-dev.elasticbeanstalk.com/js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
        <script src="http://growler-dev.elasticbeanstalk.com/js/libs/sniui.tool-tip.1.2.0.min.js" type="text/javascript"></script>
        <style>
            .arrow {
                top: 50%;
            }
            #themes li {
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
            #ranked label {
                padding-left:3px;
                padding-top: 3px;
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
            #themes {
                margin:0;
                border: 1px solid #ccc;
                overflow-y:auto;
                height:345px;
            }
            #ranked {
                border: 1px solid #ccc;
                margin-left:0px;
            }
            .centerRow {
                margin-left: 4px;
            }
            .interestLabel {
                margin-left:25px;
            }
            h3 {
                font-weight: normal;
            }
            .no-close .ui-dialog-titlebar-close {
                display: none;
            }
        </style>
        <script>
            $(function() {
                $("#resetModal").dialog({
                    autoOpen: false,
                    dialogClass: "no-close",
                    buttons: {
                        'ok': {
                            'class': 'button button-primary',
                            click: function() {
                                $(this).dialog('close');
                            }, text: "OK"}
                        , modal: true
                    }});
                $("#rankModal").dialog({
                    autoOpen: false,
                    dialogClass: "no-close",
                    buttons: {
                        'ok': {
                            'class': 'button button-primary',
                            click: function() {
                                $(this).dialog('close');
                            }, text: "OK"}
                                , modal: true
                    }});
                $("#themes, #ranked").sortable({
                    connectWith: ".connectedSortable",
                    cursor: "move",
                    placeholder: "ui-state-highlight",
                    update: function(event, ui) {
                        $(this).find("label").remove();
                        $("#themes").find(":hidden").prop("name", "none");
                        $("#ranked").find(":hidden").prop("name", "list");
                    },
                    stop: function(event, ui) {
                        if ($("#ranked li").length > 9) {
                            $("#themes").sortable('disable');
                        }
                    }
                }).disableSelection();
                $("li[rel=toolTip]").toolTip();
                //$(".Business, .Technical").toolTip();
                $("#filter").change(function() {
                    if ($("#filter").val() == 1) {
                        $('#themes li').filter('.Business').show();
                        $('#themes li').filter('.Technical').show();
                    }
                    else if ($("#filter").val() == 2) {
                        $('#themes li').filter('.Business').show();
                        $('#themes li').filter('.Technical').hide();
                    }
                    else if ($("#filter").val() == 3) {
                        $('#themes li').filter('.Business').hide();
                        $('#themes li').filter('.Technical').show();
                    }
                });
                $("#ranked").mouseenter(function() {
                    if ($("#ranked li").length > 9) {
                        $("#themes").sortable('enable');
                        $("#themes li").css("cursor", "move");
                    }
                });
                $("#ranked").mouseleave(function() {
                    if ($("#ranked li").length > 9) {
                        $("#themes").sortable('disable');
                        $("#themes li").css("cursor", "default");
                    }
                });
                $("#send").click(function(event) {
                    $("#ranked").find("label").remove(); //Remove the placeholder
                    if ($("#ranked li").length === 0 && parseInt($("#previously").val()) === 0) {
                        event.preventDefault();
                        $("#rankModal").dialog("open");
                    }
                    if (parseInt($("#previously").val()) > 0) {
                        event.preventDefault();
                        $("#resetModal").dialog("open");
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
            ArrayList<Theme> themes = persist.getUserRanks(user);
            ArrayList<Theme> vthemes = persist.getThemesByVisibility(true);
        %>
        <%@ include file="../../includes/header.jsp" %> 
        <%@ include file="../../includes/testnav.jsp" %>
        <div class="container-fixed mediumBottomMargin">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="../../private/employee/home.jsp">Home</a></li>
                    <li class='ieFix'>Rank Your Preferred Themes</li>
                </ul>
            </div>
            <% if (themes.size() > 0) {%>
            <div class="mediumBottomMargin row feedbackMessage-warning">
                <p>You have already submitted a ranking for your preferred presentation themes.  In order to submit a different ranking, you must reset your previous one.
                    <% out.print("<a href='../../action/removeThemeRanks.jsp?return=drag&id=" + user + "'>Reset your previous ranking now.</a>");%>
                </p>
            </div>
            <% } //end if  %>
            <div class="row mediumBottomMargin">
                <h1 style="font-weight:normal;">Rank Your Preferred Themes</h1>
            </div>
            <div class='row largeBottomMargin'>
                <h3>We want to hear from you!  Please let us know the top 10 presentation themes you would be interested in attending for this year's Techtoberfest.</h3>
            </div>
            <div class='row largeBottomMargin'></div>
            <div class="row mediumBottomMargin">
                <h2 class="bordered mediumBottomMargin"><img style="padding-bottom:0;padding-left:0;" id="logo" src='http://growler-dev.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class="titlespan">Which presentations are you most interested in?</span></h2>
                <span>Please drag and drop the presentation themes you are most interested in and rank them 1-10. If desired, you can provide a ranking for less than 10 themes. Once your ranking has been submitted, you can not submit another unless you choose to reset/clear your previous one.<br/></span>
                <div class='smallBottomMargin'></div>
                <span><strong>Note:</strong>  There is also a <a href="../../private/employee/nondragtheme.jsp">non drag and drop version</a> available.</span>
                <div class='row largeBottomMargin'></div>

                <form action='../../action/processThemeRanking.jsp'>
                    <div class='row mediumBottomMargin'>
                        <div class='span5 smallBottomMargin'>
                            <span><strong>Available Presentation Themes</strong></span>
                        </div>
                        <div class='span5 smallBottomMargin'>
                            <span><strong>Presentations Themes I'm Interested In</strong></span>
                        </div>
                        <div class='span5'>
                            <div class='row'>
                                <select id='filter'>
                                    <option value='1'>All Themes</option>
                                    <option value='2'>Business Themes</option>
                                    <option value='3'>Technical Themes</option>
                                </select>
                            </div>
                            <ul id='themes' class='connectedSortable'>
                                <%
                                    for (int i = 0; i < vthemes.size(); i++) {
                                        String desc = vthemes.get(i).getDescription();
                                        out.print("<li rel='toolTip' class=\"" + vthemes.get(i).getType() + "\" data-content=\"" + desc + "\"  title=\"" + vthemes.get(i).getName() + "\" data-placement='left'>");
                                        out.print("<span><strong>" + vthemes.get(i).getName() + "</strong></span>");
                                        out.print("<input type=\"hidden\" name=\"list\" value=\"" + vthemes.get(i).getId() + "\" />");
                                        out.print("</li>");
                                    }
                                %>
                            </ul>
                        </div>
                        <div class='span5'>
                            <ol id='ranked' class='connectedSortable' >
                                <label>Please drag and drop your selections here</label>
                            </ol>
                        </div>
                    </div>
                    <div class='form-actions smallBottomMargin'>
                        <input id="send" type="submit" value="Submit My Ranking" class="button button-primary"/>
                        <a href="../../private/employee/home.jsp">Cancel</a>
                        <input id='previously' name='previously' type='hidden' value=<%= themes.size()%>/>
                    </div>
                    <strong>Presentation not listed? </strong><a href='../../private/employee/themeentry.jsp'>Click here to suggest a new theme</a>
                </form>
            </div>
        </div>
        <%@ include file="../../includes/footer.jsp" %>
        <div id='resetModal' title='Error'>You must reset the previous ranking you’ve submitted before submitting another.</div>
        <div id='rankModal' title='Error'>Please rank at least one theme before submitting.</div>
    </body>
</html>