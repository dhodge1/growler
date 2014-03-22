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
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <title>Edit Theme</title>
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
            int themeId = (Integer.parseInt(request.getParameter("id")));
            ThemePersistence tp = new ThemePersistence();
            Theme theme = tp.getThemeByID(themeId);
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
                    <li class='ieFix'>Edit Theme</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="margin-top:0px;font-weight: normal;">Edit Theme</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>Please use the form below to edit theme details.</h3>
            </div>
            <div class="row mediumBottomMargin">
                <label><span style="color: red;">*</span>Required field</label>
            </div>
            <div class="row mediumBottomMargin">
                    <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='${pageContext.request.contextPath}/images/Techtoberfest2013small.png'/><span style="padding-left: 12px;">Theme Details</span></h2>
            </div>
            <div class="row largeBottomMargin">
                <form method="post" action="${pageContext.request.contextPath}/action/processThemeEdit.jsp">
                    <div class="form-group">
                        <label class="required">Theme name</label>
                        <input id="tip" name="name" type="text" data-content="Enter the name of the Theme" value="<% out.print(theme.getName());%>" maxlength="30"/>
                        <input name="id" type="hidden" value="<% out.print(theme.getId());%>" />
                        <br/><span id="error_theme_name" class="message_container">
                                    <span>Please enter a presentation theme name</span>
                                </span>
                                <span id="error_too_long" class="message_container">
                                    <span>Please enter no more than 30 characters</span>
                                </span>
                    </div>
                    <div class="form-group">
                        <label class="required">Theme description</label>
                        <input name="description" id="tip3" type="text" data-content="Enter the Description" value="<% out.print(theme.getDescription());%>" maxlength="250"/>
                    </div>
                    <div class="form-group">
                        <label class="required">Theme category</label>
                        <select name="category" id="tip2">
                            <option value="0"> Select a Type </option>
                            <option value="Business" <% if (theme.getType().equals("Business")) {                                out.print("selected"); } %>>Business</option>
                            <option value="Technical" <% if (theme.getType().equals("Technical")) {                                out.print("selected"); } %>>Technical</option>
                        </select>
                        <br/><span id="error_theme_type" class="message_container">
                                    <span>Please select a presentation theme type</span>
                                </span>
                    </div>
                    <div class="form-group">
                        <label class="required">Theme added by</label>
                        <input name="creator" id="tip4" type="text" data-content="Enter a Creator ID for the Theme, no more than 6 characters" value="<% out.print(theme.getCreatorId());%>"/>
                        <br/><span id="error_creator" class="message_container">
                                    <span>Please enter your User ID</span>
                                </span>
                        <span id="error_creator_length" class="message_container">
                            <span>Please enter no more than 6 characters</span>
                        </span>
                    </div>
                    <div class="form-group" style="margin-bottom: 15px;">
                        <input type='checkbox' name='visible' <% if (theme.getVisible()) { out.print(" checked ");} %> />
                        <label class="checkbox inline">Make theme visible to users?</label>
                    </div>
                        <div class="form-actions">
                    <input type="submit" value="Save Changes" id="send" class="button button-primary"/>
                    <a href="${pageContext.request.contextPath}/private/employee/admin/theme.jsp">Cancel</a>
                        </div>
                </form>
            </div>
        </div>
        <%@ include file="../../../includes/footer.jsp" %> 
        <script src="${pageContext.request.contextPath}/js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
        <%@ include file="../../../includes/scriptlist.jsp" %>
        <script src="${pageContext.request.contextPath}/js/themeentry.js"></script>
        <script>
                    $(function() {
                        $("input").autoinline();
                    });
        </script>
    </body>
</html>