<%-- 
    Document   : themeentry
    Created on : Feb 27, 2013, 12:17:43 AM
    Author     : Justin Bauguess and Jonathan C. McCowan
    Purpose    : This page is for users to suggest themes for review
                it uses model/processThemeSuggestion.jsp to process the data.
                The table used is theme.  The fields in the table that are
                modified are name, description, reason (as entered by
                the user), and creator and visible (which are the user id
                 and "0" or false as default).
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
        <title>Suggest a New Theme</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/general.css" /><!--General CSS-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/prettify/prettify.css" /> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/wijmo/jquery.wijmo-complete.all.2.3.2.min.css"/>
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <link rel="shortcut icon" type="image/png" href="${pageContext.request.contextPath}/images/scripps_favicon-32.ico">
        <style>
            .message_container {
                display: none;
                color: red;
                font-weight: bold;
            }
            h3 {
                font-weight:normal;
            }
            #speakerImg {
                height: 95%;
                width: 95%;
                border-radius: 50px;
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
                        String name = String.valueOf(session.getAttribute("user"));                  
                    }
                    catch (Exception e) {
                        
                    }
                %>
        <%@ include file="../../includes/header.jsp" %> 
        <% if (String.valueOf(session.getAttribute("role")).equals("admin")) { %>
            <%--<jsp:include page="../../includes/supernav.jsp" flush="true"/>--%>
            <%@ include file="../../includes/supernav.jsp" %>
        <% } else {%>
            <%--<jsp:include page="../../includes/testnav.jsp" flush="true"/>--%>
            <%@ include file="../../includes/testnav.jsp" %>
        <% } %>
        <%--<%@ include file="../../includes/testnav.jsp" %>--%>
        <div class="container-fixed mediumBottomMargin">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li>Suggest a New Theme</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="margin-top:0px;font-weight: normal;">Suggest a New Theme</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>Is there a new presentation theme you would like to suggest for this year's Techtoberfest?  We would LOVE to know more about it.</h3>
            </div>
            <div class="row mediumBottomMargin">
                <label><span style="color: red;">*</span>Required field</label>
            </div>
            <div class="row mediumBottomMargin">
                    <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='${pageContext.request.contextPath}/images/Techtoberfest2013small.png'/><span class="titlespan">Suggestion Details</span></h2>
            </div>
            <div class="row">
                <%@include file="../../includes/messagehandler.jsp" %>
                    <div class="span6">
                        <form method="POST" id="action" action="${pageContext.request.contextPath}/action/processThemeSuggestion.jsp">
                            <fieldset>
                                <div class="form-group">
                                    <label class="required">Presentation Theme Name</label>
                                    <input required="required" name="name" class="input-xlarge" type="text" id="tip" data-content="Please enter no more than 30 characters" maxlength="30"/>
                                    <br/><span id="error_theme_name" class="message_container">
                                        <span>Please enter a presentation theme name</span>
                                    </span>
                                    <span id="error_too_long" class="message_container">
                                        <span>Please enter no more than 30 characters</span>
                                    </span>
                                </div>
                                <div class="form-group">
                                    <label class="required">What would be your preferred presentation type?</label>
                                    <select name="type" id="tip2" class="input-xlarge" data-content="Choose a type: Business or Technical">
                                        <option value="0">Please Select a Type</option>
                                        <option value="Business">Business</option>
                                        <option value="Technical">Technical</option>
                                    </select><i class='icon12-info' style="margin-left: 3px;" id='showTips' data-content="Business Presentations - Any presentation providing technical information in a non-technical way, appealing to both IT and non-IT users.<br/><br/>Technical Presentations - Presentations with a technical background providing mid to high level technical information, appealing to mainly IT users with technical backgrounds." title="Presentation Types"></i>
                                    <br/><span id="error_theme_type" class="message_container">
                                        <span>Please select a presentation theme type</span>
                                    </span>
                                </div>
                                <div class="form-group">
                                    <label>Any additional comments?</label>
                                    <p>Please let us know why this presentation should be added to this year's Tectoberfest.  Who do you think would be a good speaker for this presentation?</p>
                                    <textarea name="reason" data-content="Help us understand what this theme suggestion means to you" rows="5" cols="50" maxlength="250"></textarea>
                                </div>
                                <div class="form-actions">
                                    <input type="submit" id="send" class="button button-primary" value="Submit Suggestion" />
                                    <a id="cancel" href="${pageContext.request.contextPath}/private/employee/theme.jsp">Cancel</a>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                    <div class="span6">
                        <img id="speakerImg" src="${pageContext.request.contextPath}/images/speaker.jpg" />
                    </div>
            </div>
        </div>
        <%@ include file="../../includes/footer.jsp" %> 
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/sniui.auto-inline-help.min.js" type="text/javascript"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/sniui.auto-inline-help.1.0.0.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/libs/sniui.user-inline-help.1.2.0.min.js" type="text/javascript"></script>
        <!--Additional Script-->
        <script src="${pageContext.request.contextPath}/js/themeentry.js"></script>
        <script>$(function() {
                $("input").autoinline();
                $('#showTips').userInlineHelp();
            });</script>
    </body>
</html>
