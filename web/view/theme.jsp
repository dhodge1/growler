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
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/demo.css" />  
        <link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
        <link rel="stylesheet" type="text/css" href="../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="../css/theme.css" /><!--Theme CSS-->
        <link rel="stylesheet" href="/resources/demos/style.css" />

        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">  
        <%
                    String user = "";
                    if (null == session.getAttribute("id")) {
                        response.sendRedirect("../index.jsp");
                    }
                    try {
                        user = String.valueOf(session.getAttribute("id"));
                        String name = String.valueOf(session.getAttribute("user"));                  
                    }
                    catch (Exception e) {
                        
                    }
                %>
        <%@ include file="../includes/header.jsp" %> 
        <div class="row">
        <%@ include file="../includes/usernav.jsp" %>
        </div>
        <div class="row"><!-- The Logo Row -->
            <div class="span3">
                <img class="logo" src="../images/Techtoberfest2013small.png" alt="Techtoberfest 2013 small"/><!-- Techtoberfest logo-->
            </div>
            <div class="span7 largeBottomMargin">
                <%
                    //Get a list of Themes by calling getUserRanks
                    ArrayList<Theme> themes = persist.getUserRanks(Integer.parseInt(user));
                    //If we didn't get any ranks, we tell the user to rank the themes
                    if (themes == null || themes.size() == 0) {
                        out.print("<h1 class=bordered>Themes - Drag & Drop Themes to Rank Them</h1>");
                    } else { //If we got themes, we let the user see them
                        out.print("<h1 class=bordered>Your Theme Ranks</h1>");
                    }
                %>
                <%@include file="../includes/messagehandler.jsp" %>
            </div>
        </div>
        <div class="container-fluid">
            <div class="content">
                <!-- Begin Content -->
                <div class="row"><!--row-->
                    <div class="span6 offset3"><!--span-->
                        <div id="tabs-1">
                            <div class="row">
                                <div class="span6 offset1">
                                    <section>
                                        <%
                                            //If There are Ranked Themes already, here is where they will be displayed
                                            if (themes.size() > 0) {
                                                out.print("<table class=\"propertyGrid\">");
                                                for (int i = 0; i < themes.size(); i++) {
                                                    out.print("<tr><th>Rank " + (i + 1) + "</th><td>" + themes.get(i).getName() + "</td></tr>");
                                                }
                                                
                                                out.print("</table><br/>");
                                                out.print("<a href=\"../model/removeThemeRanks.jsp?id=" + user + "\">Reset Ranks</a>");
                                                
                                            }


                                        %>
                                        <form action="../model/processThemeRanking.jsp" >
                                            <ul id="sortable">
                                                <%
                                                    if (themes == null || themes.size() == 0) {

                                                        ArrayList<Theme> vthemes = persist.getThemesByVisibility(true);
                                                        for (int i = 0; i < vthemes.size(); i++) {
                                                %>
                                                <li class="ui-state-default" id="lisort">
                                                    <%
                                                        out.print(vthemes.get(i).getName() + " : ");
                                                        out.print(vthemes.get(i).getDescription());
                                                        out.print("<input type=\"hidden\" name=\"list\" value=\"" + vthemes.get(i).getId() + "\" >");
                                                    %></li><%
                                                            }
                                                        }
                                                    %>
                                            </ul>	
                                    </section>
                                </div>
                                <div class="span3">
                                    <p></p>
                                </div>
                            </div>
                        </div>
                    </div><!--end span-->
                </div><!--end row-->
                <div class="span2 offset3"><!--button div-->
                    <% if (themes == null || themes.size() == 0) {
                            out.print("<input type=\"submit\" value=\"Submit Rankings\" class=\"button button-primary\"/>");
                        }
                    %>
                    </form>	
                </div>
            </div><!-- End Content -->	
        </div><!--/.container-fluid-->
                <div class="row">
            <div class="span8">
                <p></p>
            </div>
            <div class="span2">
            </div>
        </div>

        <%@ include file="../includes/footer.jsp" %>
        <%@ include file="../includes/scriptlist.jsp" %>
        <%@ include file="../includes/draganddrop.jsp" %>

        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <script src="../js/grabRanks.js"></script>

        <!--Additional Script-->
        <script>
            $(function() {
                $("#sortable").sortable({revert: true});
                $("#draggable").draggable({connectToSortable: "#sortable", helper: "clone", revert: "invalid"});
                $("ul, li").disableSelection();
            });
        </script>
    </body>
</html>

