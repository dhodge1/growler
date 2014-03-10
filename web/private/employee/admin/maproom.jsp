<%-- 
    Document   : maproom
    Created on : Mar 10, 2014, 3:10:55 PM
    Author     : David
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<%

%>
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
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="shortcut icon" type="image/png" href="http://growler.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <style>
            h1, h3 {
                font-weight: normal;
            }
            #refresh {
                margin-left: 12px;
                color:#0067b1;
                text-decoration: underline;
                cursor: pointer;
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
        </style>
    </head>
    <body id="growler1">
        <%
            int user = 0;
            String roomPassed = "TBD";
            if (null == session.getAttribute("id") || null == session.getAttribute("role")) {
                response.sendRedirect("../../../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
                roomPassed = (request.getParameter("roomId"));
                session.setAttribute("localID", roomPassed);
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
                    <li><a href="${pageContext.request.contextPath}/private/employee/admin/home.jsp">Home</a></li>
                    <li class='ieFix'>Map A Room</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="margin-top:0px;font-weight: normal;">Map A Room</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>To map a local room to a remote location, choose the remote location to be mapped from the dropdown menu and submit.</h3>
            </div>
            <!--<div class='row largeBottomMargin'></div>-->
            <div class="row mediumBottomMargin">
                <h2 class="bordered" style='padding-bottom:6px;'><img style="padding-bottom:0;padding-left:0;" src='${pageContext.request.contextPath}/images/Techtoberfest2013small.png'/><span style="padding-left:12px;">Assign Details</span></h2>
            </div>
            <div class="row largeBottomMargin">
                <% 
                    LocationPersistence lp4 = new LocationPersistence();
                    Location locationID = lp4.getLocationById(roomPassed);
                    ArrayList<Location> locs = lp4.getAllLocations("");
                %>
                
                <form method="post" action="${pageContext.request.contextPath}/action/processRemoteRooms.jsp">
                    <div class="form-group"><strong><% out.print(locationID.getId() + ", " + locationID.getDescription() + ", " + locationID.getBuilding());%></strong>
                    <input type="hidden" name="location" id="room" value="<%= locationID.getId() %>"/>
                    </div>
                    <div class="form-group">
                        <label class="required">Remote Room </label>
                        <select id="room" name="room">
                            <option value="0"> Select a Remote Room </option>
                            <% for (int i = 0; i < locs.size(); i++) {
                                    out.print("<option value='" + locs.get(i).getId() + "'>");
                                    out.print(locs.get(i).getDescription() + ", " + locs.get(i).getBuilding());
                                    out.print("</option>");
                                }%>
                        </select>
                        <a href="#" id="add_room">Add Another Remote Room</a>
                        <br/><span id="error_room" class="message_container">
                            <span>Please select a remote room.</span>
                        </span>
                    </div>
                    <div class="form-group extra_room">
                        <label class="required">Remote Room </label>
                        <input type="hidden" value="0" id="seconds"/>
                        <select id="room2" name="room2">
                            <option value="0"> Select a Remote Room </option>
                            <% for (int i = 0; i < locs.size(); i++) {
                                    out.print("<option value='" + locs.get(i).getId() + "'>");
                                    out.print(locs.get(i).getDescription() + ", " + locs.get(i).getBuilding());
                                    out.print("</option>");
                                }%>
                        </select>
                        <a href="#" id="add_room2">Add Another Remote Room</a>
                        <br/><span id="error_room2" class="message_container">
                            <span>Please select a remote room.</span>
                        </span>
                        <span id="error_duplicate" class="message_container">
                            <span>Please select a different remote room.</span>
                        </span>
                    </div>
                    <div class="form-group extra_room3">
                        <label class="required">Remote Room </label>
                        <input type="hidden" value="0" id="thirds"/>
                        <select id="room3" name="room3">
                            <option value="0"> Select a Remote Room </option>
                            <% for (int i = 0; i < locs.size(); i++) {
                                    out.print("<option value='" + locs.get(i).getId() + "'>");
                                    out.print(locs.get(i).getDescription() + ", " + locs.get(i).getBuilding());
                                    out.print("</option>");
                                }%>
                        </select>
                        <a href="#" id="add_room3">Add Another Remote Room</a>
                        <br/><span id="error_room3" class="message_container">
                            <span>Please select a room</span>
                        </span>
                        <span id="error_duplicate3" class="message_container">
                            <span>Please select a different room</span>
                        </span>
                    </div>
                    <div class="form-group extra_room4">
                        <label class="required">Remote Room </label>
                        <input type="hidden" value="0" id="fourths"/>
                        <select id="room4" name="room4">
                            <option value="0"> Select a Remote Room </option>
                            <% for (int i = 0; i < locs.size(); i++) {
                                    out.print("<option value='" + locs.get(i).getId() + "'>");
                                    out.print(locs.get(i).getDescription() + ", " + locs.get(i).getBuilding());
                                    out.print("</option>");
                                }%>
                        </select>
                        <a href="#" id="add_room4">Add Another Remote Room</a>
                        <br/><span id="error_room4" class="message_container">
                            <span>Please select a room</span>
                        </span>
                        <span id="error_duplicate4" class="message_container">
                            <span>Please select a different room</span>
                        </span>
                    </div>
                    <div class="form-group extra_room5">
                        <label class="required">Remote Room </label>
                        <input type="hidden" value="0" id="fifths"/>
                        <select id="room5" name="room5">
                            <option value="0"> Select a Remote Room </option>
                            <% for (int i = 0; i < locs.size(); i++) {
                                    out.print("<option value='" + locs.get(i).getId() + "'>");
                                    out.print(locs.get(i).getDescription() + ", " + locs.get(i).getBuilding());
                                    out.print("</option>");
                                }%>
                        </select>
                        <a href="#" id="add_room5">Add Another Remote Room</a>
                        <br/><span id="error_room5" class="message_container">
                            <span>Please select a room</span>
                        </span>
                        <span id="error_duplicate5" class="message_container">
                            <span>Please select a different room</span>
                        </span>
                    </div>
                    <div class="form-group extra_room6">
                        <label class="required">Remote Room </label>
                        <input type="hidden" value="0" id="sixths"/>
                        <select id="room6" name="room6">
                            <option value="0"> Select a Remote Room </option>
                            <% for (int i = 0; i < locs.size(); i++) {
                                    out.print("<option value='" + locs.get(i).getId() + "'>");
                                    out.print(locs.get(i).getDescription() + ", " + locs.get(i).getBuilding());
                                    out.print("</option>");
                                }%>
                        </select>
                        <br/><span id="error_room6" class="message_container">
                            <span>Please select a room</span>
                        </span>
                        <span id="error_duplicate6" class="message_container">
                            <span>Please select a different room</span>
                        </span>
                    </div>
                        
                    <div class="form-actions" style="padding-top: 12px;">
                        <input class="button button-primary" type="submit" id="send" value="Add Remote Room"/>
                    </div>
                        
                </form>
                
            </div>
        </div>

        <%@ include file="../../../includes/footer.jsp" %>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/sniui.dialog.1.2.0.min.js"></script>
        
        <script>
            $("#add_room").click(function() {
                $(".extra_room").show();
                $("#add_room").hide();
                $("#seconds").val("1");
            });
            $("#add_room2").click(function() {
                $(".extra_room3").show();
                $("#add_room2").hide();
                $("#thirds").val("1");
            });
            $("#add_room3").click(function() {
                $(".extra_room4").show();
                $("#add_room3").hide();
                $("#fourths").val("1");
            });
            $("#add_room4").click(function() {
                $(".extra_room5").show();
                $("#add_room4").hide();
                $("#fifths").val("1");
            });
            $("#add_room5").click(function() {
                $(".extra_room6").show();
                $("#add_room5").hide();
                $("#sixths").val("1");
            });
            
            $("#send").click(function(event) {

                $("#room").css("border", "1px solid #CCC");
                $("#room2").css("border", "1px solid #CCC");
                $("#sroom3").css("border", "1px solid #CCC");
                $("#room4").css("border", "1px solid #CCC");
                $("#room5").css("border", "1px solid #CCC");
                $("#room6").css("border", "1px solid #CCC");
                $("#error_room").hide();
                $("#error_room2").hide();
                $("#error_room3").hide();
                $("#error_room4").hide();
                $("#error_room5").hide();
                $("#error_room6").hide();
                $("#error_duplicate").hide();
                $("#error_duplicate3").hide();
                $("#error_duplicate4").hide();
                $("#error_duplicate5").hide();
                $("#error_duplicate6").hide();
                var emptyString = "";
                var str5 = $("#room").val();
                var str6 = $("#room2").val();
                var str7 = $("#room3").val();
                var str8 = $("#room4").val();
                var str9 = $("#room5").val();
                var str10 = $("#room6").val();
                
                if (str5 === "0") {
                    $("#room").css("border", "1px solid red");
                    $("#error_room").show();
                    event.preventDefault();
                }
                if ($("#seconds").val() !== "0") {
                    if (str6 === "0") {
                        $("#room2").css("border", "1px solid red");
                        $("#error_room2").show();
                        event.preventDefault();
                    }
                    if (str6 === str5) {
                        $("#room1").css("border", "1px solid red");
                        $("#room2").css("border", "1px solid red");
                        $("#error_duplicate").show();
                    }
                }
                if ($("#thirds").val() !== "0") {
                    if (str7 === "0") {
                        $("#room3").css("border", "1px solid red");
                        $("#error_room3").show();
                        event.preventDefault();
                    }
                    if (str7 === str5) {
                        $("#room1").css("border", "1px solid red");
                        $("#room3").css("border", "1px solid red");
                        $("#error_duplicate3").show();
                    }
                    if (str7 === str6) {
                        $("#room2").css("border", "1px solid red");
                        $("#room3").css("border", "1px solid red");
                        $("#error_duplicate3").show();
                    }
                }
                if ($("#fourths").val() !== "0") {
                    if (str8 === "0") {
                        $("#room4").css("border", "1px solid red");
                        $("#error_room4").show();
                        event.preventDefault();
                    }
                    if (str8 === str5) {
                        $("#room1").css("border", "1px solid red");
                        $("#room4").css("border", "1px solid red");
                        $("#error_duplicate4").show();
                    }
                    if (str8 === str6) {
                        $("#room2").css("border", "1px solid red");
                        $("#room4").css("border", "1px solid red");
                        $("#error_duplicate4").show();
                    }
                    if (str8 === str7) {
                        $("#room3").css("border", "1px solid red");
                        $("#room4").css("border", "1px solid red");
                        $("#error_duplicate4").show();
                    }
                }
                if ($("#fifths").val() !== "0") {
                    if (str9 === "0") {
                        $("#room5").css("border", "1px solid red");
                        $("#error_room5").show();
                        event.preventDefault();
                    }
                    if (str9 === str5) {
                        $("#room1").css("border", "1px solid red");
                        $("#room5").css("border", "1px solid red");
                        $("#error_duplicate5").show();
                    }
                    if (str9 === str6) {
                        $("#room2").css("border", "1px solid red");
                        $("#room5").css("border", "1px solid red");
                        $("#error_duplicate5").show();
                    }
                    if (str9 === str7) {
                        $("#room3").css("border", "1px solid red");
                        $("#room5").css("border", "1px solid red");
                        $("#error_duplicate5").show();
                    }
                    if (str9 === str8) {
                        $("#room4").css("border", "1px solid red");
                        $("#room5").css("border", "1px solid red");
                        $("#error_duplicate5").show();
                    }
                }
                if ($("#sixths").val() !== "0") {
                    if (str10 === "0") {
                        $("#room6").css("border", "1px solid red");
                        $("#error_room6").show();
                        event.preventDefault();
                    }
                    if (str10 === str5) {
                        $("#room1").css("border", "1px solid red");
                        $("#room6").css("border", "1px solid red");
                        $("#error_duplicate6").show();
                    }
                    if (str10 === str6) {
                        $("#room2").css("border", "1px solid red");
                        $("#room6").css("border", "1px solid red");
                        $("#error_duplicate6").show();
                    }
                    if (str10 === str7) {
                        $("#room3").css("border", "1px solid red");
                        $("#room6").css("border", "1px solid red");
                        $("#error_duplicate6").show();
                    }
                    if (str10 === str8) {
                        $("#room4").css("border", "1px solid red");
                        $("#room6").css("border", "1px solid red");
                        $("#error_duplicate6").show();
                    }
                    if (str10 === str9) {
                        $("#room5").css("border", "1px solid red");
                        $("#room6").css("border", "1px solid red");
                        $("#error_duplicate6").show();
                    }
                }
            });
        </script>
        
    </body>
</html>

