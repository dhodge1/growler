<%-- 
    Document   : themeentry
    Created on : Feb 27, 2013, 12:17:43 AM
    Author     : Justin Bauguess and Jonathan C. McCowan
    Purpose    : This page is for users to suggest themes for review
                it uses model/processThemeSuggestion.jsp to process the data.
                The table used is theme.  The fields in the table that are
                modified are name, description, reason (as entered by
                the user), and creator and visible (which are the user id
                 and "0" or false as default).
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

        <title>Theme Entry</title>

        <link rel="stylesheet" href="../../css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="../../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../../css/prettify/prettify.css" /> 
        <link rel="stylesheet" type="text/css" href="../../css/general.css" /><!--General CSS-->
        <script src="../../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <style>
            .message_container {
                display: none;
                color: red;
                font-weight: bold;
            }
        </style>
    </head>
    <body id="growler1">
        <%
                    int user = 0;
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
            <div class="row">
                <br/>
                    <h1>Theme Suggestions</h1>
                    <h3>Is there something you would like to see presented or discussed this year?  
                    Feel free to submit your ideas here.</h3>
                
            </div>
            <br/><br/><br/>
            <div class="row">
                
                    <h2 class="bordered"><img src='../../images/Techtoberfest2013small.png'/><span>Suggest a New Theme</span></h2>
                
            </div>
            <br/>
            <div class="row">
                
                    <form method="POST" id="action" action="../../action/processThemeSuggestion.jsp">
                        <fieldset>
                            <div class="form-group">
                                <label class="required">Theme Name</label>
                                <input required="required" name="name" class="input-xlarge" type="text" id="tip" data-content="30 characters or less please" maxlength="30"/>
                                <span id="error_theme_name" class="message_container">
                                    <span>Please enter a Theme Name</span>
                                </span>
                            </div>
                            <div class="form-group">
                                <label class="required">Theme Description</label>
                                <input required="required" name="description" class="input-xlarge" type="text" id="tip2" data-content="250 characters or less please" maxlength="250"/>
                                <span id="error_theme_description" class="message_container">
                                    <span>Please enter a Theme Description</span>
                                </span>
                            </div>
                            <div class="form-group">
                                <label>Why should we implement this theme?</label>
                                <input name="reason" class="input-xlarge" type="text" id="tip3" data-content="Help us understand what this theme suggestion means to you" maxlength="250"/>
                            </div>
                            <div class="form-actions">
                                <input type="submit" id="send" class="button button-primary" value="Submit" />
                                <a class="button" id="cancel" href="theme.jsp">Cancel</a>
                            </div>
                        </fieldset>
                </form>
                
            </div>
        </div>
        <br/>
        <br/>

        <%@ include file="../../includes/footer.jsp" %> 
        <%@ include file="../../includes/scriptlist.jsp" %>

        <!--Additional Script-->
        <script src="../../js/themeentry.js"></script>
    </body>
</html>
