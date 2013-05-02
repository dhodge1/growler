<%-- 
    Document   : help
    Author     : Justin Bauguess & Jonathan C. McCowan
    Purpose    : The purpose of help(user) is to give users information to help navigate all other pages.
--%>
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
	<meta name="description" content="" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<title>Help Page</title>
  
	<link rel="stylesheet" href="../css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
	<link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
	<link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
	<link rel="stylesheet" href="../css/demo.css" />
	<link rel="stylesheet" href="../css/prettify/prettify.css" /> 
	<link rel="stylesheet" href="../css/wijmo/jquery.wijmo-complete.all.2.3.2.min.css"/>
	<link rel="stylesheet" type="text/css" href="../css/general.css" /><!--General CSS-->
	<link rel="stylesheet" type="text/css" href="../css/help.css" /><!--Help CSS-->
  
    <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->	
</head>
<body id="growler1">
	<%@ include file="../includes/header.jsp" %> 
    <%@ include file="../includes/usernav.jsp" %>
	
	<div class="row">
		<div class="span3">
			<img class="logo" src="../images/Techtoberfest2013small.png" alt="Techtoberfest 2013 small"/>
		</div>
		<div class="span8">
			<h1 class = "bordered" >Help Topics</h1>
		</div>
    </div>
	</br>
    <div class="row"><!--row-->
	  <div class="span7 offset3">
		<div class="accordion" id="accordion-parent">
		  <div class="accordion-group">
			<div class="accordion-toggle accordion-selected" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapseOne">
			  <i class="icon12-previous"></i>
			  <a>How Do I Rate a Theme?</a>
			</div><!-- /.accordion-toggle-->
			<div id="collapseOne" class="accordion-body collapse in">
			  <div class="accordion-inner">To Rate a Theme, click on Themes tab.  Drag and drop to rearrange
				the themes in the order you want to rate them.  Only the top ten
				themes will be ranked.  After rearranging the speakers click 
				"Submit" at the bottom of the page.  The ratings for the top ten 
				themes will then be saved.
			  </div>
			</div><!--/#collapseOne-->
		  </div><!--/.accordion-group-->
		  <div class="accordion-group">
			<div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapseTwo">
			  <i class="icon12-previous"></i>
			  <a>How Do I Suggest a Theme?</a>
			</div><!-- /.accordion-toggle-->
			<div id="collapseTwo" class="accordion-body collapse">
			  <div class="accordion-inner">To Suggest a Theme, click on the Themes tab.  Type in the name of 
				the theme (30 character max),the description (250 character max),
				and a reason (optional, 250 character max).  Click "Submit."  
				The theme will be saved.</br></br>Suggested themes will not be visible until they are made so by 
				the administrator.
			  </div>
			</div><!--/#collapseTwo-->
		  </div><!--/.accordion-group-->
		  <div class="accordion-group">
			<div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapseThree">
			  <i class="icon12-previous"></i>
			  <a>How Do I Rate a Speaker?</a>
			</div><!-- /.accordion-toggle-->
			<div id="collapseThree" class="accordion-body collapse">
			  <div class="accordion-inner">To Rate a Speaker, click on the speakers tab.  Drag and drop to rearrange
				the speaker's names in the order you want to rate them.  Only the top
				ten speakers will be ranked.  After rearranging the speakers click 
				"Submit" at the bottom of the page.  The ratings for those speakers 
				will then be saved.
			  </div>
			</div><!--/#collapseThree-->
		  </div><!--/.accordion-group-->
		  <div class="accordion-group">
			<div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapseFour">
			  <i class="icon12-previous"></i>
			  <a>How Do I Suggest a Speaker?</a>
			</div><!-- /.accordion-toggle-->
			<div id="collapseFour" class="accordion-body collapse">
			  <div class="accordion-inner">To Suggest a Speaker, click on Suggest a Speaker tab.  Type in the 
				first name of the speaker (30 character max) and the last name
				of the speaker (30 character max).  Click "Submit".  The theme 
				will be saved.</br></br>Suggested speakers will not be visible until they are made so by 
				the administrator.
			  </div>
			</div><!--/#collapseFour-->
			</div><!--/.accordion-group-->
		  <div class="accordion-group">
			<div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapseFive">
			  <i class="icon12-previous"></i>
			  <a>How Do I Attend a Session?</a>
			</div><!-- /.accordion-toggle-->
			<div id="collapseFive" class="accordion-body collapse">
			  <div class="accordion-inner">After you attend the session the speaker will provide you with a code to verify your attendance.
			  </div>
			</div><!--/#collapseFive-->
			</div><!--/.accordion-group-->
		  <div class="accordion-group">
			<div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapseSix">
			  <i class="icon12-previous"></i>
			  <a>How Do I Fill Out a Survey?</a>
			</div><!-- /.accordion-toggle-->
			<div id="collapseSix" class="accordion-body collapse">
			  <div class="accordion-inner">After receiving the attendance code at the end of a session you will have the option to fill out a survey either right then or in the future.
			  </div>
			</div><!--/#collapseSix-->
			</div><!--/.accordion-group-->
		  <div class="accordion-group">
			<div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapseSeven">
			  <i class="icon12-previous"></i>
			  <a>How Do I undo Attendance to a Session?</a>
			</div><!-- /.accordion-toggle-->
			<div id="collapseSeven" class="accordion-body collapse">
			  <div class="accordion-inner">I don't know that myself!?
			  </div>
			</div><!--/#collapseSeven-->
			</div><!--/.accordion-group-->
		  <div class="accordion-group">
			<div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapseEight">
			  <i class="icon12-previous"></i>
			  <a>How Do I Set/Reset My Password?</a>
			</div><!-- /.accordion-toggle-->
			<div id="collapseEight" class="accordion-body collapse">
			  <div class="accordion-inner">At the login page you may decide to register as a new user or click the "forgot my password" link to reset your password.
			  </div>
			</div><!--/#collapseEight-->
			</div><!--/.accordion-group-->
		  <div class="accordion-group">
			<div class="accordion-toggle" data-toggle="collapse" data-parent="#accordion-parent" data-target="#collapseNine">
			  <i class="icon12-previous"></i>
			  <a>How Do I Leverage my Corporate Credentials?</a>
			</div><!-- /.accordion-toggle-->
			<div id="collapseNine" class="accordion-body collapse">
			  <div class="accordion-inner">You simply log in with your corporate credentials or you may decide to register as a new user to make your own separate account at the log in page.
			  </div>
			</div><!--/#collapseNine-->
		  </div><!--/.accordion-group-->                
		</div><!--/.accordion-->
	  </div><!-- /.span4 -->
	</div><!--end row-->	
	</br>
	</br>		  
	<%@ include file="../includes/footer.jsp" %> 
	<%@ include file="../includes/scriptlist.jsp" %>
    </body>
</html>
