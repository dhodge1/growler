<%-- 
    Document   : error404
    Created on : Jul 10, 2013, 11:33:36 AM
    Author     : 162107
--%>

<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.scripps.growler.*" %>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>404 Error</title><!-- Title -->
        <meta name="description" content="Techtoberfest 404 Error Page" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="http://growler-dev.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler-dev.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="http://growler-dev.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <link rel="stylesheet" href="http://growler-dev.elasticbeanstalk.com/css/errors.css"/>
    </head>
    <body id="growler1">
        <%@ include file="../../includes/header.jsp" %>
        <%@ include file="../../includes/testnav.jsp" %>
        
        <div class="container-fixed">
            <div class="content">
            <div class="row mediumBottomMargin">
                <h1 class="error_heading">Page Not Found</h1>
            </div>
            <div class="row mediumBottomMargin">
                <p class="error_p">We're sorry.  The page you are looking for has moved or does not exist.  We apologize for any inconvenience.</p>
                <div class="error_container">
                    If you need additional assistance or need further support, please contact the Support Desk.
                    <br/>
                    <br/>
                    

                    <div>
                        <h5 style="display: inline-block">Phone:</h5> 865-560-4040 or 877-538-2025
                    </div>
                    <div>
                        <h5 style="display: inline-block">Email: <a href="mailto:supportdesk@scrippsnetworks.com">supportdesk@scrippsnetworks.com</a>
                        </h5>
                    </div>
                    <div>
                        <h5 style="display: inline-block">Self-Service: <a href="https://support.scrippsnetworks.com">https://support.scrippsnetworks.com</a>
                        </h5>
                    </div>
                    (Requests submitted via Self-Service are assumed to be a standard priority.)
                </div>
            </div>
            </div>
        </div>
        <%@ include file="../../includes/footer.jsp" %> 
        <%@ include file="../../includes/scriptlist.jsp" %>
    </body>
</html>