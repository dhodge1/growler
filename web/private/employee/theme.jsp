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

        <title>Themes</title><!-- Title -->

        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" type="text/css" href="../../css/general.css" /><!--General CSS-->
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <style>
            #themes li {
                list-style-type: none;
                height:30px;
            }
        </style>
        <!--Additional Script-->
        <script>
            $(function() {
                $("#themes, #ranked").sortable({
                    connectWith: ".connectedSortable",
                    placeholder: "ui-state-highlight",
                    update: function(event, ui) {
                        $(this).find(".placeholder").remove();
                        $("#themes").find(":hidden").prop("name", "none");
                        $("#ranked").find(":hidden").prop("name", "list");
                    },
                    stop: function(event, ui) {
                        if ($("#ranked li").length > 9) {
                            $("#themes").sortable({
                                disabled: true
                            });
                        }
                    },
                    start: function(event, ui) {
                        if ($("#ranked li").length >= 10) {
                            $("#themes").sortable({
                                connectWith: ".connectedSortable",
                                placeholder: "ui-state-highlight"
                            });
                        }
                    }
                }).disableSelection();
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
        <div class="container-fixed largeBottomMargin">
            <div class="row mediumBottomMargin">
                <ul class="breadcrumb" style='padding-top:12px;'>
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
                }
            %>
            <div class="row mediumBottomMargin">
                <%
                    //If we didn't get any ranks, we tell the user to rank the themes
                    if (themes == null || themes.size() == 0) {
                        out.print("<h2 class=\"bordered mediumBottomMargin\"><img style=\"padding-bottom:0;padding-left:0;\" id=\"logo\" src='http://sni-techtoberfest.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class=\"titlespan\">Which presentations are you most interested in?</span></h2>");
                        out.print("<span class=\"mediumBottomMargin\">Please note: If desired, you can provide a ranking for less than 10 presentation themes.  There is also a <a href=\"nondragtheme.jsp\">non drag and drop version</a> available.</span>");
                    } else { //If we got themes, we let the user see them
                        out.print("<h2 class=bordered><img style=\"padding-bottom:0;padding-left:0;\" src='http://sni-techtoberfest.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class=\"titlespan\">Your Theme Ranks</span></h2>");
                    }
                %>
            </div>
            <%
                out.print("<div class='row mediumBottomMargin'>");
                //If There are Ranked Themes already, here is where they will be displayed
                if (themes.size() > 0) {
                    out.print("<table class=\"propertyGrid\">");
                    for (int i = 0; i < themes.size(); i++) {
                        out.print("<tr><th>Rank " + (i + 1) + "</th><td>" + themes.get(i).getName() + "</td></tr>");
                    }
                    out.print("</table><br/>");
                    out.print("<a href=\"../../action/removeThemeRanks.jsp?id=" + user + "\">Reset Ranks</a>");
                    out.print("</div>");
                }
                if (themes == null || themes.size() == 0) {
                    out.print("<form action='../../action/processThemeRanking.jsp'>");
                    out.print("<div class='row mediumBottomMargin'>");
                    out.print("<div class='span5' style='overflow:auto;height:300px;'>");
                    out.print("<span>Available Presentation Themes</span><br/>");
                    out.print("<select id='filter'>");
                    out.print("<option value='1'>All Themes</option>");
                    out.print("<option value='2'>Business Themes</option>");
                    out.print("<option value='3'>Technical Themes</option>");
                    out.print("</select>");
                    out.print("<ul id='themes' class='connectedSortable'>");
                    for (int i = 0; i < vthemes.size(); i++) {
                        out.print("<li class=\"" + vthemes.get(i).getType() + "\">");
                        out.print(vthemes.get(i).getName() + " : ");
                        out.print(vthemes.get(i).getDescription());
                        out.print("<input type=\"hidden\" name=\"list\" value=\"" + vthemes.get(i).getId() + "\" >");
                        out.print("</li>");
                    }
                    out.print("</ul>");
                    out.print("</div>");
                    out.print("<div class='span5'>");
                    out.print("<span>Presentations Themes I'm Interested In</span>");
                    out.print("<ol id='ranked' class='connectedSortable' >");
                    out.print("<li class='placeholder'>Place Ranked Themes Here</li>");
                    out.print("</ol>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("<div class='row mediumBottomMargin'>");
                    out.print("<input id=\"send\" style=\"padding-right: 6px;\" type=\"submit\" value=\"Submit Rankings\" class=\"button button-primary\"/>");
                    out.print("<a href=\"home.jsp\">Cancel</a>");
                    out.print("</div>");
                    out.print("<div class='row'>");
                    out.print("<strong>Presentation not listed? </strong><a href='themeentry.jsp'>Click here to suggest a new theme</a>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</div>");
                    out.print("</form>");
                }
            %>
        </div>
        <%@ include file="../../includes/footer.jsp" %>
    </body>
</html>

