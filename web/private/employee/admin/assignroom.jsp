<%-- 
    Document   : assignspeaker
    Created on : Jun 10, 2013, 10:52:05 AM
    Author     : 162107
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>Assign a Room to a Session</title><!-- Title -->
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="shortcut icon" type="image/png" href="http://sni-techtoberfest.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <script src="http://sni-techtoberfest.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <style>
            h1, h3 {
                font-weight: normal;
            }
            .no-close .ui-dialog-titlebar-close {
                display: none;
            }
            .keywordFilter-clear {
                cursor: pointer;
            }
            .pullRight {
                float: right;
                top:10px;
                position:relative;
            }
            #sessions {
                list-style-type: none;
                height: 345px;
                overflow-y: auto;
                border: 1px solid #ccc;
                margin:0;
                margin-bottom: 24px;
            }
            input[type="radio"] {
                position:relative;
                bottom: 5px;
                margin-right: 6px;
            }
        </style>
    </head>
    <body id="growler1">
        <%
            int user = 0;
            String roomPassed = "TBD";
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../../../index.jsp");
            } else if (!session.getAttribute("role").equals("admin")) {
                response.sendRedirect("../../../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
                roomPassed = (request.getParameter("roomId"));
            } catch (Exception e) {
            }
        %>

        <%@ include file="../../../includes/adminheader.jsp" %> 
        <%@ include file="../../../includes/adminnav.jsp" %>
        <div class="container-fixed">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="../../../private/employee/admin/home.jsp">Home</a></li>
                    <li class='ieFix'>Assign A Room</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="margin-top:0px;font-weight: normal;">Assign A Room</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>To assign a room to a session, choose an available session from the list and press the <strong>Assign</strong> button.</h3>
            </div>
            <div class="row largeBottomMargin"></div>
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='http://sni-techtoberfest.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class="titlespan">Assign Details</span></h2>
            </div>
            <div class="row largeBottomMargin">
                <%
                    SessionPersistence sessionPersist = new SessionPersistence();
                    LocationPersistence locationPersist = new LocationPersistence();
                    Location location = locationPersist.getLocationById(roomPassed);
                    ArrayList<Session> sessions = sessionPersist.getThisYearSessions(2013, " order by session_date");
                %>
                <form id="action" action="../../../action/processRoomAssign.jsp" method="post">
                    <div class="form-group"><strong><% out.print(location.getId() + ", " + location.getDescription() + ", " + location.getBuilding());%></strong>
                    <input type="hidden" name="location" value="<%= location.getId() %>"/>
                    </div>
                    <div class="form-group" style="margin-bottom: 6px;">
                        <span class="keywordFilter">
                            <i class="icon16-magnifySmall"></i>
                            <span class="keywordFilter-wrapper">
                                <input type="search" id="filter" value="Filter..." />
                            </span>
                            <a class="keywordFilter-clear" onclick="clearFilter();"><i class="icon16-close"></i></a>
                        </span><span class="pullRight"><a href="#">Refresh List</a></span></div>
                    <div class="form-group">
                        <ol id="sessions">
                            <%
                                SimpleDateFormat fmt = new SimpleDateFormat("h:mm a");
                                SimpleDateFormat dates = new SimpleDateFormat("MM/dd");
                                //Get a list of all sessions
                                for (int i = 0; i < sessions.size(); i++) {
                                    out.print("<li>");
                                    if (locationPersist.getRoomAssignments(location.getId()).size() == 0) {
                                        out.print("<input type='radio' name='session' value=\"" + sessions.get(i).getId() + "\">");
                                    } else {
                                        out.print("<input type='radio' name='session' value=\"" + sessions.get(i).getId() + "\">");
                                        out.print("<i class='icon16-success'></i>");
                                    }
                                    out.print(dates.format(sessions.get(i).getSessionDate()) + ", " + fmt.format(sessions.get(i).getStartTime()) + ", " + sessions.get(i).getName());
                                    out.print("</li>");
                                }
                            %>
                        </ol>
                    </div>
                    <div class="largeBottomMargin"><i class='icon16-success'></i> Indicates a session already has been assigned to <%= location.getDescription() %>.</div>
                    <div class="form-actions">
                        <input id="send" type="submit" class="button button-primary" value="Assign Room"/>
                        <a id="cancel" href="../../../private/employee/admin/room.jsp">Cancel</a>
                    </div>
                </form>
            </div>
        </div>

        <%@ include file="../../../includes/footer.jsp" %> 
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <script src="../../../js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
        <script src="../../../js/libs/sniui.user-inline-help.1.2.0.min.js" type="text/javascript"></script>
        <script>
                                $().ready(function() {
                                    jQuery.expr[":"].icontains = jQuery.expr.createPseudo(function(arg) {
                                        return function(elem) {
                                            return jQuery(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0;
                                        };
                                    });
                                    $("#filter").on("keyup", function() {
                                        var text = $("#filter").val();
                                        if (text !== "") {
                                            $("#sessions li").filter(":icontains('" + text + "')").show();
                                            $("#sessions li").filter(":not(:icontains('" + text + "'))").hide();
                                        }
                                        else if (text === "") {
                                            $("#sessions li").show();
                                        }
                                    });
                                });
                                function clearFilter() {
                                    $("#filter").val("");
                                    $("#sessions li").show();
                                }
        </script>
    </body>
</html>
