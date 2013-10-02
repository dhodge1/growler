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
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
        <title>Edit Speaker</title>
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
            if (null == session.getAttribute("id") || null == session.getAttribute("role")) {
                response.sendRedirect("../../../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
        %>
        <%
            int speakerId = (Integer.parseInt(request.getParameter("id")));
            SpeakerPersistence persist = new SpeakerPersistence();
            Speaker speaker = persist.getSpeakerByID(speakerId);
        %>
        <%@ include file="../../../includes/adminheader.jsp" %> 
        <%@ include file="../../../includes/adminnav.jsp" %>
        <div class="container-fixed">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="../../../private/employee/admin/home.jsp">Home</a></li>
                    <li class='ieFix'>Edit Speaker</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="margin-top:0px;font-weight: normal;">Edit Speaker</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>Please use form below to edit speaker details.</h3>
            </div>
            <div class="row mediumBottomMargin">
                <label><span style="color: red;">*</span>Required field</label>
            </div>
            <div class="row mediumBottomMargin">
                    <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='http://growler.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span style="padding-left:12px;">Speaker Details</span></h2>
            </div>
            <div class="row largeBottomMargin">
                <form method="post" action="../../../action/processSpeakerEdit.jsp">
                    <div class="form-group inline">
                        <input name="id" type="hidden" value="<% out.print(speaker.getId());%>" />
                                <label class="required">Speaker First Name</label>
                                <input required="required" name="first_name" class="input-xlarge" type="text" id="tip" data-content="Please enter no more than 30 characters" maxlength="30" <% out.print("value='" + speaker.getFirstName() + "'"); %> />
                                <br/><span id="error_first" class="message_container">
                                    <span>Please enter a first name</span>
                                </span>
                            </div>
                            <div class="form-group inline">
                                <label class="required">Speaker Last Name</label>
                                <input required="required" name="last_name" class="input-xlarge" type="text" id="tip2" data-content="Please enter no more than 30 characters" maxlength="30" <% out.print("value='" + speaker.getLastName() + "'"); %>/>
                                <br/><span id="error_last" class="message_container">
                                    <span>Please enter a last name</span>
                                </span>
                            </div>
                    <div class="form-group">
                        <label class="required">Speaker type</label>
                        <select name="category" id="tip3">
                            <option value="0"> Select a Type </option>
                            <option value="Business" <% if (speaker.getType().equals("Business")) {
                                out.print("selected"); } %>>Business</option>
                            <option value="Technical" <% if (speaker.getType().equals("Technical")) {
                                out.print("selected"); } %>>Technical</option>
                        </select>
                        <br/><span id="error_type" class="message_container">
                                    <span>Please select a speaker type</span>
                                </span>
                    </div>
                    <div class="form-group">
                        <label class="required">Speaker added by</label>
                        <input name="creator" id="tip4" type="text" data-content="Enter a Creator ID for the speaker" value="<% out.print(speaker.getSuggestedBy());%>"/>
                        <br/><span id="error_creator" class="message_container">
                                    <span>Please enter who added the speaker</span>
                                </span>
                    </div>
                    <div class="form-group">
                        <input type='checkbox' name='visible' <% if (speaker.getVisible()) { out.print(" checked ");} %> />
                        <label class="required checkbox inline">Make speaker visible to users?</label>
                    </div>
                    <input type="submit" value="Save Changes" class="button button-primary"/>
                </form>
            </div>
        </div>
        <%@ include file="../../../includes/footer.jsp" %> 
        <script src="../../../js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
        <%@ include file="../../../includes/scriptlist.jsp" %>
        <script src="../../../js/speaker.js"></script>
        <script>
                    $(function() {
                        $("input").autoinline();
                    });
        </script>
    </body>
</html>