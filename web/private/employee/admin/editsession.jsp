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
        <link rel="shortcut icon" type="image/png" href="../../../images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="http://growler-dev.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler-dev.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="http://growler-dev.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
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
        </style>
    </head>
    <body id="growler1">
        <%
            int user = 0;
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../../../index.jsp");
            } else if (!session.getAttribute("role").equals("admin")) {
                response.sendRedirect("../../../index.jsp");
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
            ArrayList<Speaker> speakers = sp.getAllSpeakers("order by last_name, first_name");
        %>
        <%@ include file="../../../includes/adminheader.jsp" %> 
        <%@ include file="../../../includes/adminnav.jsp" %>
        <div class="container-fixed">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="../../../private/employee/admin/home.jsp">Home</a></li>
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
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='http://growler-dev.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class="titlespan">Speaker Details</span></h2>
            </div>
            <div class="row largeBottomMargin">
                <form method="post" action="../../../action/processSessionEdit.jsp">
                    <div class="form-group">
                        <input name="id" type="hidden" value="<% out.print(s.getId());%>" />
                        <label class="required">Session Name</label>
                        <input required="required" name="name" class="input-xlarge" type="text" id="tip" data-content="Please enter no more than 30 characters" maxlength="30" <% out.print("value='" + s.getName() + "'");%> />
                        <br/><span id="error_name" class="message_container">
                            <span>Please enter a session name</span>
                        </span>
                    </div>
                    <div class="form-group">
                        <label class="required">Session description</label>
                        <textarea required="required"  name="description" id="tip2" data-content="Please enter no more than 250 characters" cols="50" rows="5"></textarea>
                        <br/><span id="error_description" class="message_container">
                            <span>Please enter a session description</span>
                        </span>
                    </div>
                    <div class="form-group">
                        <label class="required">Speaker speaker</label>
                        <select name="speaker" id="tip3">
                            <option value="0"> No Speaker Available </option>
                            <% for (int i = 0; i < speakers.size(); i++){
                                out.print("<option value ='" + speakers.get(i).getId() + "'>");
                                out.print(speakers.get(i).getFullName());
                                out.print("</option>");
                            }
                            %>
                        </select>
                        <br/><span id="error_speaker" class="message_container">
                            <span>Please select a speaker</span>
                        </span>
                    </div>
                    <div class="form-group">
                        <label class="required">Select a session date</label>
                        <input name="date" id="datepicker" type="text" data-content="Enter a date for the Session"/>
                        <br/><span id="error_date" class="message_container">
                            <span>Please enter a date</span>
                        </span>
                    </div>
                    <div class="form-group" style="margin-bottom: 24px;">
                        <label class="required">Select a session time range</label>
                        <select id="time" name="time">
                                <option value="00:00:00"> - No Time - </option>
                                <option value="08:00:00">8:00 AM - 9:00 AM</option>
                                <option value="09:00:00">9:00 AM - 10:00 AM</option>
                                <option value="10:00:00">10:00 AM - 11:00 AM</option>
                                <option value="11:00:00">11:00 AM - 12:00 PM</option>
                                <option value="12:00:00">12:00 PM - 01:00 PM</option>
                                <option value="13:00:00">1:00 PM - 2:00 PM</option>
                                <option value="14:00:00">2:00 PM - 3:00 PM</option>
                                <option value="15:00:00">3:00 PM - 4:00 PM</option>
                                <option value="16:00:00">4:00 PM - 5:00 PM</option>
                                <option value="17:00:00">5:00 PM - 6:00 PM</option>
                            </select>
                        <br/><span id="error_time" class="message_container">
                            <span>Please enter a time range</span>
                        </span>
                    </div>
                    <div class="form-actions">
                        <input id="send" type="submit" value="Save Changes" class="button button-primary"/>
                        <a href="../../../private/employee/admin/session.jsp">Cancel</a>
                    </div>
                </form>
            </div>
        </div>
        <%@ include file="../../../includes/footer.jsp" %> 
        <script src="../../../js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
        <%@ include file="../../../includes/scriptlist.jsp" %>
        <script src="../../../js/session.js"></script>
        <script>
            $(function() {
                $("input").autoinline();
                $("#datepicker").datepicker({minDate: new Date(2013, 10 - 1, 1), maxDate: new Date(2013, 10 - 1, 31)}).change(function() {
                    $("#datepicker").datepicker("option", "dateFormat", "yy-mm-dd");
                });
            });
        </script>
    </body>
</html>