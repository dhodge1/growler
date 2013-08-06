<%-- 
    Document   : themeentry
    Created on : Feb 27, 2013, 12:17:43 AM
    Author     : Justin Bauguess & Jonathan C. McCowan
    Purpose    : The purpose of themeentry is to allow the administrator to
                enter a theme into the database.  By default, it will not be 
                visible.  This can be changed with the admin/theme.jsp file.  It 
                uses the same action file (processThemeSuggestion) but will forward
                to a different page based on being an admin (or not).
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="description" content="" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="shortcut icon" type="image/png" href="../../../images/scripps_favicon-32.ico">
        <title>Add a Speaker</title>

        <link rel="stylesheet" href="../../../css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="http://growler-dev.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler-dev.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <style>
            .message_container {
                display: none;
                color: red;
                font-weight: bold;
            }
            h1, h3 {
                font-weight: normal;
            }
            input[type="checkbox"] {
                position:relative;
                bottom: 5px;
                margin-right: 6px;
            }
        </style>
        <script src="http://growler-dev.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%
            int user = 0;
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../../../index.jsp");
                //} else if (!session.getAttribute("role").equals("admin")) {
                //    response.sendRedirect("../../../index.jsp");
                // }
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
            <div class="mediumBottomMargin row"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="../../../private/employee/admin/home.jsp">Home</a></li>
                    <li class='ieFix'>Add a Speaker</li>
                </ul>
            </div>
            <div class='row mediumBottomMargin'>
                <h1 style="margin-top:0px;font-weight: normal;">Add a New Speaker</h1>
            </div>
            <div class='mediumBottomMargin row' style='border: 1px dotted #ddd;'></div>
            <div class="row largeBottomMargin">
                <h3>Please fill out the form below to add a new speaker.</h3>
            </div>
            <div class="row mediumBottomMargin">
                <label><span style="color: red;">*</span>Required field</label>
            </div>
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='http://growler-dev.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class="titlespan">Add a Speaker</span></h2>
            </div>
            <div class="row mediumBottomMargin">
                <%@include file="../../../includes/messagehandler.jsp" %>
                <form method="POST" id="action" action="../../../action/processSpeakerAdd.jsp">
                    <fieldset>
                        <div class="form-group inline">
                            <label class="required">Speaker First Name</label>
                            <input required="required" name="first_name" class="input-xlarge" type="text" id="tip" data-content="Please enter no more than 30 characters" maxlength="30"/>
                            <br/><span id="error_first" class="message_container">
                                <span>Please enter a first name</span>
                            </span>
                        </div>
                        <div class="form-group inline">
                            <label class="required">Speaker Last Name</label>
                            <input required="required" name="last_name" class="input-xlarge" type="text" id="tip2" data-content="Please enter no more than 30 characters" maxlength="30"/>
                            <br/><span id="error_last" class="message_container">
                                <span>Please enter a last name</span>
                            </span>
                        </div>
                        <div class='form-group'>
                            <label class='required'>What type of speaker is this?</label>
                            <select name="type" id="tip3" class="input-xlarge" data-content="Choose a type: Business or Technical">
                                <option value="0">Please Select a Type</option>
                                <option value="Business">Business</option>
                                <option value="Technical">Technical</option>
                            </select>
                            <br/><span id="error_type" class="message_container">
                                <span>Please select a speaker type</span>
                            </span>
                        </div>
                        <div class="form-group">
                            <label class="required">Speaker added by</label>
                            <input type="text" name="creator" id="tip4" <% out.print("value='" + user + "'");%> />
                            <br/><span id="error_creator" class="message_container">
                                <span>Please enter who added the speaker</span>
                            </span>
                        </div>
                        <div class="form-group">
                            <input type="checkbox" name="visible" value="true"/><label class="required checkbox inline">Make speaker visible to users?</label>
                        </div>
                        <div class="form-actions">
                            <input class="button button-primary" id="send" type="submit" value="Add Speaker" name="Submit" />
                            <a id="cancel" href="../../../private/employee/admin/speaker.jsp">Cancel</a>
                        </div>
                    </fieldset>
                </form>		
            </div>
        </div>
        <%@ include file="../../../includes/footer.jsp" %> 
        <%@ include file="../../../includes/scriptlist.jsp" %>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
        <script src="js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
        <script src="js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
        <script src="js/libs/sniui.auto-inline-help.min.js" type="text/javascript"></script>
        <script src="js/libs/sniui.auto-inline-help.1.0.0.min.js" type="text/javascript"></script>

        <!--Additional Script-->
        <script src="../../../js/speaker.js"></script>
        <script>$(function() {
                $("input").autoinline();
            });</script>
    </body>
</html>
