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
        <link rel="stylesheet" href="http://growler-dev.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler-dev.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../../../css/draganddrop.css" /><!--Drag and drop style-->
        <script src="http://growler-dev.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
        <link rel="stylesheet" type="text/css" href="css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="css/help.css" /><!--Help CSS-->
        <title>Edit Theme</title>
    </head>
    <body id="growler1">
        <%
            int user = 0;
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../../../index.jsp");
           // } else if (!session.getAttribute("role").equals("admin")) {
           //     response.sendRedirect("../../../index.jsp");
          //  }
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
        %>
        <%
            int themeId = (Integer.parseInt(request.getParameter("id")));
            ThemePersistence tp = new ThemePersistence();
            Theme theme = tp.getThemeByID(themeId);
        %>
        <%@ include file="../../../includes/adminheader.jsp" %> 
        <%@ include file="../../../includes/adminnav.jsp" %>
        <div class="container-fixed">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="../../../private/employee/admin/home.jsp">Home</a></li>
                    <li class='ieFix'>Edit Theme</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="margin-top:0px;font-weight: normal;">Edit Theme</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row mediumBottomMargin">
                <label><span style="color: red;">*</span>Required field</label>
            </div>
            <div class="row mediumBottomMargin">
                    <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='http://growler-dev.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span class="titlespan">Theme Details</span></h2>
            </div>
            <div class="row">
                <form method="post" action="../../../action/processThemeEdit.jsp">
                    <div class="form-group">
                        <label class="required">Theme name</label>
                        <input id="name" name="name" type="text" data-content="Enter the name of the Theme" value="<% out.print(theme.getName());%>" maxlength="30"/>
                        <input name="id" type="hidden" value="<% out.print(theme.getId());%>" />
                    </div>
                    <div class="form-group">
                        <label class="required">Theme description</label>
                        <input name="description" id="description" type="text" data-content="Enter the Description" value="<% out.print(theme.getDescription());%>" maxlength="250"/>
                    </div>
                    <div class="form-group">
                        <label class="required">Theme category</label>
                        <select name="category">
                            <option value="0"> Select a Category </option>
                            <option value="Business" <% //if (theme.getType().equals("Business")) { out.print("selected"); } %>>Business</option>
                            <option value="Technical" <% //if (theme.getType().equals("Technical")) { out.print("selected"); } %>>Technical</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="required">Theme added by</label>
                        <input name="creator" id="creator" type="text" data-content="Enter a Creator ID for the Theme" value="<% out.print(theme.getCreatorId());%>"/>
                    </div>
                    <div class="form-group">
                        <input type='checkbox' name='visible' <% if (theme.getVisible()) { out.print(" checked ");} %> />
                        <label class="required">Make theme visible to users?</label>
                    </div>
                    <input type="submit" value="Submit" class="button button-primary"/>
                </form>
            </div>
        </div>
        <%@ include file="../../../includes/footer.jsp" %> 
        <%@ include file="../../../includes/scriptlist.jsp" %>
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