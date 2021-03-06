<%-- 
    Document   : speakerentry
    Created on : Feb 27, 2013, 12:17:43 AM
    Author     : Justin Bauguess and Jonathan C. McCowan
    Purpose    : The purpose of speakerentry(user) is for users to suggest speakers
                to the Techtoberfest Admins.  It uses action/processSpeakerSuggestion.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
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

        <title>Nominate Yourself as a Speaker</title>
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
            #speaker2Img {
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
                        //response.sendRedirect("../../index.jsp");
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
                    <li>Nominate Yourself As A Speaker</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="font-weight:normal;">Nominate Yourself As A Speaker</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>Are you interested in speaking at this year's Techtoberfest?  Fill out the form below and share your presentation details with us!</h3>
            </div>
            <div class="row mediumBottomMargin">
                <label><span style="color: red;">*</span>Required field</label>
            </div>
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-left:0px;padding-bottom:0px;" src="${pageContext.request.contextPath}/images/Techtoberfest2013small.png"/><span class="titlespan">Suggestion Details</span></h2>
            </div>
            <div class="row">
                    <div class="span6">
                        <form method="POST" id="action" action="${pageContext.request.contextPath}/action/processNomination.jsp">
                            <fieldset>
                                <div class="form-group">
                                    <label class="required">Presentation topic</label>
                                    <input required="required" name="topic" class="input-xlarge" type="text" id="tip" data-content="Please enter no more than 60 characters" maxlength="60"/>
                                    <br/><span id="error_topic" class="message_container">
                                        <span>Please enter a presentation topic</span>
                                    </span>
                                </div>
                                <div class="form-group">
                                    <label class="required">Presentation description</label>
                                    <textarea cols='50' rows='5' required="required" name="description" id="tip2" data-content="Please enter no more than 250 characters" ></textarea>
                                    <br/><span id="error_description" class="message_container">
                                        <span>Please enter a presentation description</span>
                                    </span>
                                </div>
                                <div class='form-group'>
                                    <label class='required'>Presentation duration?</label>
                                    <select name="duration" id="tip3" class="input-xlarge" data-content="Choose a duration">
                                        <option value="0">Please Select a Duration</option>
                                        <option value="00:25:00">25 minutes</option>
                                        <option value="00:50:00">50 minutes</option>
                                    </select>
                                    <br/><span id="error_duration" class="message_container">
                                        <span>Please select a duration</span>
                                    </span>
                                </div>
                                <div class="form-group">
                                    <label class="required">What theme would best represent your presentation topic?</label>
                                    <select name='theme' id='tip4' class='input x-large'>
                                        <option value='0'> Please select a theme </option>
                                        <% ThemePersistence tp = new ThemePersistence();
                                        ArrayList<Theme> themes = tp.getThemesByVisibility(true);
                                        for (int i = 0; i < themes.size(); i++){
                                            out.print("<option value='" + themes.get(i).getId() + "'>");
                                            out.print(themes.get(i).getName());
                                            out.print("</option>");
                                        }
                                        %>
                                    </select>
                                    <br/><span id='error_theme' class='message_container'>
                                        <span>Please select a theme</span>
                                    </span>
                                </div>
                                <div class="form-actions">
                                    <input type="submit" id="send" class="button button-primary" value="Submit Nomination"/>
                                    <a id="cancel" href="${pageContext.request.contextPath}/home">Cancel</a>
                                </div>
                            </fieldset> 
                    </form>	 
                </div>
                <div class="span6">
                    <img id="speaker2Img" src="${pageContext.request.contextPath}/images/theme2.jpg" />
                </div>
            </div>
        </div>
        <%@ include file="../../includes/footer.jsp" %> 
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/sniui.auto-inline-help.min.js" type="text/javascript"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/sniui.auto-inline-help.1.0.0.min.js" type="text/javascript"></script>

        <!--additional script-->
        <script src="${pageContext.request.contextPath}/js/nomination.js"></script>
    </body>
</html>
