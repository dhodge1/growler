<%-- 
    Document   : volSignUpConfirmation
    Created on : Apr 13, 2014, 10:04:33 AM
    Author     : Shaun
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
        <title>Volunteer Sign-Up Submitted</title>
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
            .firstlink {
                margin-right: 12px;
            }
        </style>
        <script>
            (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
            })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

            ga('create', 'UA-41279528-6', 'scrippsnetworks.com');
            ga('send', 'pageview');
        </script>
    </head>
    <body id="growler1">
            <%      int user = 0;
                    if (null == session.getAttribute("id")) {
                        response.sendRedirect("http://sniforms.scrippsnetworks.com/siteminderagent/sniforms/logout.html");
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
        <%--<%@ include file="../../includes/testnav.jsp" %>--%>
        <div class="container-fixed largeBottomMargin">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li class='ieFix'>Volunteer Sign-Up Submitted</li>
                </ul>
            </div>
            <div class="row">
                <%@include file="../../includes/messagehandler.jsp" %>
            </div>
            <div class="row mediumBottomMargin">
                <h1>Volunteer Sign-Up Submitted</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row">
                <span>Thankyou for volunteering! We will contact you shortly.</span>
            </div>
            <div style='margin-bottom:17px;'></div>
            <div class="row">
                <a href='${pageContext.request.contextPath}/home'>Return to homepage</a>
            </div>
        </div>
        <%@ include file="../../includes/footer.jsp" %> 
    </body>
</html>
