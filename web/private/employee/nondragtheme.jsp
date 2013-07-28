<%-- 
    Document   : nondragtheme
    Created on : Jun 14, 2013, 10:07:15 AM
    Author     : 162107
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.Theme" %>
<%@page import="com.scripps.growler.ThemePersistence" %>
<jsp:useBean id="theme" class="com.scripps.growler.Theme" scope="page" />
<jsp:useBean id="persist" class="com.scripps.growler.ThemePersistence" scope="page" />
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
        <link rel="shortcut icon" type="image/png" href="http://sni-techtoberfest.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="http://sni-techtoberfest.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <script src="http://sni-techtoberfest.elasticbeanstalk.com/js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
        <script src="http://sni-techtoberfest.elasticbeanstalk.com/js/libs/sniui.tool-tip.1.2.0.min.js" type="text/javascript"></script>
        <!--Additional Script-->
        <script>
            $().ready(function() {
                jQuery.expr[":"].icontains = jQuery.expr.createPseudo(function(arg) {
                    return function(elem) {
                        return jQuery(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
                    };
                });
                //What happens when you click an available theme
                $(":checkbox").click(function() {
                    $("#ranked").find(".placeholder").remove(); //Remove the placeholder
                    var id = ($(this).prop("id")); //Get the ID of the checkbox
                    if ($(this).prop("checked") === true) {
                        ($("#ranked")).append($(this).parent().clone(true)); //Add it to the ranked list
                    }
                    else {
                        $("#ranked").find("#" + id).parent().remove(); //Remove it from the list
                        $("#themes").find("#" + id).prop("checked", false); //Remove it from the list
                    }
                    $("#themes").find(":hidden").prop("name", "none");
                    $("#ranked").find(":hidden").prop("name", "list");
                });
                $(".Business, .Technical").toolTip();
                $("#filter").on("keyup", function() {
                    var text = $("#filter").val();
                    if (text !== "") {
                        $("#themes li").filter(":icontains('" + text + "')").show();
                        $("#themes li").filter(":not(:icontains('" + text + "'))").hide();
                    }
                    else if (text === "") {
                        $("#themes li").show();
                    }
                });
                $("#send").click(function(event) {
                    $("#ranked").find(".placeholder").remove(); //Remove the placeholder
                    if ($("#ranked li").length === 0) {
                        event.preventDefault();
                        alert("Please rank at least one theme before submitting.");
                    }
                    if (parseInt($("#previously").val()) > 0) {
                        event.preventDefault();
                        alert("Please reset your rankings before submitting again.")
                    }
                });
            });
            function clearFilter() {
                $("#filter").val("");
            }
        </script>
        <style>
            input[type="checkbox"] {
                position:relative;
                bottom: 5px;
                margin-right: 6px;
            }
            .tooltip .left .arrow {
                top: 50%;
            }
            .popover .left .arrow {
                top: 50%;
            }
            #themes li {
                list-style-type: none;
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
                border: 1px solid #ccc;
                overflow: auto;
                padding: 3px;
                margin: 5px;
                border-top: 6px solid #79BDEB;
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
                width: 100%;
            }
            #themes {
                margin:0;
                border: 1px solid #ccc;
                overflow-y: scroll;
                height:340px;
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
            ArrayList<Theme> themes = persist.getUserRanks(user);
            ArrayList<Theme> vthemes = persist.getThemesByVisibility(true);
        %>
        <%@ include file="../../includes/header.jsp" %> 
        <%@ include file="../../includes/testnav.jsp" %>
        <div class="container-fixed largeBottomMargin">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="../../private/employee/home.jsp">Home</a></li>
                    <li>Rank Your Preferred Themes</li>
                </ul>
            </div>
            <% if (themes.size() > 0) {%>
            <div class="mediumBottomMargin">
                <p class="feedbackMessage-warning">You have already submitted a ranking for your preferred presentation themes.  In order to submit a different ranking, you must reset your previous one.
                    <% out.print("<a href='../../action/removeThemeRanks.jsp?id=" + user + "'>Reset your previous ranking now.</a>");%>
                </p>
            </div>
            <% } //end if  %>
            <div class="row mediumBottomMargin">
                <h1 style="font-weight:normal;">Rank Your Preferred Themes</h1>
            </div>

            <div class='row largeBottomMargin'>
                <p style='font-size: 16px; font-family: Arial;'>We want to hear from you!  Please let us know the top 10 presentation themes you would be interested in attending for this year's Techtoberfest.</p>
            </div>
            <div class='row largeBottomMargin'></div>

            <div class="row mediumBottomMargin">
                <h2 class="bordered mediumBottomMargin"><img style="padding-bottom:0;padding-left:0;" id="logo" src='http://sni-techtoberfest.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class="titlespan">Which presentations are you most interested in?</span></h2>
                <span>Select the presentation themes you are most interested in. If desired, you can provide a ranking for less than 10 presentation themes. Once your ranking has been submitted, you can not submit another unless you choose to reset/clear your previous one.  There is also a <a href='../../private/employee/theme.jsp'>drag and drop version</a> available.</span><br/>
                <span><strong>Note:</strong> The order in which you select the item is the order they will be ranked.</span>
                <div class='row largeBottomMargin'></div>
            </div>
            <form action='../../action/processThemeRanking.jsp'>
                <div class='row mediumBottomMargin'>
                    <div class='span5 smallBottomMargin'>
                        <span><strong>Available Themes</strong></span>
                    </div>
                    <div class='span5 smallBottomMargin'>
                        <span class='interestLabel'><strong>Presentations Themes I'm Interested In</strong></span>
                    </div>
                    <div class='span5'>
                        <div class='row'>
                            <span class="keywordFilter" style="width:100%;">
                                <i class="icon16-magnifySmall"></i>
                                <span class="keywordFilter-wrapper">
                                    <input type="search" id="filter" value="Filter..." />
                                </span>
                                <a class="keywordFilter-clear" onclick="clearFilter();"><i class="icon16-close"></i></a>
                            </span>
                        </div>
                        <ul id='themes'>
                            <%        for (int i = 0; i < vthemes.size(); i++) {
                                    out.print("<li class=\"" + vthemes.get(i).getType() + "\" data-content=\"" + vthemes.get(i).getDescription() + "\"  title=\"" + vthemes.get(i).getName() + "\" data-placement='left'>");
                                    out.print("<input type='checkbox' id='" + vthemes.get(i).getId() + "'/>");
                                    out.print(vthemes.get(i).getName());
                                    out.print("<input type=\"hidden\" name=\"list\" value=\"" + vthemes.get(i).getId() + "\" />");
                                    out.print("</li>");
                                }%>
                        </ul>
                    </div>
                    <div class='span5'>
                        <ol id='ranked'>
                            <li class='placeholder'>Ranked Themes</li>
                        </ol>
                    </div>
                </div>
                <div class="form-actions"><input id="send" type="submit" value="Submit My Ranking" class="button button-primary"/><a href="../../private/employee/home.jsp">Cancel</a></div>
                <strong>Presentation not listed? </strong><a href='../../private/employee/themeentry.jsp'>Click here to suggest a new theme</a>
                <input id='previously' name='previously' type='hidden' value=<%= themes.size()%>/>
            </form>
        </div>
        <%@ include file="../../includes/footer.jsp" %>
    </body>
</html>