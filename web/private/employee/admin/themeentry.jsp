<%-- 
    Document   : themeentry
    Created on : Feb 27, 2013, 12:17:43 AM
    Author     : Justin Bauguess & Jonathan C. McCowan
    Purpose    : The purpose of themeentry is to allow the administrator to
                enter a theme into the database.  By default, it will not be 
                visible.  This can be changed with the admin/theme.jsp file.  It 
                uses the same action file (processThemeSuggestion) but will forward
                to a different page based on being an admin (or not).
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

        <link rel="stylesheet" href="../../../css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="../../../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../../../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../../../css/prettify/prettify.css" /> 
        <link rel="stylesheet" type="text/css" href="../../../css/general.css" /><!--General CSS-->

        <script src="../../../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%
            int user = 0;
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../../../index.jsp");
            } else if (!session.getAttribute("user").equals("admin")) {
                response.sendRedirect("../../../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
        %>

        <%@ include file="../../../includes/adminheader.jsp" %> 
        <%@ include file="../../../includes/adminnav.jsp" %>  
        <div class="container-fixed">
            <br/><br/><br/>
            <div class="row">
                <div class="span8">
                    <h2 class="bordered"><img src='../../../images/Techtoberfest2013small.png'/>Add a Theme</h2>
                </div>
            </div>
            <br/>
            <div class="row">
                <div class="span8">
                    <form method="POST" id="action" action="../../../action/processThemeSuggestion.jsp">
                        <fieldset>
                            <div class="form-group">
                                <label class="required">Theme Name</label>
                                <input required="required" name="name" class="input-xlarge" type="text" id="tip" data-content="30 characters or less please" maxlength="30"/>
                            </div>
                            <div class="form-group">
                                <label class="required">Theme Description</label>
                                <input required="required" name="description" class="input-xlarge" type="text" id="tip2" data-content="250 characters or less please" maxlength="250"/>
                            </div>
                            <div class="form-actions">
                                <input class="button button-primary" id="send" type="submit" value="Send" name="Submit" />
                                <a class="button" id="cancel" href="theme.jsp">Cancel</a>
                            </div>
                        </fieldset>
                    </form>		
                </div>
            </div>
        </div>

        <%@ include file="../../../includes/footer.jsp" %> 
        <%@ include file="../../../includes/scriptlist.jsp" %>

        <!--Additional Script-->
        <script>
            $(function() {
                $("input").autoinline();
            });
            $("#send").click(function(event) {
                var emptyString = "";
                var str1 = $("#tip").val();
                var str2 = $("#tip2").val();
                if ($.trim(str1) === emptyString || $.trim(str2) === emptyString) {
                    alert("Please enter both a theme name and theme description before submitting.");
                    event.preventDefault();
                }
                else {
                    $("#action").attr("action", "../../../action/processThemeSuggestion.jsp");
                }
            });
        </script>
    </body>
</html>
