<%-- 
    Document   : themeentry-confirm
    Created on : Jul 18, 2013, 9:30:21 AM
    Author     : 162107
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
        <title>Speaker Assignment Confirmation</title>
        <link rel="shortcut icon" type="image/png" href="http://growler.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/prettify/prettify.css" /> 
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->	
        <style>
            .message_container {
                display: none;
                color: red;
                font-weight: bold;
            }
            h1 {
                font-weight: normal;
            }
        </style>
    </head>
    <body id="growler1">
        <%      int user = 0;
            if (null == session.getAttribute("id") || null == session.getAttribute("role")) {
                response.sendRedirect("http://sniforms.scrippsnetworks.com/siteminderagent/sniforms/logout.html");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
            boolean speaker2there = false;
            try {
                String spkr2 = (String) session.getAttribute("speaker2");
                if (spkr2.equals(null) || spkr2.equals("null")) {
                    speaker2there = false;
                } else {
                    speaker2there = true;
                }
            } catch (Exception e) {
                speaker2there = false;
            }
        %>
        <%@ include file="../../../includes/header.jsp" %> 
        <% if (String.valueOf(session.getAttribute("role")).equals("admin")) { %>
            <jsp:include page="../../../includes/supernav.jsp" flush="true"/>
        <% } else {%>
            <jsp:include page="../../../includes/adminnav.jsp" flush="true"/>
        <% } %>
        <%--<%@ include file="../../../includes/adminnav.jsp" %>--%>
        <div class="container-fixed largeBottomMargin">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <%@include file="../../../includes/messagehandler.jsp" %>
            </div>
            <div class="row mediumBottomMargin">
                <h1>Speaker Assignment Confirmation</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <span><strong>Speaker 1:</strong> <% out.print((String) session.getAttribute("speaker"));%></span><br/>
                <%
                    if (speaker2there) {
                        out.print("<span><strong>Speaker 2:</strong> " + (String) session.getAttribute("speaker2") + "</span><br/>");
                    }
                %>
                <span><strong>Session:</strong> <% out.print((String) session.getAttribute("sessionInfo"));%></span>
            </div>
            <div class="row">
                <a href='../../../private/employee/admin/speaker.jsp'>Return to manage speakers</a>
            </div>
        </div>
        <%@ include file="../../../includes/footer.jsp" %> 
    </body>
</html>
