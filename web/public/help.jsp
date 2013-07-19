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
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%@ include file="../includes/indexheader.jsp" %> 
        <div class="container-fixed largeBottomMargin">
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="home.jsp">Home</a></li>
                    <li>Help</li>
                </ul>
            </div>
            <div class="row">
                    <h1 class="mediumBottomMargin">Techtoberfest Information System (TIS)</h1>
                    <h3>TIS allows Scripps Employees the ability to not only stay abreast 
                        of all Techtoberfest sessions, but also the opportunity to provide 
                        valuable session feedback before, during, and after the event!</h3>
            </div>
            <div class="row">
                <h2 class="bordered"><img id="logo" style="padding-left:0;padding-bottom:0;" src='../images/Techtoberfest2013small.png'/><span class="titlespan">Help Topics</span></h2><span class="pullRight">View in PDF</span>
            </div>
            <div class="row">
                <div class="accordion" id="accordion-parent">
                    <div class="accordion-group">
                        <div class="accordion-toggle accordion-selected" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapse1">
                            <i class="icon12-previous"></i>
                            <a>How Do I Rate a Theme?</a>
                        </div><!-- /.accordion-toggle-->
                        <div id="collapse1" class="accordion-body collapse in">
                            <div class="accordion-inner">To Rate a Theme, click on Themes tab.  Drag and drop to rearrange
                                the themes in the order you want to rate them.  Only the top ten
                                themes will be ranked.  After rearranging the speakers click 
                                "Submit" at the bottom of the page.  The ratings for the top ten 
                                themes will then be saved.
                            </div>
                        </div><!--/#collapse1-->
                    </div><!--/.accordion-group-->
                    <div class="accordion-group">
                        <div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapse2">
                            <i class="icon12-previous"></i>
                            <a>How Do I Suggest a Theme?</a>
                        </div><!-- /.accordion-toggle-->
                        <div id="collapse2" class="accordion-body collapse">
                            <div class="accordion-inner">To Suggest a Theme, click on the Themes tab.  Type in the name of 
                                the theme (30 character max),the description (250 character max),
                                and a reason (optional, 250 character max).  Click "Submit."  
                                The theme will be saved.<br/><br/>Suggested themes will not be visible until they are made so by 
                                the administrator.
                            </div>
                        </div><!--/#collapse2-->
                    </div><!--/.accordion-group-->
                    <div class="accordion-group">
                        <div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapse3">
                            <i class="icon12-previous"></i>
                            <a>How Do I Rate a Speaker?</a>
                        </div><!-- /.accordion-toggle-->
                        <div id="collapse3" class="accordion-body collapse">
                            <div class="accordion-inner">To Rate a Speaker, click on the speakers tab.  Drag and drop to rearrange
                                the speaker's names in the order you want to rate them.  Only the top
                                ten speakers will be ranked.  After rearranging the speakers click 
                                "Submit" at the bottom of the page.  The ratings for those speakers 
                                will then be saved.
                            </div>
                        </div><!--/#collapse3-->
                    </div><!--/.accordion-group-->
                    <div class="accordion-group">
                        <div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapse4">
                            <i class="icon12-previous"></i>
                            <a>How Do I Suggest a Speaker?</a>
                        </div><!-- /.accordion-toggle-->
                        <div id="collapse4" class="accordion-body collapse">
                            <div class="accordion-inner">To Suggest a Speaker, click on Suggest a Speaker tab.  Type in the 
                                first name of the speaker (30 character max) and the last name
                                of the speaker (30 character max).  Click "Submit".  The theme 
                                will be saved.<br/><br/>Suggested speakers will not be visible until they are made so by 
                                the administrator.
                            </div>
                        </div><!--/#collapse4-->
                    </div><!--/.accordion-group-->
                    <div class="accordion-group">
                        <div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapse5">
                            <i class="icon12-previous"></i>
                            <a>How Do I Attend a Session?</a>
                        </div><!-- /.accordion-toggle-->
                        <div id="collapse5" class="accordion-body collapse">
                            <div class="accordion-inner">After you attend the session the speaker will provide you with a code to verify your attendance.
                                <br/><br/>You can acknowledge your attendance from the end of the session until 15 minutes after the session ends.
                            </div>
                        </div><!--/#collapse5-->
                    </div><!--/.accordion-group-->
                    <div class="accordion-group">
                        <div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapse6">
                            <i class="icon12-previous"></i>
                            <a>How Do I Fill Out a Survey?</a>
                        </div><!-- /.accordion-toggle-->
                        <div id="collapse6" class="accordion-body collapse">
                            <div class="accordion-inner">Once you have acknowledged attendance, you may visit the Survey List page to view the surveys you are eligible to take.  Click on a link to take a survey.
                            </div>
                        </div><!--/#collapse6-->
                    </div><!--/.accordion-group-->
                    <div class="accordion-group">
                        <div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapse7">
                            <i class="icon12-previous"></i>
                            <a>How Do I Show Interest in a Future Session</a>
                        </div><!-- /.accordion-toggle-->
                        <div id="collapse7" class="accordion-body collapse">
                            <div class="accordion-inner">Visit the View Session Schedule page, and click on as many sessions as you are interested in.  You may also remove interest in a session from that page.
                            </div>
                        </div><!--/#collapse7-->
                    </div><!--/.accordion-group-->
                    <div class="accordion-group">
                        <div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapse8">
                            <i class="icon12-previous"></i>
                            <a>How Do I Set/Reset My Password?</a>
                        </div><!-- /.accordion-toggle-->
                        <div id="collapse8" class="accordion-body collapse">
                            <div class="accordion-inner">At the login page you may decide to register as a new user or click the "forgot my password" link to reset your password.
                            </div>
                        </div><!--/#collapse8-->
                    </div><!--/.accordion-group-->
                    <div class="accordion-group">
                        <div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapse9">
                            <i class="icon12-previous"></i>
                            <a>How Do I Leverage my Corporate Credentials?</a>
                        </div><!-- /.accordion-toggle-->
                        <div id="collapse9" class="accordion-body collapse">
                            <div class="accordion-inner">Visit the link at the Log-In screen that says "Register Corporate Credentials".  Once you sign-in, you will automatically be added to the Techtoberfest Information System.
                            </div>
                        </div><!--/#collapse9-->
                    </div><!--/.accordion-group-->                
                </div><!--/.accordion-->
            </div>
        </div>
        <%@ include file="../includes/footer.jsp" %> 
        <%@ include file="../includes/scriptlist.jsp" %>
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