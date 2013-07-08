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

        <title>Speaker Entry</title>

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
            <br/><br/><br/>
            <div class="row">
                
                    <h2 class="bordered"><img style="padding-bottom:0" src='../../images/Techtoberfest2013small.png'/><span class="titlespan">Suggest a Speaker</span></h2>
                
            </div>
            <br/>
            <div class="row">
                
                    <form method="POST" id="action" action="../../action/processSpeakerSuggestion.jsp">
                        <fieldset>
                            <div class="form-group">
                                <label class="required">Speaker First Name</label>
                                <input required="required" name="first_name" class="input-xlarge" type="text" id="tip" data-content="30 characters or less please" maxlength="30"/>
                                <br/><span id="error_first" class="message_container">
                                    <span>Please Enter a First Name</span>
                                </span>
                            </div>
                            <div class="form-group">
                                <label class="required">Speaker Last Name</label>
                                <input required="required" name="last_name" class="input-xlarge" type="text" id="tip2" data-content="30 characters or less please" maxlength="30"/>
                                <br/><span id="error_last" class="message_container">
                                    <span>Please Enter a Last Name</span>
                                </span>
                            </div>
                            <div class="form-actions">
                                <input type="submit" id="send" class="button button-primary" value="Send"/>
                                <a class="button" id="cancel" href="../../view/speaker.jsp">Cancel</a>
                            </div>
                        </fieldset> 
                </form>	
                
            </div>
        </div>
        <br/>
        <br/>
        <%@ include file="../../includes/footer.jsp" %> 
        <%@ include file="../../includes/scriptlist.jsp" %>

        <!--additional script-->
        <script src="../../js/speaker.js"></script>
    </body>
</html>
