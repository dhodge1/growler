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
        <link rel="stylesheet" href="../../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../../css/demo.css" />  
        <link rel="stylesheet" href="../../css/draganddrop.css" /><!--Drag and drop style-->
        <link rel="stylesheet" type="text/css" href="../../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="../../css/speaker.css" /><!--Speaker CSS-->
        <link rel="stylesheet" href="/resources/demos/style.css" />

        <script src="../../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <script src="../../js/jquery.ui.touch-punch.min.js"></script>
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
        %>
        <%@ include file="../../includes/header.jsp" %> 
        <%@ include file="../../includes/testnav.jsp" %>
        <div class="container-fixed">
            <br/><br/><br/>
            <div class="row">
                
				<%
                    SpeakerPersistence persist = new SpeakerPersistence();
                    ArrayList<Speaker> speakers = persist.getUserRanks(user);
                    if (speakers == null || speakers.size() == 0) {
                        out.print("<h2 class=bordered><img style=\"padding-bottom:0;padding-left:0;width:200px;\" src='../../images/Techtoberfest2013small.png'/><span class=\"titlespan\">Speakers - Drag & Drop Speakers to Rank Them</span></h2>");
                        out.print("<a href=\"nondragspeaker.jsp\">Non Drag and Drop Speakers</a><br/>");

                    } else {
                        out.print("<h2 class=bordered><img style=\"padding-bottom:0;padding-left:0;width:200px;\" src='../../images/Techtoberfest2013small.png'/><span class=\"titlespan\">Your Speaker Rankings</span></h2>");
                    }
                %>
                
            </div>
            <br/>
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


                %>
				<%
                                            if (speakers == null || speakers.size() == 0) {
                                                ArrayList<Speaker> vspeakers = persist.getSpeakersByVisibility(true, persist.SORT_BY_LAST_NAME_ASC);
                                        %>
                                        <form action="../../action/processSpeakerRanking.jsp">
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
                                            <% if (speakers == null || speakers.size() == 0) {
                                                    out.print("<div class=\"form-actions\"><input id=\"send\" type=\"submit\" value=\"Submit Rankings\" class=\"button button-primary\"/></div>");
                                                }
                                            %>
                                        </form>
                
            </div>
        </div>
        <br/>
        <br/>
        <%@ include file="../../includes/footer.jsp" %>
        <%@ include file="../../includes/scriptlist.jsp" %>
        <%@ include file="../../includes/draganddrop.jsp" %>

        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <script src="../../js/grabRanks.js"></script>

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

