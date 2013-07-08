<%-- 
    Document   : resetpassword
    Created on : Modified on 5/1/2013 by JCM
    Author     : Christopher Tupps & Jonathan C. McCowan
    Purpose    : This page allows users to change their password
                                 by using a special code emailed to them from
                                 EmailForm.jsp
                                 **Thought it might be nice to start our reset password view file.
                                It should be the place we have the new password fields and submit.
                                It might need to be posted to with an associated ID, the post
                                coming from the link emailed from the JSP mailer.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
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

        <title>Password Reset</title>

        <link rel="stylesheet" href="../css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/prettify/prettify.css" /> 
        <link rel="stylesheet" type="text/css" href="../css/general.css" /><!--General CSS-->

        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->	
    </head>
    <body id="growler1">
        <%@ include file="../includes/indexheader.jsp" %> 
        <div class="container-fixed">
            <div class="row">
                <br/>
                <div class="span8">
                    <h1>Techtoberfest Information System (TIS)</h1>
                    <h3>TIS allows Scripps Employees the ability to not only stay abreast 
                        of all Techtoberfest sessions, but also the opportunity to provide 
                        valuable session feedback before, during, and after the event!</h3>
                </div>
            </div>
            <br/><br/><br/>
            <div class="row">
                <div class='span8'>
                    <h2 class="bordered"><img src='../images/Techtoberfest2013small.png'/><span>Reset Your Password</span></h2>
                </div>
            </div>
            <br/>
            <div class="row">
                <div class="span8">
                    <form method="POST" id="action" action="../action/reset.jsp">
                        <fieldset>
                            <div class="form-group">
                                <label class="required">Verification</label>
                                <input name="verify" class="input-xlarge" type="text" id="tip" data-content="Enter the code you received from your password reset email." maxlength="60"/>
                                <span id="error_verification" class="message_container">
                                    <span>Please Enter The Verification Code</span>
                                </span>
                            </div>
                            <div class="form-group">
                                <label class="required">New Password</label>
                                <input name="password" class="input-xlarge" type="password" id="tip2" data-content="Enter the new password." maxlength="60"/>
                                <span id="error_password" class="message_container">
                                    <span>Please Enter Your New Password</span>
                                </span>
                            </div>
                            <div class="form-group">
                                <label class="required">Confirm</label>
                                <input name="password2" class="input-xlarge" type="password" id="tip3" data-content="Re-enter the new password." maxlength="60"/>
                                <span id="error_password2" class="message_container">
                                    <span>Please Repeat Your New Password</span>
                                </span>
                            </div>
                            <input type="hidden" name="user" value="<% out.print(request.getParameter("id")); %>"/>
                            <input type="hidden" name="email" value="<% out.print(request.getParameter("email")); %>"/>
                            <div class="form-actions">
                                <input class="button button-primary" id="send" value="Submit" type="submit">
                                <a class="button" id="cancel" href="../index.jsp">Cancel</a>
                            </div>
                        </fieldset>
                </form>	
                </div>
            </div>
        </div>
        <br/>
        <br/>
    <%@ include file="../includes/footer.jsp" %> 
    <%@ include file="../includes/scriptlist.jsp" %>

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script src="../js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
    <script src=".../js/libs/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="../js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
    <script src="../js/libs/sniui.auto-inline-help.min.js" type="text/javascript"></script>
    <script src="../js/libs/sniui.auto-inline-help.1.0.0.min.js" type="text/javascript"></script>

    <!--Additional Script-->
    <script src="../js/resetpassword.js"></script>
</body>
</html>
