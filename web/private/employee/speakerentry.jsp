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
        <link rel="shortcut icon" type="image/png" href="http://growler.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/prettify/prettify.css" /> 
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/general.css" /><!--General CSS-->
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->	
        <style>
            .message_container {
                display: none;
                color: red;
                font-weight: bold;
            }
            h3 {
                font-weight:normal;
            }
            #themeImg {
                height: 95%;
                width: 95%;
                border-radius: 50px;
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
        <div class="container-fixed mediumBottomMargin">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                    <li>Suggest a New Speaker</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="font-weight:normal;">Suggest a New Speaker</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>Is there a new speaker you would like to suggest for this year's Techtoberfest?  We would LOVE to know more about them.</h3>
            </div>
            <div class="row mediumBottomMargin">
                <label><span style="color: red;">*</span>Required field</label>
            </div>
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-left:0px;padding-bottom:0px;" src="${pageContext.request.contextPath}/images/Techtoberfest2013small.png"/><span class="titlespan">Suggestion Details</span></h2>
            </div>
            <div class="row">
                    <div class="span6">
                        <form method="POST" id="action" action="${pageContext.request.contextPath}/action/processSpeakerSuggestion.jsp">
                            <fieldset>
                                <div class="form-group inline">
                                    <label class="required">Speaker First Name</label>
                                    <input required="required" name="first_name" class="input-xlarge" type="text" id="tip" data-content="Please enter no more than 30 characters" maxlength="30"/>
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
                                <!--
                                *****************************************************************
                                ***********Thuy:add an input field for email address*************
                                *****************************************************************
                                -->
                                <div class="form-group inline">
                                    <label class="required">Speaker Email Address</label>
                                    <input required="required" name="email" class="input-xlarge" type="text"/>  
                                    <span id="error_last" class="message_container">
                                          <span>Please enter a email address</span>
                                    </span>
                                </div>                      
                                <!--
                                //**************End of added code**********************************
                                //*****************************************************************
                                -->
                                <div class='form-group'>
                                    <label class='required'>What type of speaker is this?</label>
                                    <select name="type" id="tip3" class="input-xlarge" data-content="Choose a type: Business or Technical">
                                        <option value="0">Please Select a Type</option>
                                        <option value="Business">Business</option>
                                        <option value="Technical">Technical</option>
                                    </select><i style="margin-left: 3px;" id="spkrtypeHelp" class="icon12-info" data-content="Business Speakers - Any speaker providing technical information in a non-technical way, appealing to both IT and non-IT users.<br/><br/>Technical Speakers - Speakers with a technical background providing mid to high level technical information, appealing to mainly IT users with technical backgrounds." title="Speaker Types"></i>
                                    <br/><span id="error_type" class="message_container">
                                        <span>Please select a speaker type</span>
                                    </span>
                                </div>
                                <div class="form-group">
                                    <label>Why should this speaker be added to this year's Techtoberfest?</label>
                                    <textarea name="reason" id="tip4" data-content="Please enter no more than 250 characters" rows="5" cols="50" maxlength="250">
                                    </textarea>
                                </div>
                                <div class="form-actions">
                                    <input type="submit" id="send" class="button button-primary" value="Submit Suggestion"/>
                                    <a id="cancel" href="${pageContext.request.contextPath}/home">Cancel</a>
                                </div>
                            </fieldset> 
                    </form>	  
                </div>
                <div class="span6">
                    <img id="themeImg" src="${pageContext.request.contextPath}/images/theme.jpg" />
                </div>
            </div>
        </div>
        <%@ include file="../../includes/footer.jsp" %> 
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/sniui.auto-inline-help.min.js" type="text/javascript"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/sniui.auto-inline-help.1.0.0.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/libs/sniui.user-inline-help.1.2.0.min.js" type="text/javascript"></script>

        <!--additional script-->
        <script src="${pageContext.request.contextPath}/js/speaker.js"></script>
        <script>
            $(document).ready(function() {
                $('#spkrtypeHelp').userInlineHelp();
            });
        </script>
    </body>
</html>
