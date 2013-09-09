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
        <title>Add Session</title><!-- Title -->
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="shortcut icon" type="image/png" href="../../../images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/sniui.dialog.1.2.0.js"></script>
        <script src="../../../js/session.js"></script>
        <script>
            $(function() {
                $("#datepicker").datepicker({
                    dateFormat: 'yy-mm-dd',
                    minDate: new Date(2013, 9, 1),
                    maxDate: new Date(2013, 9, 31)
                });
            });
        </script>
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
        </style>
    </head>
    <body id="growler1">
        <%
            int user = 0;
            if (null == session.getAttribute("id")) {
               // response.sendRedirect("../../../index.jsp");
            } else if (!session.getAttribute("role").equals("admin")) {
               // response.sendRedirect("../../../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
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
                    <li class='ieFix'>Add Session</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="margin-top:0px;font-weight: normal;">Add Session</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>Please use form below to Add session details.</h3>
            </div>
            <div class="row mediumBottomMargin">
                <label><span style="color: red;">*</span>Required field</label>
            </div>
            <div class="row smallBottomMargin">
                    <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='http://growler.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span style="padding-left: 12px;">Session Details</span></h2>
            </div>
            <div class="row largeBottomMargin">
                    <%
                        SessionPersistence sp = new SessionPersistence();
                        ArrayList<Session> sessions = sp.getAllSessionsWithKeys(" ");
                        SpeakerPersistence sk = new SpeakerPersistence();
                        ArrayList<Speaker> speakers = sk.getAllSpeakers("");
                    %>
                    <form method="post" action="../../../action/processSession.jsp" onSubmit="return validateValues();">
                        <div class="form-group">
                            <label class="required">Session Topic </label>
                            <input id="name" size='50' name="name" type="text" data-content="Enter the name of the Session" maxlength="70"/>
                            <br/><span id="error_name" class="message_container">
                            <span>Please enter a session name</span>
                        </span>
                        </div>
                        <div class="form-group">
                            <label class="required">Session Description </label>
                            <textarea id="description" name="description" maxlength="250" rows="5" cols="50" data-content="Enter the name of the Session" ></textarea>
                            <br/><span id="error_description" class="message_container">
                            <span>Please enter a session description</span>
                        </span>
                        </div>
                        <div class="form-group">
                            <label class="required">Session speaker </label>
                            <select id="speaker" name="speaker">
                                <option value="0"> Select a Speaker </option>
                                <% for (int i = 0; i < speakers.size(); i++){
                                   out.print("<option value='" + speakers.get(i).getId() + "'>");
                                   out.print(speakers.get(i).getFullName());
                                   out.print("</option>");
                                }%>
                            </select>
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
                                <option value="09:00:00a">09:00 am - 09:25 am</option>
                                <option value="09:00:00b">09:00 am - 09:50 am</option>
                                <option value="10:00:00a">10:00 am - 10:25 am</option>
                                <option value="10:00:00b">10:00 am - 10:50 am</option>
                                <option value="11:00:00a">11:00 am - 11:25 am</option>
                                <option value="11:00:00b">11:00 am - 11:50 am</option>
                                <option value="12:00:00a">12:00 pm - 12:25 pm</option>
                                <option value="12:00:00b">12:00 pm - 12:50 pm</option>
                                <option value="13:00:00a">01:00 pm - 01:25 pm</option>
                                <option value="13:00:00b">01:00 pm - 01:50 pm</option>
                                <option value="14:00:00a">02:00 pm - 02:25 pm</option>
                                <option value="14:00:00b">02:00 pm - 02:50 pm</option>
                                <option value="15:00:00a">03:00 pm - 03:25 pm</option>
                                <option value="15:00:00b">03:00 pm - 03:50 pm</option>
                                <option value="16:00:00a">04:00 pm - 04:25 pm</option>
                                <option value="16:00:00b">04:00 pm - 04:50 pm</option>
                                <option value="17:00:00a">05:00 pm - 05:25 pm</option>
                                <option value="17:00:00b">05:00 pm - 05:50 pm</option>
                            </select>
                            <br/><span id="error_time" class="message_container">
                            <span>Please enter a time range</span>
                        </span>
                        </div>
                        <div class="form-actions">
                            <input class="button button-primary" type="submit" id="send" value="Add Session"/>
                        </div>
                    </form>
            </div>
        </div>
        <%@ include file="../../../includes/footer.jsp" %> 
        <script>
            $(function() {
                $("input").autoinline();
            });
            function validateValues() {
                //Get the Duration value, make sure it's within the threshold, isn't blank, and is a number
                var myname = document.getElementById("name");
                if (!myname.value) {
                    alert('Please enter a Session Name');
                    myname.focus();
                    return false;
                }
                var mydesc = document.getElementById("description");
                if (!mydesc.value) {
                    alert('Please enter a Session Description');
                    mydesc.focus();
                    return false;
                }
                //  var mydate = document.getElementById("datepicker");
                //  if (!mydate.value) {
                //      alert('Please enter a date');
                //      mydate.focus();
                //      return false;
                //  }
                //  var myval = document.getElementById("duration");
                //  if (myval.value < 15 || myval.value > 120 || !myval.value || isNaN(myval.value)) {
                //      alert('Duration must be between 15 and 120');
                //      myval.focus();
                //      return false;
                //  }
                //  var mylocation = document.getElementById("location");
                //  if (!mylocation.value) {
                //      alert('Please enter a location');
                //      mylocation.focus();
                //      return false;
                //  }
                return true;
            }
        </script>
    </body>
</html>