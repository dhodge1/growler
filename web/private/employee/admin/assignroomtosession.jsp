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
        <title>Assign Session To A Room</title><!-- Title -->
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="shortcut icon" type="image/png" href="http://growler.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
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
                margin-left: 6px;
            }
            #refresh {
                margin-left: 12px;
                color:#0067b1;
                text-decoration: underline;
                cursor: pointer;
            }
        </style>
    </head>
    <body id="growler1">
        <%
            int user = 0;
            int sessionPassed = 0;
            if (null == session.getAttribute("id") || null == session.getAttribute("role")) {
                response.sendRedirect("../../../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
                sessionPassed = Integer.parseInt(request.getParameter("session_id"));
            } catch (Exception e) {
            }
        %>

        <%@ include file="../../../includes/adminheader.jsp" %> 
        <% if (String.valueOf(session.getAttribute("role")).equals("admin")) { %>
            <jsp:include page="../../../includes/supernav.jsp" flush="true"/>
        <% } else {%>
            <jsp:include page="../../../includes/adminnav.jsp" flush="true"/>
        <% } %>
        <%--<%@ include file="../../../includes/adminnav.jsp" %>--%>
        <div class="container-fixed">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="../../../private/employee/admin/home.jsp">Home</a></li>
                    <li class='ieFix'>Assign Session To A Room</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="margin-top:0px;font-weight: normal;">Assign Session To A Room</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>To assign this session to a room, choose an available room from the list and press the <strong>Assign</strong> button.</h3>
            </div>
            <!--<div class='row largeBottomMargin'></div>-->
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='${pageContext.request.contextPath}/images/Techtoberfest2013small.png'/><span style="padding-left:12px;">Assign Details</span></h2>
            </div>
            <div class="row largeBottomMargin">
                <%
                    SessionPersistence sessionPersist = new SessionPersistence();
                    LocationPersistence locationPersist = new LocationPersistence();
                    ArrayList<Location> locations = locationPersist.getAllLocations("");
                    Session sessions = sessionPersist.getSessionByID(sessionPassed);
                %>
                <form id="action" action="../../../action/processSessionRoomAssign.jsp" method="post">
                    <div class="form-group"><strong><% out.print(sessions.getSessionDate() + ", " + sessions.getStartTime() + ", " + sessions.getName());%></strong>
                    <input type="hidden" name="sessionId" id="sessionId" value="<%= sessions.getId() %>"/>
                    </div>
                    <div class="form-group" style="margin-bottom: 6px;">
                        <span class="keywordFilter">
                            <i class="icon16-magnifySmall"></i>
                            <span class="keywordFilter-wrapper">
                                <input type="search" id="filter" value="Filter..." />
                            </span>
                            <a class="keywordFilter-clear" onclick="clearFilter();"><i class="icon16-close"></i></a>
                        </span><span class="pullRight"><a id="refresh">Refresh List</a></span></div>
                    <div class="form-group">
                        <ol id="sessions">
                            <%
                                //Get a list of all locations
                                for (int i = 0; i < locations.size(); i++) {
                                    out.print("<li>");
                                    if (!sessions.getLocation().equals(locations.get(i).getId())){
                                        out.print("<input type='radio' name='location' value=\"" + locations.get(i).getId() + "\"");
                                        out.print(">");
                                    }
                                    else {
                                        out.print("<i class='icon16-success' style='margin-left: 5px; margin-right: 5px;'></i>");
                                    }
                                    out.print(locations.get(i).getDescription() + ", " + locations.get(i).getBuilding() + ", " + locations.get(i).getCapacity());
                                    
                                    out.print("</li>");
                                }
                            %>
                        </ol>
                    </div>
                    <div class="largeBottomMargin"><i class='icon16-success'></i> Indicates a room has already has been assigned to <%= sessions.getName() %>.</div>
                    <div class="form-actions">
                        <input id="send" type="submit" class="button button-primary" value="Assign Session To Room"/>
                        <a id="cancel" href="../../../private/employee/admin/session.jsp">Cancel</a>
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
                                $("#refresh").click(function(){
                                   var sessionId = $("#sessionId").val();
                                   //console.log(sessionId);
                                   var checkRooms = $.post("../../../action/refreshAvailableSessions.jsp", {sessionId: sessionId});
                                   checkRooms.done(function(data) {
                                       $("#sessions").empty().append(data);
                                     //console.log(data);
                                   });
                                });
        </script>
    </body>
</html>
