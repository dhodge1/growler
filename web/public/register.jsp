<%-- 
    Document   : register
    Created on : Apr 17, 2013, 9:46:22 PM
    Author     : Justin Bauguess & Jonathan C. McCowan
    Purpose    : The purpose of register is to gather user information
                for those who wish to register for the Growler application.
--%>

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
        <meta name="description" content="" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Register for the Techtoberfest Application</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/prettify/prettify.css" /> 
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/general.css" /><!--General CSS-->
        <link rel="stylesheet" href="draganddrop.css" /><!--Drag and drop style-->
        <style>
            .message_container {
                display: none;
                color: red;
                font-weight: bold;
            }
        </style>
        <script src="${pageContext.request.contextPath}/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->	
    </head>
    <body id="growler1">
        <%@ include file="../includes/indexheader.jsp" %> 
        <div class="container-fixed">
            <div class="row">
                <br/>

                <h1>Techtoberfest Information System (TIS)</h1>
                <h3>TIS allows Scripps Employees the ability to not only stay abreast 
                    of all Techtoberfest sessions, but also the opportunity to provide 
                    valuable session feedback before, during, and after the event!</h3>

            </div>
            <br/><br/><br/>
            <div class="row">

                <h2 class="bordered"><img src='../images/Techtoberfest2013small.png'/><span class="titlespan">Create An Account</span></h2>

            </div>
            <br/>
            <div class="row">

                <form method="POST" id="action" action="${pageContext.request.contextPath}/action/adduser.jsp">

                    <fieldset>

                        <div class="form-group">
                            <label class="required">Corporate ID</label>
                            <input name="corporate" class="input-xlarge" type="text" id="tip" data-content="Your 6 digit SNI Id" maxlength="6"/>
                            <br/><span id="error_corporate" class="message_container">
                                <span>Please Enter your Corporate ID</span>
                            </span>
                        </div>
                        <div class="form-group">
                            <label class="required">First Name</label>
                            <input name="firstname" class="input-xlarge" type="text" id="tip2" data-content="Your First name, 20 characters or less please" maxlength="20"/>
                            <br/><span id="error_first" class="message_container">
                                <span>Please Enter your First Name</span>
                            </span>
                        </div>
                        <div class="form-group">
                            <label class="required">Last Name</label>
                            <input name="lastname" class="input-xlarge" type="text" id="tip3" data-content="Your Last name, 20 characters or less please" maxlength="20"/>
                            <br/><span id="error_last" class="message_container">
                                <span>Please Enter your Last Name</span>
                            </span>
                        </div>
                        <div class="form-group">
                            <label class="required">Password</label>
                            <input name="password" class="input-xlarge" type="password" id="tip4" data-content="Your password, 20 characters or less" maxlength="20"/>
                            <br/><span id="error_password" class="message_container">
                                <span>Please Enter A Password</span>
                            </span>
                        </div>
                        <div class="form-group">
                            <label class="required">Email</label>
                            <input name="password" class="input-xlarge" type="text" id="tip5" data-content="Your email" maxlength="50"/>
                            <br/><span id="error_email" class="message_container">
                                <span>Please Enter your Email Address</span>
                            </span>
                        </div>
                        <div class="form-actions">
                            <input id="send" class="button button-primary" value="Submit" type="submit">
                            <a class="button" id="cancel" href="${pageContext.request.contextPath}/index.jsp">Cancel</a>
                        </div>
                    </fieldset>

                </form>	

            </div>
        </div>
        <br/>
        <br/>

        <%@ include file="../includes/footer.jsp" %> 
        <%@ include file="../includes/scriptlist.jsp" %>

        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/libs/sniui.auto-inline-help.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/libs/sniui.auto-inline-help.1.0.0.min.js" type="text/javascript"></script>

        <!--Additional Script-->
        <script src="${pageContext.request.contextPath}/js/register.js"></script>
    </body>
</html>
