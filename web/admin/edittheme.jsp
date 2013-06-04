<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
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
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
          <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
        <link rel="stylesheet" type="text/css" href="css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="css/help.css" /><!--Help CSS-->
<title>Edit Theme</title>
</head>
<body id="growler1">
        <%@include file="../includes/isadmin.jsp" %>
        <%@ include file="../includes/header.jsp" %> 
        <%@ include file="../includes/adminnav.jsp" %>
        <%
                                    	int themeId = (Integer.parseInt(request.getParameter("id")));
                                        ThemePersistence tp = new ThemePersistence();
                                    	Theme theme = tp.getThemeByID(themeId);
                                    %>
        <div class="container-fixed">
            <div class="content">
                <!-- Begin Content -->
                <div class="row">
                    <div class="span12">
                        <img class="logo" src="../images/Techtoberfest2013admin.png" alt="Techtoberfest 2013"/>  <!-- Techtoberfest logo-->
                        <h1 class = "bordered">Edit a Theme : <% out.print(theme.getName()); %></h1>
                        <br/>
                        <br/>
                        <div id="tabs-1">
                            <div class="row">
                                <div class="span1">
                                    <br/>
                                    
                                </div>
                                <div class="span6 offset1">
                                    <section>
                                        <form method="post" action="../model/processThemeEdit.jsp" onSubmit="return validateValues();">
                                            <div class="form-group">
                                                <label class="required">Theme Name: </label>
                                                <input id="name" name="name" type="text" data-content="Enter the name of the Theme" value="<% out.print(theme.getName()); %>" maxlength="30"/>
                                                <input name="id" type="hidden" value="<% out.print(theme.getId()); %>" />
                                            </div>
                                            <div class="form-group">
                                                <label class="required">Theme Description: </label>
                                                <input name="description" id="description" type="text" data-content="Enter the Description" value="<% out.print(theme.getDescription()); %>" maxlength="250"/>
                                            </div>
                                            <div class="form-group">
                                                <label class="required">Theme Reason: </label>
                                                <input name="reason" id="reason" type="text" data-content="Enter a reason for the Theme" value="<% out.print(theme.getReason()); %>" maxlength="250"/>
                                            </div>
                                            <div class="form-group">
                                                <label class="required">Theme Creator: </label>
                                                <input name="creator" id="creator" type="text" data-content="Enter a Creator ID for the Theme" value="<% out.print(theme.getCreatorId()); %>"/>
                                            </div>
                                            <div class="form-group">
                                                <label class="required">Visible: </label>
                                                <input type="radio" name="visible" value="true"
                                                       <% if (theme.getVisible()) {
                                                           out.print("checked");
                                                       }%>/>True<br/>
                                                <input type="radio" name="visible" value="false"
                                                       <% if (!theme.getVisible()) {
                                                           out.print("checked");
                                                       }
                                                       %>/>False<br/>
                                            </div>
                                            <input type="submit" value="Submit" class="button button-primary"/>
                                        </form>
                                    </section>
                                </div>
                                <div class="span7">
                                    <p></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End Content -->
            </div>	
        </div>
        <div class="row">
            <div class="span8">
                <p></p>
            </div>
            <div class="span2">
            </div>
        </div>

        <%@ include file="../includes/footer.jsp" %> 
        <%@ include file="../includes/scriptlist.jsp" %>
        <script>
            $(function() {
                        $("input").autoinline();
                    });
            function validateValues() {
                var myname = document.getElementById("name");
                if (!myname.value) {
                    alert('Please enter a Session Name');
                    myname.focus();
                    return false;
                }
                var mydate = document.getElementById("description");
                if (!mydate.value) {
                    alert('Please enter a description');
                    mydate.focus();
                    return false;
                }
                var mylocation = document.getElementById("reason");
                if (!mylocation.value) {
                    alert('Please enter a reason');
                    mylocation.focus();
                    return false;
                }
                return true;
            }
        </script>
    </body>
</html>