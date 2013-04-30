<%-- 
    Document   : themeentry
    Created on : Feb 27, 2013, 12:17:43 AM
    Author     : Robert Brown
    Purpose    : The purpose of themeentry is to allow the administrator to
                enter a theme into the database.  By default, it will not be 
                visible.  This can be changed with the admin/theme.jsp file.  It 
                uses the same model file (processThemeSuggestion) but will forward
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
    <title></title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  
    <link rel="stylesheet" href="../../css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
 
  <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
  <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
  <script src="js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
</head>
    <body id="growler1">
        <%@include file="../includes/isadmin.jsp" %>
    <%@ include file="../includes/header.jsp" %> 
  <%@ include file="../includes/adminnav.jsp" %>
  <div class="container-fixed">
		<div class="content">
			<!-- Begin Content -->
		<div class="row">
			<div class="span8">
			<img class="logo" src="../images/Techtoberfest2013.png" alt="Techtoberfest 2013"/>
			<h1 class = "bordered">Add a Theme</h1>
				<!-- Techtoberfest logo + "2013 Themes" -->
			</div>
		</div>
		</div>
 
    <div class="container-fluid">
        <div class="content" role="main"> 
            <form method="POST" action="../model/processThemeSuggestion.jsp">
                    <div class="span4">
                        <fieldset>
                            <div class="form-group">
                                <label class="required">Theme Name</label>
                                <input name="name" class="input-xlarge" type="text" maxlength="30"/>
                            </div>
                            <div class="form-group">
                                <label class="required">Theme Description</label>
                                <input name="description" class="input-xlarge" type="text" maxlength="250"/>
                            </div>
                        </fieldset>
                    </div>                   
                </div>
 
                <div class="form-actions">
                    <input class ="button button-primary" type = "submit" name = "Submit" value="Send" />
                    <a class="action" href="index.jsp">Cancel</a>
                </div>
            </form>
        </div><!-- /.content -->
    </div><!-- /.container-fluid -->
 
<%@ include file="../includes/footer.jsp" %> 
 
    <script src="../../js/libs/jquery-1.8.3.min.js" type="text/javascript"></script>
</body>
</html>