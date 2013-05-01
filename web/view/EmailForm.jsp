<%-- 
    Document   : emailform
    Created on : Modified on 5/1/2013 by JCM
    Author     : Christopher Tupps & Jonathan C. McCowan
    Purpose    : This page allows users to enter their email address
				 to change their password
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
	
	<title>Password Reset</title>
  
	<link rel="stylesheet" href="../css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
	<link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
	<link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
	<link rel="stylesheet" href="../css/prettify/prettify.css" /> 
	<link rel="stylesheet" type="text/css" href="../css/general.css" /><!--General CSS-->
  
    <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->	
</head>
<body id="growler1">
    <%@ include file="includes/header.jsp" %> 
	<div class="row">
		<div class="span3">
			<img class="logo" src="../images/Techtoberfest2013small.png" alt="Techtoberfest 2013 small"/>
		</div>
		<div class="span5">
			<h1 class = "bordered largeBottomMargin">Password Recovery</h1>
		</div>
	</div>
	<div class="container-fluid">
		<div class="content" role="main">
		<!-- Begin Content -->
			<form method="POST" id="action" action="../../src/java/com/scripps/growler/EmailSendingServlet.java">
				<div class="span5 offset3">
					<fieldset>
						<div class="form-group">
							<label class="required">Please Enter Your Email Address</label>
							<input name="name="recipient" class="input-xlarge" type="text" id="tip" data-content="Enter the email address you would like your password reset link to be sent to." maxlength="60"/>
						</div>
						<div class="form-actions">
							<a class="button button-primary" id="send" type="submit">Send</a>
							<a class="button" id="cancel" href="http://ps11.pstcc.edu:8584/ProjectGrowler/index.jsp">Cancel</a>
						</div>
					</fieldset>
				</div>   
			</form>		
		</div><!-- /.content -->
	</div><!-- /.container-fluid -->
         
    </form>
    <%@ include file="includes/footer.jsp" %> 
	<%@ include file="../includes/scriptlist.jsp" %>
		
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="../js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
	<script src=".../js/libs/jquery-1.8.3.min.js" type="text/javascript"></script>
	<script src="../js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
	<script src="../js/libs/sniui.auto-inline-help.min.js" type="text/javascript"> </script>
	<script src="../js/libs/sniui.auto-inline-help.1.0.0.min.js" type="text/javascript"></script>
	
	<!--Additional Script-->
	<script>
	$(function () {
		$("#tip").autoinline();
    });
	$("#send").click(function(){
		var emptyString = "";
		if($("#tip").val() === emptyString) {
			$("#action").attr("action","");
			alert("Please enter an email address before submitting.");
		}
		else{
			$("#action").attr("action","../../src/java/com/scripps/growler/EmailSendingServlet.java");
		}
	});
	</script>
</body>
</html>
