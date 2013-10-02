<%-- 
    Document   : surveys
    Created on : Jul 23, 2013, 10:27:06 AM
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
<!--[if gt IE 8]><!--> 
<html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Techtoberfest: Session Feedback</title><!-- Title -->
        <link rel="shortcut icon" type="image/png" href="http://growler.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <script>
            $(document).ready(function() {
                $('td').filter('.2013-10-10morning').show();
                $('td').filter('.2013-10-10afternoon').hide();
                $('td').filter('.2013-10-11morning').hide();
                $('td').filter('.2013-10-11afternoon').hide();
                $("#survey").hide();
                $("#code").hide();
                $("#confirm").hide();
                $("#date").change(function() {
                    if ($("#date").val() === "1") {
                        $('td').filter('.2013-10-10morning').show();
                        $('td').filter('.2013-10-10afternoon').hide();
                        $('td').filter('.2013-10-11morning').hide();
                        $('td').filter('.2013-10-11afternoon').hide();
                    }
                    else if ($("#date").val() === "2") {
                        $('td').filter('.2013-10-10morning').hide();
                        $('td').filter('.2013-10-10afternoon').show();
                        $('td').filter('.2013-10-11morning').hide();
                        $('td').filter('.2013-10-11afternoon').hide();
                    }
                    else if ($("#date").val() === "3") {
                        $('td').filter('.2013-10-10morning').hide();
                        $('td').filter('.2013-10-10afternoon').hide();
                        $('td').filter('.2013-10-11morning').show();
                        $('td').filter('.2013-10-11afternoon').hide();
                    }
                    else if ($("#date").val() === "4") {
                        $('td').filter('.2013-10-10morning').hide();
                        $('td').filter('.2013-10-10afternoon').hide();
                        $('td').filter('.2013-10-11morning').hide();
                        $('td').filter('.2013-10-11afternoon').show();
                    }
                });
                $("#keyvalidate").click(function() {
                   var key = $("#key").val();
                   var session = $("#session").val();
                   var validateKey = $.post('../../action/validateKey.jsp', {key: key, sessionId: session});
                   validateKey.done(function(data) {
                       console.log(data);
                       
                       if (data.substring(0,2) === "ok"){
                           $("#keyError").hide();
                       } else {
                           $("#keyError").show();
                       }
                   });
                });
                $("#progress1").click(function() {
                    changeMouseOnIndicators();
                    if (parseInt($("#step").val()) !== 4) {
                        for (var i = 0; i < 4; i++) {
                            $('#progress' + i).removeClass("current");
                            $('#progress' + i).removeClass("completed");
                        }
                        $('#progress1').addClass("current");
                        $("#survey").hide();
                        $("#code").hide();
                        $("#confirm").hide();
                        $("#errors").hide();
                        $(".errorsquestion").hide();
                        $("#dateselector").show();
                        $("#table").show();
                        $("#step").val(1);
                    }
                });
                $("#progress2").click(function() {
                    changeMouseOnIndicators();
                    $("#progress1").css("cursor", "pointer");
                    if (parseInt($("#step").val()) > 2 && parseInt($("#step").val()) !== 4) {
                        for (var i = 2; i < 4; i++) {
                            $('#progress' + i).removeClass("current");
                            $('#progress' + i).removeClass("completed");
                        }
                        $('#progress2').addClass("current");
                        $("#survey").show();
                        $("#code").hide();
                        $("#confirm").hide();
                        $("#errors").hide();
                        $(".errorsquestion").hide();
                        $("#dateselector").hide();
                        $("#table").hide();
                        $("#step").val(2);
                    }
                });

                function changeMouseOnIndicators() {
                    for (var i = 1; i < 4; i++) {
                        $("#progress" + i).css("cursor", "default");
                    }
                }

                function showErrors(page) {
                    if (page === 1) {
                        $("#errors").html("<span>Please select a session.</span>");
                        $("#errors").show();
                        $(".errorsquestion").hide();
                    }
                    if (page === 2) {
                        $("#errors").html("<span>Please answer all questions.</span>");
                        $(".errorsquestion").hide();
                        if (!($("input[name='q1']:checked").length)) {
                            $("#error1").html("<span>This field is required.</span>").show();
                        }
                        if (!($("input[name='q2']:checked").length)) {
                            $("#error2").html("<span>This field is required.</span>").show();
                        }
                        if (!($("input[name='q3']:checked").length)) {
                            $("#error3").html("<span>This field is required.</span>").show();
                        }
                        if ((!$("input[name='q4']:checked").length)) {
                            $("#error4").html("<span>This field is required.</span>").show();
                        }
                        $("#errors").show();
                    }
                }

                $("#continue").click(function() {
                    var step = parseInt($("#step").val());
                    $("#errors").hide();
                    $(".errorsquestion").hide();
                    if (step === 1) {
                        changeMouseOnIndicators();
                        $("#progress1").css("cursor", "pointer");
                        $("#errors").hide();
                        if ($("input[name='survey']:checked").length) {
                            $("#session").val($("input[name='survey']:checked").val());
                            $("#dateselector").hide();
                            $("#table").hide();
                            $("#step").val(2);
                            $("#survey").show();
                            $("#progress1").removeClass("current");
                            $("#progress1").addClass("completed");
                            $("#progress2").addClass("current");
                        }
                        else {
                            showErrors(1);
                        }
                    }
                    if (step === 2) {
                        changeMouseOnIndicators();
                        $("#errors").hide();
                        $("#progress1").css("cursor", "pointer");
                        $("#progress2").css("cursor", "pointer");
                        if ($("input[name='q1']:checked").length && $("input[name='q2']:checked").length && $("input[name='q3']:checked").length && $("input[name='q4']:checked").length) {
                            $("#q1").val($("input[name='q1']:checked").val());
                            $("#q2").val($("input[name='q2']:checked").val());
                            $("#q3").val($("input[name='q3']:checked").val());
                            $("#q4").val($("input[name='q4']:checked").val());
                            $("#comment").val($("#commentbox").val());
                            $("#survey").hide();
                            $("#code").show();
                            $("#step").val(3);
                            $("#progress2").removeClass("current");
                            $("#progress2").addClass("completed");
                            $("#progress3").addClass("current");
                        }
                        else {
                            showErrors(2);
                        }
                    }
                    if (step === 3) {
                        changeMouseOnIndicators();
                        var user = $("#userid").val();
                        var session = $("#session").val();
                        var q1 = $("#q1").val();
                        var q2 = $("#q2").val();
                        var q3 = $("#q3").val();
                        var q4 = $("#q4").val();
                        var comments = $("#comment").val();
                        var key = $("#key").val();
                        $.post("../../action/submitSurvey.jsp",
                                {
                                    user: user,
                                    sessionId: session,
                                    q1: q1,
                                    q2: q2,
                                    q3: q3,
                                    q4: q4,
                                    comment: comments,
                                    key: key
                                }, function(data, success) {
                        }
                        );

                        $("#code").hide();
                        $("#confirm").show();
                        $("#actions").hide();
                        $("#step").val(4);
                        $("#progress3").removeClass("current");
                        $("#progress3").addClass("completed");
                        $("#progress4").addClass("current");
                    }
                });
            });</script>
        <style>
            .divider {
                margin-right: 12px;
            }
            input[type="radio"] {
                position:relative;
                bottom: 5px;
                margin-right: 6px;
            }
            h1 {
                font-weight: normal;
            }
            #continue, #keyvalidate {
                cursor: pointer;
            }
            .errors {
                display: none;
            }
            .errorsquestion {
                color: red;
                font-weight: bold;
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
            } catch (Exception e) {
            }
            SessionPersistence sp = new SessionPersistence();
            sp.createThisYearSessions(2013);
        %>
        <%@ include file="../../includes/header.jsp" %> 
        <%@ include file="../../includes/testnav.jsp" %>
        <div class="container-fixed largeBottomMargin">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="../../private/employee/home.jsp">Home</a></li>
                    <li class='ieFix'>Techtoberfest: Session Feedback</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1>Techtoberfest: Session Feedback</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <p>We want to hear from you!  Please answer a few short questions to help us improve our service and your experience.  Only one survey can be submitted per session.  We thank you for your feedback!</p>
                <p><strong>Note:</strong>  As an incentive...if you complete a survey for a session and provide the appropriate session code within 30 minutes of attending, your name will be added to our raffle drawing.</p>
            </div>
            <div class='row mediumBottomMargin'></div>
            <div class="row mediumBottomMargin">
                <section class="progressIndicator clearFix">
                    <ul class="progressIndicator-list">
                        <li class="current" id="progress1">
                            <i class="progressIndicator-symbol"></i>
                            <span class="progressIndicator-title">Select session you want to submit survey for</span>
                        </li>
                        <li id="progress2">
                            <i class="progressIndicator-symbol"></i>
                            <span class="progressIndicator-title">Provide your feedback</span>
                        </li>
                        <li id="progress3">
                            <i class="progressIndicator-symbol"></i>
                            <span class="progressIndicator-title">Provide your session code</span>
                        </li>
                        <li id="progress4">
                            <i class="progressIndicator-symbol"></i>
                            <span class="progressIndicator-title">Confirmation</span>
                        </li>
                    </ul>
                    <div class="progressIndicator-content">
                    </div>
                </section>
            </div>
            <input type="hidden" id="step" name="step" value="1"/>
            <input type="hidden" id="session" name="session"/>
            <input type="hidden" id="user" name="user" value=<%= user%>/>
            <input type="hidden" id="q1" name="q1"/>
            <input type="hidden" id="q2" name="q2"/>
            <input type="hidden" id="q3" name="q3"/>
            <input type="hidden" id="q4" name="q4"/>
            <input type="hidden" id="comment" name="comment"/>
            <input type="hidden" id="sessionkey" name="sessionkey"/>
            <div id="dateselector" class="mediumBottomMargin row">
                <span><strong>Session Dates:</strong></span>
                <select name="date" id="date" class="input-large">
                    <option value="1">10/10 Morning Sessions</option>
                    <option value="2">10/10 Afternoon Sessions</option>
                    <option value="3">10/11 Morning Sessions</option>
                    <option value="4">10/11 Afternoon Sessions</option>
                </select>
            </div>
            <div id='errors' class='errors feedbackMessage-error mediumBottomMargin row'>
            </div>
            <div class="row" id="table">
                <table class="table" style="margin-left: -6px;">

                    <%
                        AttendancePersistence ap = new AttendancePersistence();
                        ArrayList<Session> sessions = ap.getUsersAttendanceInYear(user);
                        SimpleDateFormat fmt = new SimpleDateFormat("h:mm a");
                        int surveyCount = 0;
                        for (int i = 0; i < sessions.size(); i++) {
                            out.print("<tr>");
                            out.print("<td class='" + sessions.get(i).getSessionDate());
                            int time = Integer.parseInt(sessions.get(i).getStartTime().toString().substring(0, 2));
                            if (time >= 8 && time <= 11) {
                                out.print("morning");
                            } else {
                                out.print("afternoon");
                            }
                            out.print("'>");
                            out.print("<input type='radio' name='survey' value='" + sessions.get(i).getId() + "'");
                            if (sessions.get(i).isSurvey() == true) {
                                out.print(" disabled ");
                            }
                            out.print(" />");
                            out.print("<span class='divider'>");
                            try {
                                out.print(fmt.format(sessions.get(i).getStartTime()));
                            } catch (Exception e) {
                                out.print("No Time");
                            }
                            out.print("</span>");
                            out.print("<span>" + sessions.get(i).getName());
                            if (sessions.get(i).isSurvey() == true) {
                                out.print(" * ");
                                surveyCount++;
                            }
                            out.print("</span>");
                            out.print("</td>");
                            out.print("</tr>");

                        }

                    %>    
                </table>
                <% if (surveyCount > 0) {
                        out.print("<span>* A survey for this session has already been submitted by you.</span>");
                        out.print("<div class='largeBottomMargin'></div>");
                    }
                else {
                    out.print("<div style='margin-bottom: 15px;'></div>");
                }
                %>
            </div>
            <div id="survey" class="largeBottomMargin row">
                <table class="table" style="margin-left: -8px;">
                    <%
                        DataConnection dataConnection = new DataConnection();
                        Connection newConnect = dataConnection.sendConnection();
                        Statement newStatement = newConnect.createStatement();
                        ResultSet qResult = newStatement.executeQuery("select id, text from question");
                        while (qResult.next()) {
                    %>
                    <tr>
                        <td><label><% out.print(qResult.getString("text"));%></label></td>
                        <td><div class="form-group inline">
                                <input type="radio" value="1" <% out.print(" name=q" + qResult.getInt("id"));%>><span class="checkbox inline divider" >Strongly Disagree</span>
                                <input type="radio" value="3" <% out.print(" name=q" + qResult.getInt("id"));%>><span class="checkbox inline divider" >Neutral</span>
                                <input type="radio" value="5" <% out.print(" name=q" + qResult.getInt("id"));%>><span class="checkbox inline" >Strongly Agree</span>
                            </div><div class='errorsquestion' <% out.print("id='error" + qResult.getInt("id") + "'");%>></div></td>
                    </tr>
                    <% }
                        qResult.close();
                        newStatement.close();
                        newConnect.close();
                    %>
                </table>
                <label>Comments:</label><textarea maxlength="250" cols="50" rows="5" name="comment" id="commentbox"></textarea>
            </div>
            <div id="code" class="row mediumBottomMargin">
                <div class="form-group">
                    <label>Please enter the session code you were provided</label>
                    <input class="input-xlarge" maxlength="4" name="key" id="key" /><a style="margin-left: 12px;" id="keyvalidate" class="button button-primary">Check Key Value</a>
                    <br/><br/><span id="keyError" class="errors">
                            <span style="color:red">The session code you have provided for this session is incorrect. Please enter a valid code in order to confirm your attendance, or you can opt to leave this field blank and submit your survey without it.</span>
                        </span>
                </div>
                <p style="color:red">Note: Session codes are provided for each session.  This code not only helps the Techtoberfest Committee verify your session attendance, but it also serves as a raffle ticket if provided within 30 minutes of you attending a particular session.  If you do not have the code for this session, you may leave this field blank and continue with the survey.</p>
            </div>
            <div id="confirm" class="row">
                <p class="feedbackMessage-success">Your survey has been submitted successfully!</p>
                <div class="mediumBottomMargin">
                    <p>The Techtoberfest committee appreciates your feedback and thanks you for attending Tecthoberfest 2013!</p>
                </div>
                <div class="form-actions">
                    <a href="../../private/employee/surveys.jsp">Submit another survey</a>
                    <a href="../../private/employee/home.jsp">Return to homepage</a>
                </div>
            </div>
            <div class="form-actions row" id="actions">
                <a id="continue" class="button button-primary">Continue</a><a href="../../private/employee/home.jsp">Cancel</a>
            </div>
        </div>
        <%@ include file="../../includes/footer.jsp" %>
    </body>
</html>
