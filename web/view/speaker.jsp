<%-- 
    Document   : speaker
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

        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/demo.css" />  
        <link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
        <link rel="stylesheet" type="text/css" href="../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="../css/speaker.css" /><!--Speaker CSS-->
        <link rel="stylesheet" href="/resources/demos/style.css" />

        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%
                    String user = "";
                    try {
                        user = String.valueOf(session.getAttribute("id"));
                        String name = String.valueOf(session.getAttribute("user"));                  
                    }
                    catch (Exception e) {
                        
                    }
                    if (user == "null") {
                        response.sendRedirect("../index.jsp");
                    }
                %>
        <%@ include file="../includes/header.jsp" %> 
        <%@ include file="../includes/usernav.jsp" %>
        <div class="row">
            <div class="span3">
                <img class="logo" src="../images/Techtoberfest2013small.png" alt="Techtoberfest 2013 small"/><!-- Techtoberfest logo-->
            </div>
            <div class="span6 largeBottomMargin">
                <%
                    SpeakerPersistence persist = new SpeakerPersistence();
                    ArrayList<Speaker> speakers = persist.getUserRanks(Integer.parseInt(user));
                    if (speakers == null || speakers.size() == 0) {
                        out.print("<h1 class=bordered>Speakers - Drag & Drop Speakers to Rank Them</h1>");
                        
                    } else {
                        out.print("<h1 class=bordered>Your Speaker Rankings</h1>");
                    }
                    %>
                    <%@include file="../includes/messagehandler.jsp" %>
                    <%
                                
                        
                        for (int i = 0; i < speakers.size(); i++) {
                            out.print("<tr><th>Rank " + (i + 1) + "</th><td>" + speakers.get(i).getLastName()
                                    + ", " + speakers.get(i).getFirstName() + "</td></tr>");
                        }
                        out.print("</table>");
                        out.print("<a href=\"../model/removeSpeakerRanks.jsp?id=" + user + "\">Reset Ranks</a>");
                    }


                %>
            </div>

        </div>
        <div class="container-fluid">
            <div class="content">
                <!-- Begin Content -->
                <div class="row"><!--row-->
                    <div class="span6 offset3"><!--span-->
                        <div id="tabs-1">
                            <div class="row">
                                <div class="span1">
                                    <br/>					

                                </div>
                                <div class="span2">
                                    <section>
                                        <%
                                            if (speakers == null || speakers.size() == 0) {
                                                ArrayList<Speaker> vspeakers = persist.getSpeakersByVisibility(true, persist.SORT_BY_LAST_NAME_ASC);
                                        %>
                                        <form action="../model/processSpeakerRanking.jsp">
                                            <ul class="sortable">
                                                <%
                                                    for (int j = 0; j < vspeakers.size(); j++) {
                                                %>
                                                <li id="lisort"> 
                                                    <% out.print(vspeakers.get(j).getLastName() + ", " + vspeakers.get(j).getFirstName());%>
                                                    <% out.print(giveStars.return2012Rank(vspeakers.get(j).getId()));%>
                                                    <% out.print(giveStars.returnCount(vspeakers.get(j).getId()));%>
                                                    <% out.print("<input type=\"hidden\" name=\"list\" value=\"" + vspeakers.get(j).getId() + "\" />");%>
                                                </li>
                                                <% }
                                                    }
                                                %>
                                            </ul>

                                    </section>
                                </div>
                                <br/>
                            </div>
                        </div>
                    </div><!--end span-->
                </div><!--end row-->
                <div class="span2 offset3"><!--button div-->
                    <% if (speakers == null || speakers.size() == 0) {
                            out.print("<input type=\"submit\" value=\"Submit Rankings\" class=\"button button-primary\"/>");
                        }
                    %>
                    </form>

                </div>
            </div><!-- End Content -->
        </div><!--/.container-fluid-->

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

