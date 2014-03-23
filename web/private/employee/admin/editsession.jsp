<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> 
<html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/sniui.dialog.1.2.0.min.js"></script>
        <title>Edit Session</title>
        <style>
            .message_container {
                display: none;
                color: red;
                font-weight: bold;
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
            .extra_speaker {
                display: none;
            }
        </style>
    </head>
    <body id="growler1">
        <%
            int user = 0;
            if (null == session.getAttribute("id") || null == session.getAttribute("role")) {
                response.sendRedirect("http://sniforms.scrippsnetworks.com/siteminderagent/sniforms/logout.html");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
        %>
        <%
            int sessionId = (Integer.parseInt(request.getParameter("id")));
            SessionPersistence persist = new SessionPersistence();
            Session s = persist.getSessionByID(sessionId);
            SpeakerPersistence sp = new SpeakerPersistence();
            ArrayList<Speaker> speakers = sp.getAllSpeakers(" ");
            ArrayList<Speaker> assigned = sp.getSpeakersBySession(sessionId);
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
                    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li class='ieFix'>Edit Session</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="margin-top:0px;font-weight: normal;">Edit Session</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>Please use form below to edit session details.</h3>
            </div>
            <div class="row mediumBottomMargin">
                <label><span style="color: red;">*</span>Required field</label>
            </div>
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='${pageContext.request.contextPath}/images/Techtoberfest2013small.png'/><span style="padding-left: 12px;">Speaker Details</span></h2>
            </div>
            <div class="row largeBottomMargin">
                <form method="post" action="${pageContext.request.contextPath}/action/processSessionEdit.jsp">
                    <div class="form-group">
                        <input name="sessionId" id="sessionId" type="hidden" value="<% out.print(s.getId());%>" />
                        <label class="required">Session topic</label>
                        <input required="required" name="name" class="input-xlarge" type="text" id="name" data-content="Please enter no more than 30 characters" maxlength="30" <% out.print("value='" + s.getName() + "'");%> />
                        <br/><span id="error_name" class="message_container">
                            <span>Please enter a session name</span>
                        </span>
                    </div>
                    <div class="form-group">
                        <label class="required">Session description</label>
                        <textarea required="required" name="description" id="description" maxlength="760" cols="50" rows="5"><% out.print(s.getDescription());%></textarea>
                        <br/><span id="error_description" class="message_container">
                            <span>Please enter a session description</span>
                        </span>
                    </div>
                        <% for (int i =0; i < assigned.size(); i++) {
                            out.print("<input type='hidden' id='assigned" + i + "' value='" + assigned.get(i).getId() + "'/>");
                        }%>
                    <div class="form-group">
                        <label class="required">Session speaker</label>
                        <select name="speaker" id="speaker">
                            <option value="0"> No Speaker Available </option>
                            <% for (int i = 0; i < speakers.size(); i++) {
                                    out.print("<option value ='" + speakers.get(i).getId() + "' ");
                                    if (sp.isSpeakerInSession(speakers.get(i).getId(), sessionId)) {
                                        out.print(" selected ");
                                    }
                                    out.print(">");
                                    out.print(speakers.get(i).getFullName());
                                    out.print("</option>");
                                }
                            %>
                        </select> <% if (assigned.size() < 2) {%> <a href="#" id="add_speaker">Add Another Speaker</a> <% }//end if %>
                        <br/><span id="error_speaker" class="message_container">
                            <span>Please select a speaker</span>
                        </span>
                    </div>
                    <input type="hidden" id="spkrcount" value="<%= assigned.size()%>"/>
                    <div class="form-group extra_speaker">
                        <label class="required">Session speaker</label>
                        <input type="hidden" value="0" id="seconds"/>
                        <select name="speaker2" id="speaker2">
                            <option value="0"> No Speaker Available </option>
                            <%
                                for (int i = 0; i < speakers.size(); i++) {
                                    out.print("<option value ='" + speakers.get(i).getId() + "' ");
                                    if (sp.isSpeakerInSession(speakers.get(i).getId(), s.getId())) {
                                        out.print(" selected ");
                                    }
                                    out.print(">");
                                    out.print(speakers.get(i).getFullName());
                                    out.print("</option>");
                                }%>
                        </select>
                        <br/><span id="error_speaker2" class="message_container">
                            <span>Please select a speaker</span>
                        </span>
                        <span id="error_duplicate" class="message_container">
                            <span>Please select a different speaker</span>
                        </span>
                    </div>
                    <div class="form-group">
                        <label class="required">Select a session date</label>
                        <input name="date" id="datepicker" type="text" <% out.print("value='" + s.getSessionDate() + "'");%>/>
                        <br/><span id="error_date" class="message_container">
                            <span>Please enter a date</span>
                        </span>
                    </div>
                    <div class="form-group" style="margin-bottom: 24px;">
                        <label class="required">Select a session time range</label>
                        <select id="time" name="time">
                            <option value="null"> - No Time - </option>
                            <option value="08:00:00a" <% if (String.valueOf(s.getStartTime()).equals("08:00:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>08:00 am - 08:25 am</option>
                            <option value="08:00:00b" <% if (String.valueOf(s.getStartTime()).equals("08:00:00") && String.valueOf(s.getDuration()).equals("00:50:00")) {
                                    out.print(" selected ");
                                }%>>08:00 am - 08:50 am</option>
                            <option value="08:30:00a" <% if (String.valueOf(s.getStartTime()).equals("08:30:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>08:30 am - 08:55 am</option>
                            <option value="08:30:00b" <% if (String.valueOf(s.getStartTime()).equals("08:30:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>08:30 am - 09:20 am</option>
                            <option value="09:00:00a" <% if (String.valueOf(s.getStartTime()).equals("09:00:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>09:00 am - 09:25 am</option>
                            <option value="09:00:00b" <% if (String.valueOf(s.getStartTime()).equals("09:00:00") && String.valueOf(s.getDuration()).equals("00:50:00")) {
                                    out.print(" selected ");
                                }%>>09:00 am - 09:50 am</option>
                            <option value="09:30:00a" <% if (String.valueOf(s.getStartTime()).equals("09:30:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>09:30 am - 9:55 am</option>
                            <option value="09:30:00b" <% if (String.valueOf(s.getStartTime()).equals("09:30:00") && String.valueOf(s.getDuration()).equals("00:50:00")) {
                                    out.print(" selected ");
                                }%>>09:30 am - 10:20 am</option>
                            <option value="10:00:00a" <% if (String.valueOf(s.getStartTime()).equals("10:00:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>10:00 am - 10:25 am</option>
                            <option value="10:00:00b" <% if (String.valueOf(s.getStartTime()).equals("10:00:00") && String.valueOf(s.getDuration()).equals("00:50:00")) {
                                    out.print(" selected ");
                                }%>>10:00 am - 10:50 am</option>
                            <option value="10:30:00a" <% if (String.valueOf(s.getStartTime()).equals("10:30:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>10:30 am - 10:55 am</option>
                            <option value="10:30:00b" <% if (String.valueOf(s.getStartTime()).equals("10:30:00") && String.valueOf(s.getDuration()).equals("00:50:00")) {
                                    out.print(" selected ");
                                }%>>10:30 am - 11:20 am</option>
                            <option value="11:00:00a" <% if (String.valueOf(s.getStartTime()).equals("11:00:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>11:00 am - 11:25 am</option>
                            <option value="11:00:00b" <% if (String.valueOf(s.getStartTime()).equals("11:00:00") && String.valueOf(s.getDuration()).equals("00:50:00")) {
                                    out.print(" selected ");
                                }%>>11:00 am - 11:50 am</option>
                            <option value="11:30:00a" <% if (String.valueOf(s.getStartTime()).equals("11:30:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>11:30 am - 11:55 am</option>
                            <option value="11:30:00b" <% if (String.valueOf(s.getStartTime()).equals("11:30:00") && String.valueOf(s.getDuration()).equals("00:50:00")) {
                                    out.print(" selected ");
                                }%>>11:30 am - 12:20 pm</option>
                            <option value="12:00:00a" <% if (String.valueOf(s.getStartTime()).equals("12:00:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>12:00 pm - 12:25 pm</option>
                            <option value="12:00:00b" <% if (String.valueOf(s.getStartTime()).equals("12:00:00") && String.valueOf(s.getDuration()).equals("00:50:00")) {
                                    out.print(" selected ");
                                }%>>12:00 pm - 12:50 pm</option>
                            <option value="12:30:00a" <% if (String.valueOf(s.getStartTime()).equals("12:30:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>12:30 pm - 12:55 pm</option>
                            <option value="12:30:00b" <% if (String.valueOf(s.getStartTime()).equals("12:30:00") && String.valueOf(s.getDuration()).equals("00:50:00")) {
                                    out.print(" selected ");
                                }%>>12:30 pm - 01:20 pm</option>
                            <option value="13:00:00a" <% if (String.valueOf(s.getStartTime()).equals("13:00:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>01:00 pm - 01:25 pm</option>
                            <option value="13:00:00b" <% if (String.valueOf(s.getStartTime()).equals("13:00:00") && String.valueOf(s.getDuration()).equals("00:50:00")) {
                                    out.print(" selected ");
                                }%>>01:00 pm - 01:50 pm</option>
                            <option value="13:30:00a" <% if (String.valueOf(s.getStartTime()).equals("13:30:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>01:30 pm - 01:55 pm</option>
                            <option value="13:30:00b" <% if (String.valueOf(s.getStartTime()).equals("13:30:00") && String.valueOf(s.getDuration()).equals("00:50:00")) {
                                    out.print(" selected ");
                                }%>>01:30 pm - 02:20 pm</option>
                            <option value="14:00:00a" <% if (String.valueOf(s.getStartTime()).equals("14:00:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>02:00 pm - 02:25 pm</option>
                            <option value="14:00:00b" <% if (String.valueOf(s.getStartTime()).equals("14:00:00") && String.valueOf(s.getDuration()).equals("00:50:00")) {
                                    out.print(" selected ");
                                }%>>02:00 pm - 02:50 pm</option>
                            <option value="14:30:00a" <% if (String.valueOf(s.getStartTime()).equals("14:30:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>02:30 pm - 02:55 pm</option>
                            <option value="14:30:00b" <% if (String.valueOf(s.getStartTime()).equals("14:30:00") && String.valueOf(s.getDuration()).equals("00:50:00")) {
                                    out.print(" selected ");
                                }%>>02:30 pm - 03:20 pm</option>
                            <option value="15:00:00a" <% if (String.valueOf(s.getStartTime()).equals("15:00:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>03:00 pm - 03:25 pm</option>
                            <option value="15:00:00b" <% if (String.valueOf(s.getStartTime()).equals("15:00:00") && String.valueOf(s.getDuration()).equals("00:50:00")) {
                                    out.print(" selected ");
                                }%>>03:00 pm - 03:50 pm</option>
                            <option value="15:30:00a" <% if (String.valueOf(s.getStartTime()).equals("15:30:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>03:30 pm - 03:55 pm</option>
                            <option value="15:30:00b" <% if (String.valueOf(s.getStartTime()).equals("15:30:00") && String.valueOf(s.getDuration()).equals("00:50:00")) {
                                    out.print(" selected ");
                                }%>>03:30 pm - 04:20 pm</option>
                            <option value="16:00:00a" <% if (String.valueOf(s.getStartTime()).equals("16:00:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>04:00 pm - 04:25 pm</option>
                            <option value="16:00:00b" <% if (String.valueOf(s.getStartTime()).equals("16:00:00") && String.valueOf(s.getDuration()).equals("00:50:00")) {
                                    out.print(" selected ");
                                }%>>04:00 pm - 04:50 pm</option>
                            <option value="16:30:00a" <% if (String.valueOf(s.getStartTime()).equals("16:30:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>04:30 pm - 04:55 pm</option>
                            <option value="16:30:00b" <% if (String.valueOf(s.getStartTime()).equals("16:30:00") && String.valueOf(s.getDuration()).equals("00:50:00")) {
                                    out.print(" selected ");
                                }%>>04:30 pm - 05:20 pm</option>
                            <option value="17:00:00a" <% if (String.valueOf(s.getStartTime()).equals("17:00:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>05:00 pm - 05:25 pm</option>
                            <option value="17:00:00b" <% if (String.valueOf(s.getStartTime()).equals("17:00:00") && String.valueOf(s.getDuration()).equals("00:50:00")) {
                                    out.print(" selected ");
                                }%>>05:00 pm - 05:50 pm</option>
                            <option value="17:30:00a" <% if (String.valueOf(s.getStartTime()).equals("17:30:00") && String.valueOf(s.getDuration()).equals("00:25:00")) {
                                    out.print(" selected ");
                                }%>>05:30 pm - 05:55 pm</option>
                            <option value="17:30:00b" <% if (String.valueOf(s.getStartTime()).equals("17:30:00") && String.valueOf(s.getDuration()).equals("00:50:00")) {
                                    out.print(" selected ");
                                }%>>05:30 pm - 06:20 pm</option>
                        </select>
                        <br/><span id="error_time" class="message_container">
                            <span>Please enter a time range</span>
                        </span>
                    </div>
                    <div class="form-actions">
                        <input id="send" type="submit" value="Save Changes" class="button button-primary"/>
                        <a href="${pageContext.request.contextPath}/private/employee/admin/session.jsp">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
        <div id="modalWarning" title="Duplicate Session Alert" class="modals">
            <p>The following sessions already share the same day and time.  No more than 2 sessions can be scheduled for the same day and time.</p>
            <div id="dupSession"></div><br/>
        </div>
        <%@ include file="../../../includes/footer.jsp" %> 
        <script>
            $(function() {
                $("#datepicker").datepicker({
                    dateFormat: 'yy-mm-dd',
                    minDate: new Date(2013, 9, 10),
                    maxDate: new Date(2013, 9, 11)
                });
                $(".modals").dialog({autoOpen: false, dialogClass: "no-close", width: 400,
                    buttons: {
                        'ok': {
                            'class': 'button button-primary',
                            click: function() {
                                $(this).dialog('close');
                            },
                            text: 'Ok'
                        }}
                });
                if ($("#spkrcount").val() < 2) {
                    $(".extra_speaker").hide();
                }
                else {
                    $(".extra_speaker").show();
                }
                $("#speaker").val($("#assigned0").val());
                $("#speaker2").val($("#assigned1").val());
                $.trim($("#description"));
            });
        </script>
        <script>
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
                     //   console.log(data);
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
                    //console.log(date);
                    var time = $("#time").val();
                   // console.log(time);
                    time = time.substring(0, 8);
                   // console.log(time);
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
            $("#add_speaker").click(function() {
                $(".extra_speaker").show();
                $("#add_speaker").hide();
                $("#seconds").val("1");
            });
            $("#send").click(function(event) {

                $("#name").css("border", "1px solid #CCC");
                $("#description").css("border", "1px solid #CCC");
                $("#speaker").css("border", "1px solid #CCC");
                $("#speaker2").css("border", "1px solid #CCC");
                $("#datepicker").css("border", "1px solid #CCC");
                $("#time").css("border", "1px solid #CCC");
                $("#error_name").hide();
                $("#error_description").hide();
                $("#error_speaker").hide();
                $("#error_speaker2").hide();
                $("#error_duplicate").hide();
                $("#error_date").hide();
                $("#error_time").hide();
                var emptyString = "";
                var str1 = $.trim($("#name").val());
                var str2 = $.trim($("#description").val());
                var str3 = $("#datepicker").val();
                var str4 = $("#time").val();
                var str5 = $("#speaker").val();
                var str6 = $("#speaker2").val();
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
                        $("#speaker").css("border", "1px solid red");
                        $("#speaker2").css("border", "1px solid red");
                        $("#error_duplicate").show();
                        event.preventDefault();
                    }
                }
            });
        </script>
    </body>
</html>