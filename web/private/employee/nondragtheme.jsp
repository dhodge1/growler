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
        <title>Themes</title><!-- Title -->
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
                    $("#themes").find(":hidden").prop("name", "none");
                    $("#ranked").find(":hidden").prop("name", "list");
                });
                $(".Business, .Technical").toolTip();
                $("#filter").on("keyup", function() {
                    var text = $("#filter").val();
                    if (text !== "") {
                        $("#themes li").filter(":contains('" + text + "')").show();
                        $("#themes li").filter(":not(:contains('" + text + "'))").hide();
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
                });
            });
        </script>
        <style>
            #themes li {
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
            #filter {
                width: 88%;
                margin-left: 2px;
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
            if (themes.size() > 0) {
                response.sendRedirect("theme-confirm.jsp");
            }
        %>
        <%@ include file="../../includes/header.jsp" %> 
        <%@ include file="../../includes/testnav.jsp" %>
        <div class="container-fixed largeBottomMargin">
            <div class="row mediumBottomMargin"></div>
            <div class="row mediumBottomMargin">
                <ul class="breadcrumb">
                    <li><a href="home.jsp">Home</a></li>
                    <li>Theme Ranking</li>
                </ul>
            </div>
            <div class="row largeBottomMargin">
                <h1 style="font-weight:normal;">Rank Themes</h1>
            </div>
            <% if (themes == null || themes.size() == 0) {
                    out.print("<div class='row largeBottomMargin'>");
                    out.print("<p style='font-size: 16px; font-family: Arial;'>We want to hear from you!  Please let us know the top 10 presentation themes you would be interested in attending for this year's Techtoberfest.</p>");
                    out.print("</div>");
                    out.print("<div class='row largeBottomMargin'></div>");
                }
            %>
            <div class="row mediumBottomMargin">
                <%
                    //If we didn't get any ranks, we tell the user to rank the themes
                    if (themes == null || themes.size() == 0) {
                        out.print("<h2 class=\"bordered mediumBottomMargin\"><img style=\"padding-bottom:0;padding-left:0;\" id=\"logo\" src='http://sni-techtoberfest.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class=\"titlespan\">Which presentations are you most interested in?</span></h2>");
                        out.print("<span class=\"mediumBottomMargin\">Select the presentation themes you are most interested in.  If desired, you can provide a ranking for less than 10 presentation themes.  There is also a <a href='theme.jsp'>drag and drop version</a> available.</span><br/>");
                        out.print("<span class='mediumBottomMargin'><strong>Note:</strong> The order in which you select the item is the order they will be ranked.</span>");
                    } else { //If we got themes, we let the user see them
                        out.print("<h2 class=bordered><img style=\"padding-bottom:0;padding-left:0;\" src='http://sni-techtoberfest.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class=\"titlespan\">Your Theme Ranks</span></h2>");
                    }
                %>
            </div>
            <%
                out.print("<div class='row'>");
                //If There are Ranked Themes already, here is where they will be displayed

                if (themes == null || themes.size() == 0) {
                    out.print("<form action='../../action/processThemeRanking.jsp'>");
                    out.print("<div class='row mediumBottomMargin'>");
                    out.print("<div class='span5 smallBottomMargin'>");
                    out.print("<span><strong>Available Themes</strong></span>");
                    out.print("</div>");
                    out.print("<div class='span5 smallBottomMargin'>");
                    out.print("<span><strong>Presentations Themes I'm Interested In</strong></span>");
                    out.print("</div>");
                    out.print("<div class='span5'>");
                    out.print("<div class='row'>");
                    out.print("<span><strong>Filter:</strong></span>");
                    out.print("<input id='filter' type='text' name='filter' />");
                    out.print("</div>");
                    out.print("<ul id='themes'>");
                    for (int i = 0; i < vthemes.size(); i++) {
                        out.print("<li class=\"" + vthemes.get(i).getType() + "\" data-content=\"" + vthemes.get(i).getDescription() + "\"  title=\"" + vthemes.get(i).getName() + "\" data-placement='left'>");
                        out.print("<input type='checkbox' id='" + vthemes.get(i).getId() + "'/>");
                        out.print(vthemes.get(i).getName());
                        out.print("<input type=\"hidden\" name=\"list\" value=\"" + vthemes.get(i).getId() + "\" />");
                        out.print("</li>");
                    }
                    out.print("</ul>");
                    out.print("</div>");
                    out.print("<div class='span5'>");
                    out.print("<ol id='ranked'>");
                    out.print("<li class='placeholder'>Ranked Themes</li>");
                    out.print("</ol>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("<div class=\"form-actions\"><input id=\"send\" type=\"submit\" value=\"Submit My Ranking\" class=\"button button-primary\"/><a href=\"home.jsp\">Cancel</a></div>");
                    out.print("<strong>Presentation not listed? </strong><a href='themeentry.jsp'>Click here to suggest a new theme</a>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</form>");
                }
            %>
        </div>
        <%@ include file="../../includes/footer.jsp" %>
    </body>
</html>