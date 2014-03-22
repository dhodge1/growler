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
        <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/images/scripps_favicon-32.ico">
        <title>Add a Presentation Theme</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <style>
            .message_container {
                display: none;
                color: red;
                font-weight: bold;
            }
            input[type="checkbox"] {
                position:relative;
                margin-right: 6px;
            }
            h1, h3 {
                font-weight: normal;
            }
        </style>
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
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
            <div class="mediumBottomMargin row"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li class='ieFix'>Add a Presentation Theme</li>
                </ul>
            </div>
            <div class='row mediumBottomMargin'>
                <h1 style="margin-top:0px;font-weight: normal;">Add a New Theme</h1>
            </div>
            <div class='mediumBottomMargin row' style='border: 1px dotted #ddd;'></div>
            <div class="row largeBottomMargin">
                <h3>Please fill out the form below to add a new presentation theme.</h3>
            </div>
            <div class="row mediumBottomMargin">
                <label><span style="color: red;">*</span>Required field</label>
            </div>
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='${pageContext.request.contextPath}/images/Techtoberfest2013small.png'/><span style="padding-left: 12px;">Theme Details</span></h2>
            </div>
            <div class="row mediumBottomMargin">
                <%@include file="../../../includes/messagehandler.jsp" %>
                <form method="POST" id="action" action="${pageContext.request.contextPath}/action/processThemeAdd.jsp">
                    <fieldset>
                        <div class="form-group">
                            <label class="required">Theme name</label>
                            <input required="required" name="name" class="input-xlarge" type="text" id="tip" data-content="30 characters or less please" maxlength="30"/>
                            <br/><span id="error_theme_name" class="message_container">
                                <span>Please enter a theme name</span>
                            </span>
                        </div>
                        <div class="form-group">
                            <label class="required">Theme description</label>
                            <input required="required" name="description" class="input-xlarge" type="text" id="tip3" data-content="250 characters or less please" maxlength="250"/>
                            <br/><span id="error_theme_description" class="message_container">
                                <span>Please enter a theme description</span>
                            </span>
                        </div>
                        <div class="form-group">
                            <label class="required">Theme category</label>
                            <select name="type" id="tip2">
                                <option value="0"> Select a Category </option>
                                <option value="Business">Business</option>
                                <option value="Technical">Technical</option>
                            </select>
                            <br/><span id="error_theme_type" class="message_container">
                                <span>Please select a presentation theme type</span>
                            </span>
                        </div>
                        <div class="form-group">
                            <label class="required">Theme added by</label>
                            <input type="text" name="creator" <% out.print("value='" + user + "'");%> />
                        </div>
                        <div class="form-group" style="margin-bottom: 15px;">
                            <input type="checkbox" name="visible" value="true"/><label class="checkbox inline"> Make theme visible to users?</label>
                        </div>
                        <div class="form-actions">
                            <input class="button button-primary" id="send" type="submit" value="Add Theme" name="Submit" />
                            <a id="cancel" href="${pageContext.request.contextPath}/private/employee/admin/theme.jsp">Cancel</a>
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
        <script src="${pageContext.request.contextPath}/js/themeentry.js"></script>
        <script>$(function() {
                $("input").autoinline();
            });</script>
    </body>
</html>
