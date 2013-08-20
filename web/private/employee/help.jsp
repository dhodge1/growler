<%-- 
    Document   : help
    Author     : Justin Bauguess & Jonathan C. McCowan
    Purpose    : The purpose of help(user) is to give users information to help navigate all other pages.
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
        <title>Help</title><!-- Title -->
        <link rel="shortcut icon" type="image/png" href="http://sni-techtoberfest.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="../../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <script src="../../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <style>
            .pullRight {
                float:right;
                font-weight: normal;
                font-family: Arial;
                font-size: 11px;
                position: relative;
                top: 30px;
            }
        </style>
    </head>
    <body id="growler1">
        <%@ include file="../../includes/header.jsp" %> 
        <%@ include file="../../includes/testnav.jsp" %> 
        <div class="container-fixed mediumBottomMargin">
            <div class='row mediumBottomMargin'></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="../../private/employee/home.jsp">Home</a></li>
                    <li class='ieFix'>Techtoberfest Help</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1>Techtoberfest Help</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <span>Click on a topic below to have the help content displayed.</span>
            </div>
            <div class="row">
                <h2 class="bordered"><img id="logo" style="padding-left:0;padding-bottom:0;" src='http://sni-techtoberfest.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class="titlespan">Help By Topic</span><span class="pullRight"><a href='http://sni-techtoberfest.elasticbeanstalk.com/public/Techtoberfest_HelpDocumentation_2013.pdf' target="blank">View as PDF</a></span></h2>
            </div>
            <div class="row">
                <div class="accordion" id="accordion-parent">
                    <div class="accordion-group">
                        <div class="accordion-toggle accordion-selected" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapse1">
                            <i class="icon12-previous"></i>
                            <a>How to set/reset your password</a>
                        </div><!-- /.accordion-toggle-->
                        <div id="collapse1" class="accordion-body collapse in">
                            <div class="accordion-inner">
                                Step 1: From the log in screen, click on the <a href='../../public/requestreset.jsp'>Forgot Password</a> link. <br/>
                                Step 2: Enter your Scripps Networks Email Address and press the <strong>Submit Request</strong> button.<br/>
                                Step 3: Given this website utilizes a single sign-on feature, if you cannot log in, there could be a problem with your network password. You should receive the following error message, “As a Scripps employee, you must request a password reset using the procedure outlined by the help desk. Please cancel and contact the Help Desk if you need further assistance.”<br/>
                            </div>
                        </div><!--/#collapse1-->
                    </div><!--/.accordion-group-->
                    <div class="accordion-group">
                        <div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapse2">
                            <i class="icon12-previous"></i>
                            <a>How to rank a theme</a>
                        </div><!-- /.accordion-toggle-->
                        <div id="collapse2" class="accordion-body collapse">
                            <div class="accordion-inner">Step 1: Click on the <strong>Themes</strong> drop down menu and select <em>Rank Preferred Themes</em>. <br/>
                                Step 2a: Using the drag and drop feature, select the theme(s) you want to rank from the <strong>Available Presentation Themes</strong> section and drop them over to the <strong>Presentation Themes I’m Interested In</strong> section. <br/>
                                Step 2b: Using the non drag and drop feature, click on the themes you want to rank. The order in which you select the themes is the order in which they will be ranked.<br/>
                                Step 3: Once all the themes you want to rank have been selected, press the <strong>Submit My Ranking</strong> button. <br/><br/>
                                <strong>- This feature will only be made available for a limited time. <br/>
                                - Ten (10) is the maximum number of themes available to be ranked.</strong>
                            </div>
                        </div><!--/#collapse2-->
                    </div><!--/.accordion-group-->
                    <div class="accordion-group">
                        <div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapse3">
                            <i class="icon12-previous"></i>
                            <a>How to rank a speaker</a>
                        </div><!-- /.accordion-toggle-->
                        <div id="collapse3" class="accordion-body collapse">
                            <div class="accordion-inner">
                                Step 1: Click on the <strong>Speakers</strong> drop down menu and select <em>Rank Preferred Speakers</em>. <br/>
                                Step 2a: Using the drag and drop feature, select the speaker(s) you want to rank from the <strong>Available Speakers</strong> section and drop them over to the <strong>Speakers I’m Interested In</strong> section.<br/>
                                Step 2b: Using the non drag and drop feature, click on the speakers you want to rank. The order in which you select the speakers is the order in which they will be ranked.<br/>
                                Step 3: Once all the speakers you want to rank have been selected, press the <strong>Submit My Ranking</strong> button. <br/><br/>
                                <strong>- This feature will only be made available for a limited time. <br/>
                                - Ten (10) is the maximum number of speakers available to be ranked.</strong>
                            </div>
                        </div><!--/#collapse3-->
                    </div><!--/.accordion-group-->
                    <div class="accordion-group">
                        <div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapse4">
                            <i class="icon12-previous"></i>
                            <a>How to suggest a theme</a>
                        </div><!-- /.accordion-toggle-->
                        <div id="collapse4" class="accordion-body collapse">
                            <div class="accordion-inner">
                                Step 1: Click on the <strong>Themes</strong> drop down menu and select <em>Suggest A New Theme</em>. <br/>
                                Step 2: Fill out the form and press the <strong>Submit Suggestion</strong> button. <br/><br/>
                                <strong>- This feature will only be made available for a limited time.</strong>
                            </div>
                        </div><!--/#collapse4-->
                    </div><!--/.accordion-group-->
                    <div class="accordion-group">
                        <div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapse5">
                            <i class="icon12-previous"></i>
                            <a>How to suggest a speaker</a>
                        </div><!-- /.accordion-toggle-->
                        <div id="collapse5" class="accordion-body collapse">
                            <div class="accordion-inner">
                                Step 1: Click on the <strong>Speakers</strong> drop down menu and select <em>Suggest A New Speaker</em>. <br/>
                                Step 2: Fill out the form and press the <strong>Submit Suggestion</strong> button. <br/><br/>
                                <strong>- This feature will only be made available for a limited time.</strong>
                            </div>
                        </div><!--/#collapse5-->
                    </div><!--/.accordion-group-->
                    <div class="accordion-group">
                        <div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapse6">
                            <i class="icon12-previous"></i>
                            <a>How to provide your interest for a Techtoberfest topic</a>
                        </div><!-- /.accordion-toggle-->
                        <div id="collapse6" class="accordion-body collapse">
                            <div class="accordion-inner">
                                Step 1: Click on the <strong>Sessions</strong> drop down menu and select <em>View Session Schedule</em>. <br/>
                                Step 2: Review the proposed schedule<br/>
                                Step 3: Select the <a href='../../private/employee/sessioninterest.jsp'>Interested in a session</a> link, located below the session schedule table.<br/>
                                Step 4: Select the topic(s) you are interested in attending and press the <strong>Submit Interest</strong> button. <br/><br/>
                                <strong>- This feature will only be made available for a limited time.</strong>
                            </div>
                        </div><!--/#collapse6-->
                    </div><!--/.accordion-group-->
                    <div class="accordion-group">
                        <div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapse7">
                            <i class="icon12-previous"></i>
                            <a>How to provide session feedback</a>
                        </div><!-- /.accordion-toggle-->
                        <div id="collapse7" class="accordion-body collapse">
                            <div class="accordion-inner">
                                Step 1: Click on the <strong>Sessions</strong> drop down menu and select <em>Submit Session Feedback</em>. <br/>
                                Step 2: Complete the survey wizard<br/><br/>
                                <strong>- If a session survey is completed within 30 minutes of you attending that session, your name will be entered into a raffle drawing. <br/>
                                - Session surveys can be submitted at any time</strong>
                            </div>
                        </div><!--/#collapse7-->
                    </div><!--/.accordion-group-->              
                </div><!--/.accordion-->
            </div>
        </div>
        <%@ include file="../../includes/footer.jsp" %> 
        <%@ include file="../../includes/scriptlist.jsp" %>
        <script>
            $(document).ready(function() {
                $(".accordion-toggle").click(function() {
                    $('.accordion-toggle').removeClass("accordion-selected");
                    $(this).addClass("accordion-selected");
                });
            });

        </script>
    </body>
</html>