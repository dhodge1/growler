<%-- 
    Document   : addsession
    Created on : Feb 27, 2013, 11:23:26 PM
    Author     : Justin Bauguess
    Purpose    : 
--%>
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
        <title>Add A Session</title><!-- Title -->
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="shortcut icon" type="image/png" href="../../../images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
        <style>
            .message_container {
                display: none;
                color: red;
                font-weight: bold;
            }
            .extra_speaker {
                display:none;
            }
            .extra_speaker3 {
                display: none;
            }
            .extra_speaker4 {
                display: none;
            }
            .extra_speaker5 {
                display: none;
            }
            .extra_speaker6 {
                display: none;
            }
            h3 {
                font-weight:normal;
            }
            .modals{
                display:none;
            }
            .no-close .ui-dialog-titlebar-close {
                display: none;
            }
        </style>
    </head>
    <body id="growler1">
        <%
            int user = 0;
            if (null == session.getAttribute("id") || null == session.getAttribute("role")) {
                response.sendRedirect("../../../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
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
                    <li class='ieFix'>Add A Session</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="margin-top:0px;font-weight: normal;">Add A Session</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>Please use form below to Add session details.</h3>
            </div>
            <div class="row mediumBottomMargin">
                <label><span style="color: red;">*</span>Required field</label>
            </div>
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='${pageContext.request.contextPath}/images/Techtoberfest2013small.png'/><span style="padding-left: 12px;">Session Details</span></h2>
            </div>
            <div class="row largeBottomMargin">
                <%
                    SessionPersistence sp = new SessionPersistence();
                    ArrayList<Session> sessions = sp.getAllSessionsWithKeys(" ");
                    SpeakerPersistence sk = new SpeakerPersistence();
                    ArrayList<Speaker> speakers = sk.getAllSpeakers("");
                %>
                <form method="post" action="../../../action/processSession.jsp">
                    <div class="form-group">
                        <label class="required">Session Topic </label>
                        <input id="name" size='50' name="name" type="text" data-content="Enter the name of the Session" maxlength="70"/>
                        <br/><span id="error_name" class="message_container">
                            <span>Please enter a session name</span>
                        </span>
                    </div>
                    <div class="form-group">
                        <label class="required">Session Description </label>
                        <textarea id="description" name="description" maxlength="760" rows="5" cols="50" data-content="Enter the name of the Session" ></textarea>
                        <br/><span id="error_description" class="message_container">
                            <span>Please enter a session description</span>
                        </span>
                    </div>
                    <div class="form-group">
                        <label class="required">Session speaker </label>
                        <select id="speaker" name="speaker">
                            <option value="0"> Select a Speaker </option>
                            <% for (int i = 0; i < speakers.size(); i++) {
                                    out.print("<option value='" + speakers.get(i).getId() + "'>");
                                    out.print(speakers.get(i).getFullName());
                                    out.print("</option>");
                                }%>
                        </select>
                        <a href="#" id="add_speaker">Add Another Speaker</a>
                        <br/><span id="error_speaker" class="message_container">
                            <span>Please select a speaker</span>
                        </span>
                    </div>
                    <div class="form-group extra_speaker">
                        <label class="required">Session speaker </label>
                        <input type="hidden" value="0" id="seconds"/>
                        <select id="speaker2" name="speaker2">
                            <option value="0"> Select a Speaker </option>
                            <% for (int i = 0; i < speakers.size(); i++) {
                                    out.print("<option value='" + speakers.get(i).getId() + "'>");
                                    out.print(speakers.get(i).getFullName());
                                    out.print("</option>");
                                }%>
                        </select>
                        <a href="#" id="add_speaker2">Add Another Speaker</a>
                        <br/><span id="error_speaker2" class="message_container">
                            <span>Please select a speaker</span>
                        </span>
                        <span id="error_duplicate" class="message_container">
                            <span>Please select a different speaker</span>
                        </span>
                    </div>
                    <div class="form-group extra_speaker3">
                        <label class="required">Session speaker </label>
                        <input type="hidden" value="0" id="thirds"/>
                        <select id="speaker3" name="speaker3">
                            <option value="0"> Select a Speaker </option>
                            <% for (int i = 0; i < speakers.size(); i++) {
                                    out.print("<option value='" + speakers.get(i).getId() + "'>");
                                    out.print(speakers.get(i).getFullName());
                                    out.print("</option>");
                                }%>
                        </select>
                        <a href="#" id="add_speaker3">Add Another Speaker</a>
                        <br/><span id="error_speaker3" class="message_container">
                            <span>Please select a speaker</span>
                        </span>
                        <span id="error_duplicate3" class="message_container">
                            <span>Please select a different speaker</span>
                        </span>
                    </div>
                    <div class="form-group extra_speaker4">
                        <label class="required">Session speaker </label>
                        <input type="hidden" value="0" id="fourths"/>
                        <select id="speaker4" name="speaker4">
                            <option value="0"> Select a Speaker </option>
                            <% for (int i = 0; i < speakers.size(); i++) {
                                    out.print("<option value='" + speakers.get(i).getId() + "'>");
                                    out.print(speakers.get(i).getFullName());
                                    out.print("</option>");
                                }%>
                        </select>
                        <a href="#" id="add_speaker4">Add Another Speaker</a>
                        <br/><span id="error_speaker4" class="message_container">
                            <span>Please select a speaker</span>
                        </span>
                        <span id="error_duplicate4" class="message_container">
                            <span>Please select a different speaker</span>
                        </span>
                    </div>
                    <div class="form-group extra_speaker5">
                        <label class="required">Session speaker </label>
                        <input type="hidden" value="0" id="fifths"/>
                        <select id="speaker5" name="speaker5">
                            <option value="0"> Select a Speaker </option>
                            <% for (int i = 0; i < speakers.size(); i++) {
                                    out.print("<option value='" + speakers.get(i).getId() + "'>");
                                    out.print(speakers.get(i).getFullName());
                                    out.print("</option>");
                                }%>
                        </select>
                        <a href="#" id="add_speaker5">Add Another Speaker</a>
                        <br/><span id="error_speaker5" class="message_container">
                            <span>Please select a speaker</span>
                        </span>
                        <span id="error_duplicate5" class="message_container">
                            <span>Please select a different speaker</span>
                        </span>
                    </div>
                    <div class="form-group extra_speaker6">
                        <label class="required">Session speaker </label>
                        <input type="hidden" value="0" id="sixths"/>
                        <select id="speaker6" name="speaker6">
                            <option value="0"> Select a Speaker </option>
                            <% for (int i = 0; i < speakers.size(); i++) {
                                    out.print("<option value='" + speakers.get(i).getId() + "'>");
                                    out.print(speakers.get(i).getFullName());
                                    out.print("</option>");
                                }%>
                        </select>
                        <br/><span id="error_speaker6" class="message_container">
                            <span>Please select a speaker</span>
                        </span>
                        <span id="error_duplicate6" class="message_container">
                            <span>Please select a different speaker</span>
                        </span>
                    </div>    
                    <div class="form-group">
                        <label class="required">Select a session date </label>
                        <input name="date" id="datepicker" type="text" data-content="Enter a date for the Session"/>
                        <br/><span id="error_date" class="message_container">
                            <span>Please enter a date</span>
                        </span>
                    </div>
                    <div class="form-group">
                        <label class="required">Select a session time range </label>
                        <select id="time" name="time">
                            <option value="null"> - No Time - </option>
                            <option value="08:00:00a">08:00 am - 08:25 am</option>
                            <option value="08:00:00b">08:00 am - 08:50 am</option>
                            <option value="08:30:00a">08:30 am - 08:55 am</option>
                            <option value="08:30:00b">08:30 am - 09:20 am</option>
                            <option value="09:00:00a">09:00 am - 09:25 am</option>
                            <option value="09:00:00b">09:00 am - 09:50 am</option>
                            <option value="09:30:00a">09:30 am - 09:55 am</option>
                            <option value="09:30:00b">09:30 am - 10:20 am</option>
                            <option value="10:00:00a">10:00 am - 10:25 am</option>
                            <option value="10:00:00b">10:00 am - 10:50 am</option>
                            <option value="10:30:00a">10:30 am - 10:55 am</option>
                            <option value="10:30:00b">10:30 am - 11:20 am</option>
                            <option value="11:00:00a">11:00 am - 11:25 am</option>
                            <option value="11:00:00b">11:00 am - 11:50 am</option>
                            <option value="11:30:00a">11:30 am - 11:55 am</option>
                            <option value="11:30:00b">11:30 am - 12:20 pm</option>
                            <option value="12:00:00a">12:00 pm - 12:25 pm</option>
                            <option value="12:00:00b">12:00 pm - 12:50 pm</option>
                            <option value="12:30:00a">12:30 pm - 12:55 pm</option>
                            <option value="12:30:00b">12:30 pm - 01:20 pm</option>
                            <option value="13:00:00a">01:00 pm - 01:25 pm</option>
                            <option value="13:00:00b">01:00 pm - 01:50 pm</option>
                            <option value="13:30:00a">01:30 pm - 01:55 pm</option>
                            <option value="13:30:00b">01:30 pm - 02:20 pm</option>
                            <option value="14:00:00a">02:00 pm - 02:25 pm</option>
                            <option value="14:00:00b">02:00 pm - 02:50 pm</option>
                            <option value="14:30:00a">02:30 pm - 02:55 pm</option>
                            <option value="14:30:00b">02:30 pm - 03:20 pm</option>
                            <option value="15:00:00a">03:00 pm - 03:25 pm</option>
                            <option value="15:00:00b">03:00 pm - 03:50 pm</option>
                            <option value="15:30:00a">03:30 pm - 03:55 pm</option>
                            <option value="15:30:00b">03:30 pm - 04:20 pm</option>
                            <option value="16:00:00a">04:00 pm - 04:25 pm</option>
                            <option value="16:00:00b">04:00 pm - 04:50 pm</option>
                            <option value="16:30:00a">04:30 pm - 04:55 pm</option>
                            <option value="16:30:00b">04:30 pm - 05:20 pm</option>
                            <option value="17:00:00a">05:00 pm - 05:25 pm</option>
                            <option value="17:00:00b">05:00 pm - 05:50 pm</option>
                            <option value="17:30:00a">05:30 pm - 05:55 pm</option>
                            <option value="17:30:00b">05:30 pm - 06:20 pm</option>
                        </select>
                        <br/><span id="error_time" class="message_container">
                            <span>Please enter a time range</span>
                        </span>
                    </div>
                    <div class="form-actions" style="padding-top: 12px;">
                        <input class="button button-primary" type="submit" id="send" value="Add Session"/>
                    </div>
                </form>
            </div>
        </div>
                        <div id="modalWarning" title="Duplicate Session Alert" class="modals">
            <p>The following sessions already share the same day and time.  No more than 2 sessions can be scheduled for the same day and time.</p>
            <div id="dupSession"></div><br/>
        </div>
        <%@ include file="../../../includes/footer.jsp" %>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/sniui.dialog.1.2.0.min.js"></script>
        <script>
            $(function() {
                $("#datepicker").datepicker({
                    dateFormat: 'yy-mm-dd',
                    minDate: new Date(2013, 9, 10),
                    maxDate: new Date(2013, 9, 11)
                });
                $(".modals").dialog({autoOpen: false, dialogClass: "no-close",width: 400,
                    buttons: {
                        'ok': {
                            'class': 'button button-primary',
                            click: function() {
                                $(this).dialog('close');
                            },
                            text: 'Ok'
                        }}
                });
            });
        </script>
        <script>
            $("#add_speaker").click(function() {
                $(".extra_speaker").show();
                $("#add_speaker").hide();
                $("#seconds").val("1");
            });
            $("#add_speaker2").click(function() {
                $(".extra_speaker3").show();
                $("#add_speaker2").hide();
                $("#thirds").val("1");
            });
            $("#add_speaker3").click(function() {
                $(".extra_speaker4").show();
                $("#add_speaker3").hide();
                $("#fourths").val("1");
            });
            $("#add_speaker4").click(function() {
                $(".extra_speaker5").show();
                $("#add_speaker4").hide();
                $("#fifths").val("1");
            });
            $("#add_speaker5").click(function() {
                $(".extra_speaker6").show();
                $("#add_speaker5").hide();
                $("#sixths").val("1");
            });
            $("#send").click(function(event) {

                $("#name").css("border", "1px solid #CCC");
                $("#description").css("border", "1px solid #CCC");
                $("#speaker").css("border", "1px solid #CCC");
                $("#speaker2").css("border", "1px solid #CCC");
                $("#speaker3").css("border", "1px solid #CCC");
                $("#speaker4").css("border", "1px solid #CCC");
                $("#speaker5").css("border", "1px solid #CCC");
                $("#speaker6").css("border", "1px solid #CCC");
                $("#datepicker").css("border", "1px solid #CCC");
                $("#time").css("border", "1px solid #CCC");
                $("#error_name").hide();
                $("#error_description").hide();
                $("#error_speaker").hide();
                $("#error_speaker2").hide();
                $("#error_speaker3").hide();
                $("#error_speaker4").hide();
                $("#error_speaker5").hide();
                $("#error_speaker6").hide();
                $("#error_duplicate").hide();
                $("#error_duplicate3").hide();
                $("#error_duplicate4").hide();
                $("#error_duplicate5").hide();
                $("#error_duplicate6").hide();
                $("#error_date").hide();
                $("#error_time").hide();
                var emptyString = "";
                var str1 = $.trim($("#name").val());
                var str2 = $.trim($("#description").val());
                var str3 = $("#datepicker").val();
                var str4 = $("#time").val();
                var str5 = $("#speaker").val();
                var str6 = $("#speaker2").val();
                var str7 = $("#speaker3").val();
                var str8 = $("#speaker4").val();
                var str9 = $("#speaker5").val();
                var str10 = $("#speaker6").val();
                if ((str1) === emptyString) {
                    $("#name").css("border", "1px solid red");
                    $("#error_name").show();
                    event.preventDefault();
                }
                if ((str2) === emptyString) {
                    $("#description").css("border", "1px solid red");
                    $("#error_description").show();
                    event.preventDefault();
                }
                if (str3 === emptyString) {
                    $("#datepicker").css("border", "1px solid red");
                    $("#error_date").show();
                    event.preventDefault();
                }
                if (str4 === "null") {
                    $("#time").css("border", "1px solid red");
                    $("#error_time").show();
                    event.preventDefault();
                }
                if (str5 === "0") {
                    $("#speaker").css("border", "1px solid red");
                    $("#error_speaker").show();
                    event.preventDefault();
                }
                if ($("#seconds").val() !== "0") {
                    if (str6 === "0") {
                        $("#speaker2").css("border", "1px solid red");
                        $("#error_speaker2").show();
                        event.preventDefault();
                    }
                    if (str6 === str5) {
                        $("#speaker1").css("border", "1px solid red");
                        $("#speaker2").css("border", "1px solid red");
                        $("#error_duplicate").show();
                    }
                }
                if ($("#thirds").val() !== "0") {
                    if (str7 === "0") {
                        $("#speaker3").css("border", "1px solid red");
                        $("#error_speaker3").show();
                        event.preventDefault();
                    }
                    if (str7 === str5) {
                        $("#speaker1").css("border", "1px solid red");
                        $("#speaker3").css("border", "1px solid red");
                        $("#error_duplicate3").show();
                    }
                    if (str7 === str6) {
                        $("#speaker2").css("border", "1px solid red");
                        $("#speaker3").css("border", "1px solid red");
                        $("#error_duplicate3").show();
                    }
                }
                if ($("#fourths").val() !== "0") {
                    if (str8 === "0") {
                        $("#speaker4").css("border", "1px solid red");
                        $("#error_speaker4").show();
                        event.preventDefault();
                    }
                    if (str8 === str5) {
                        $("#speaker1").css("border", "1px solid red");
                        $("#speaker4").css("border", "1px solid red");
                        $("#error_duplicate4").show();
                    }
                    if (str8 === str6) {
                        $("#speaker2").css("border", "1px solid red");
                        $("#speaker4").css("border", "1px solid red");
                        $("#error_duplicate4").show();
                    }
                    if (str8 === str7) {
                        $("#speaker3").css("border", "1px solid red");
                        $("#speaker4").css("border", "1px solid red");
                        $("#error_duplicate4").show();
                    }
                }
                if ($("#fifths").val() !== "0") {
                    if (str9 === "0") {
                        $("#speaker5").css("border", "1px solid red");
                        $("#error_speaker5").show();
                        event.preventDefault();
                    }
                    if (str9 === str5) {
                        $("#speaker1").css("border", "1px solid red");
                        $("#speaker5").css("border", "1px solid red");
                        $("#error_duplicate5").show();
                    }
                    if (str9 === str6) {
                        $("#speaker2").css("border", "1px solid red");
                        $("#speaker5").css("border", "1px solid red");
                        $("#error_duplicate5").show();
                    }
                    if (str9 === str7) {
                        $("#speaker3").css("border", "1px solid red");
                        $("#speaker5").css("border", "1px solid red");
                        $("#error_duplicate5").show();
                    }
                    if (str9 === str8) {
                        $("#speaker4").css("border", "1px solid red");
                        $("#speaker5").css("border", "1px solid red");
                        $("#error_duplicate5").show();
                    }
                }
                if ($("#sixths").val() !== "0") {
                    if (str10 === "0") {
                        $("#speaker6").css("border", "1px solid red");
                        $("#error_speaker6").show();
                        event.preventDefault();
                    }
                    if (str10 === str5) {
                        $("#speaker1").css("border", "1px solid red");
                        $("#speaker6").css("border", "1px solid red");
                        $("#error_duplicate6").show();
                    }
                    if (str10 === str6) {
                        $("#speaker2").css("border", "1px solid red");
                        $("#speaker6").css("border", "1px solid red");
                        $("#error_duplicate6").show();
                    }
                    if (str10 === str7) {
                        $("#speaker3").css("border", "1px solid red");
                        $("#speaker6").css("border", "1px solid red");
                        $("#error_duplicate6").show();
                    }
                    if (str10 === str8) {
                        $("#speaker4").css("border", "1px solid red");
                        $("#speaker6").css("border", "1px solid red");
                        $("#error_duplicate6").show();
                    }
                    if (str10 === str9) {
                        $("#speaker5").css("border", "1px solid red");
                        $("#speaker6").css("border", "1px solid red");
                        $("#error_duplicate6").show();
                    }
                }
            });
            $("#datepicker").change(function() {
                var date = $("#datepicker").val();
                var availTimes = $.post("../../../action/changeAvailableTimes.jsp", {date: date});
                availTimes.done(function(data){
                    $("#time").empty().append(data);
                    //console.log(data);
                })
            });
            $("#datepicker").change(function() {
                if ($("#time").val() !== "null") {
                    var sessionId1 = $("#sessionId").val();
                    var date = $("#datepicker").val();
                    //console.log(date);
                    var time = $("#time").val();
                    //console.log(time);
                    time = time.substring(0, 8);
                    //console.log(time);
                    var checkDups = $.post("../../../action/checkDuplicateSession.jsp", {ses1: sessionId1, date: date, time: time});
                    checkDups.done(function(data) {
                      //  console.log(data);
                        if (data.substring(0,2) !== "no"){
                            $("#dupSession").empty().append(data);
                            $("#modalWarning").dialog('open');
                        }
                    //    var result = $(data).find("#content");
                    //    if (result === "duplicate") {
                    //        var session1 = $(data).find("#session1");
                    //        var session2 = $(data).find("#session2");
                    //        $("#dupSession").empty().append();
                    //        $("#dupSession2").empty().append();
                    //        $("#modalWarning").dialog('open');
                    //    }
                    })
                }
            });
            $("#time").change(function() {
                if ($("#date").val() !== "") {
                    var sessionId1 = $("#sessionId").val();
                    var date = $("#datepicker").val();
                  //  console.log(date);
                    var time = $("#time").val();
                  //  console.log(time);
                    time = time.substring(0, 8);
                  //  console.log(time);
                    var checkDups = $.post("../../../action/checkDuplicateSession.jsp", {ses1: sessionId1, date: date, time: time});
                    checkDups.done(function(data) {
                   //     console.log(data);
                        if (data.substring(0,2) !== "no"){
                            $("#time").val("null");
                            $("#dupSession").empty().append(data);
                            $("#modalWarning").dialog('open');
                        }
                     //   if (result === "duplicate") {
                     //       var session1 = $(data).find("#session1");
                     //       var session2 = $(data).find("#session2");
                     //       $("#dupSession").empty().append();
                     //       $("#dupSession2").empty().append();
                     //       $("#modalWarning").dialog('open');
                     //   }
                    })
                }
            });
        </script>
    </body>
</html>