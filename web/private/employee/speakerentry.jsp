<%-- 
    Document   : speakerentry
    Created on : Feb 27, 2013, 12:17:43 AM
    Author     : Justin Bauguess and Jonathan C. McCowan
    Purpose    : The purpose of speakerentry(user) is for users to suggest speakers
                to the Techtoberfest Admins.  It uses action/processSpeakerSuggestion.
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

        <title>Suggest a New Speaker</title>
        <link rel="shortcut icon" type="image/png" href="http://sni-techtoberfest.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="../../css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://sni-techtoberfest.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../../css/prettify/prettify.css" /> 
        <link rel="stylesheet" type="text/css" href="../../css/general.css" /><!--General CSS-->
        <script src="http://sni-techtoberfest.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->	
        <style>
            .message_container {
                display: none;
                color: red;
                font-weight: bold;
            }
        </style>
    </head>
    <body id="growler1">
            <%      int user = 0;
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
        <%@ include file="../../includes/testnav.jsp" %>
        <div class="container-fixed">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="../../private/employee/home.jsp">Home</a></li>
                    <li>Suggest a Speaker</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="font-weight:normal;">Suggest a Speaker</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ccc"></div>
            <div class="row largeBottomMargin">
                <h3 style='font-size: 16px; font-family: Arial;'>Is there a new speaker you would like to suggest for this years Techtoberfest?  We would LOVE to know more about them.</h3>
            </div>
            <div class="row mediumBottomMargin">
                <label><span style="color: red;">*</span>Required field</label>
            </div>
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-left:0px;padding-bottom:0px;" src="http://sni-techtoberfest.elasticbeanstalk.com/images/Techtoberfest2013small.png"/><span class="titlespan">Suggestion Details</span></h2>
            </div>
            <div class="row">
                    <form method="POST" id="action" action="../../action/processSpeakerSuggestion.jsp">
                        <fieldset>
                            <div class="form-group inline">
                                <label class="required">Speaker First Name</label>
                                <input required="required" name="first_name" class="input-xlarge" type="text" id="tip" data-content="30 characters or less please" maxlength="30"/>
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
                                    <option value="null">Please Select a Type</option>
                                    <option value="Business">Business</option>
                                    <option value="Technical">Technical</option>
                                </select>
                                <br/><span id="error_type" class="message_container">
                                    <span>Please select a speaker type</span>
                                </span>
                            </div>
                            <div class="form-group">
                                <label>Why should this speaker be added to this years Techtoberfest?</label>
                                <textarea name="reason" id="tip4" data-content="Please enter no more than 250 characters" rows="5" cols="50" maxlength="250">
                                </textarea>
                            </div>
                            <div class="form-actions">
                                <input type="submit" id="send" class="button button-primary" value="Submit Suggestion"/>
                                <a id="cancel" href="../../private/employee/home.jsp">Cancel</a>
                            </div>
                        </fieldset> 
                </form>	  
            </div>
        </div>
        <%@ include file="../../includes/footer.jsp" %> 
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
        <script src="http://sni-techtoberfest.elasticbeanstalk.com/js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
        <script src="../../js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
        <script src="http://sni-techtoberfest.elasticbeanstalk.com/js/libs/sniui.auto-inline-help.min.js" type="text/javascript"></script>
        <script src="http://sni-techtoberfest.elasticbeanstalk.com/js/libs/sniui.auto-inline-help.1.0.0.min.js" type="text/javascript"></script>

        <!--additional script-->
        <script src="../../js/speaker.js"></script>
    </body>
</html>
