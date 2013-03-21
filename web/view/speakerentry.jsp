<%-- 
    Document   : speakerentry
    Created on : Feb 27, 2013, 11:55:19 PM
    Author     : Robert Brown
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
  <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
</head>
    <body id="growler1">
    <%@ include file="../includes/header.jsp" %> 
    <nav class="globalNavigation">
        <ul>
            <li><a href="../view/theme.jsp">Themes</a></li>
            <li><a href="../view/themeentry.jsp">Suggest a Theme</a></li>
            <li><a href="../view/speaker.jsp">Speakers</a></li>
            <li class="selected"><a href="../view/speakerentry.jsp">Suggest a Speaker</a></li>
            <li><a href="">Help</a></li>
        </ul>
  </nav><!-- /.globalNavigation -->
  <div class="container-fixed">
		<div class="content">
			<!-- Begin Content -->
		<div class="row">
			<div class="span8">
			<img class="logo" src="../images/Techtoberfest2013.png" alt="Techtoberfest 2013"/>
			<h1 class = "bordered">Suggest a Speaker</h1>
				<!-- Techtoberfest logo + "2013 Themes" -->
			</div>
		</div>
		</div>
 
    <div class="container-fluid">
        <div class="content" role="main"> 
            <form method="POST" action="../model/processSpeakerSuggestion.jsp">
                    <div class="span4">
                        <fieldset>
                            <div class="form-group">
                                <label class="required">Speaker First Name</label>
                                <input name="first_name" class="input-xlarge" type="text" maxlength="30"/>
                            </div>
                            <div class="form-group">
                                <label class="required">Speaker Last Name</label>
                                <input name="last_name" class="input-xlarge" type="text" maxlength="30"/>
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
<%@ include file="../includes/scriptlist.jsp" %>
</body>
</html>
