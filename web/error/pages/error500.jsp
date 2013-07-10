<%-- 
    Document   : error500
    Created on : Jul 9, 2013, 10:00:01 AM
    Author     : 162107
--%>

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
        <title>500 Error</title><!-- Title -->
        <meta name="description" content="Techtoberfest 500 Error Page" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="../../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <script src="../../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%@ include file="../../includes/indexheader.jsp" %> 
        <div class="container-fixed">
            <div class="row">
                <h1>Internal Server Error</h1>
            </div>
            <div class="row">
                <p>We're sorry.  The page you are looking for has moved or does not exist.  We apologize for any inconvenience.</p>
                <div class="feedbackMessage-info">
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
        <%@ include file="../../includes/footer.jsp" %> 
        <%@ include file="../../includes/scriptlist.jsp" %>
    </body>
</html>
