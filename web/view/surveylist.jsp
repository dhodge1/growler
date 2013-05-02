<%-- 
    Document   : surveylist
    Created on : Apr 25, 2013, 7:15:03 PM
    Author     : Justin Bauguess
    Purpose    : 
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page" />
<jsp:useBean id="giveStars" class="com.scripps.growler.GiveStars" scope="page" />
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
  
	<title>Survey</title><!-- Title -->
  
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
	<link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
	<link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
	<link rel="stylesheet" href="../css/demo.css" />  
	<link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
	<link rel="stylesheet" type="text/css" href="../css/general.css" /><!--General CSS-->
	<link rel="stylesheet" type="text/css" href="../css/survey.css" /><!--Speaker CSS-->
	<link rel="stylesheet" href="/resources/demos/style.css" />
	
	<script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
</head>
<body id="growler1">    
  <%@ include file="../includes/header.jsp" %> 
  <%@ include file="../includes/usernav.jsp" %>
  <div class="row">
		<div class="span3">
			<img class="logo" src="../images/Techtoberfest2013small.png" alt="Techtoberfest 2013 small"/><!-- Techtoberfest logo-->
		</div>
		<div class="span6 largeBottomMargin">
			<h1 class = "bordered">Survey</h1>
		</div>
    </div>
	<div class="container-fluid">
		<div class="content">
			<!-- Begin Content -->
			<div class="row"><!--row-->
				<div class="span6 offset3"><!--span-->
                    <div id="tabs-1">
						<div class="row">
							<div class="span1">
							<br/>
								<% 
								String user = String.valueOf(request.getAttribute("id"));
								Connection newConnect = dataConnection.sendConnection();
								Statement newStatement = newConnect.createStatement();
								ResultSet qResult = newStatement.executeQuery("select s.name, s.id from session s, attendance a where s.id = a.session_id and a.isRegistered = 1 and a.user_id = " + user);
								%>
							</div>
							<div class="span2">
								<section>
									<form action="../model/processsurveyrequest.jsp" method="get" >
										<table>
											<tr>
												<td>Session Name</td>
												<td>Take Survey</td>
											</tr>
											<%
											while (qResult.next()) {
											%>
											<tr>
												<td><% out.print(qResult.getString("name")); %></td>
												<td><% out.print("<a href=\"../view/survey.jsp?session=" + qResult.getInt("id") +"\">Survey</a>");%></td>
											</tr>
											<% }
											qResult.close();
											newStatement.close();
											newConnect.close(); 
											%>
										</table>
									</form>
								</section>
							</div>
							<div class="span7">
							<p></p>
							</div>
						</div><!--end row-->
					</div>
				</div>
			</div><!--end row-->
		</div><!-- End Content -->	
	</div><!--/.container-fluid-->	


	<%@ include file="../includes/footer.jsp" %>
	<%@ include file="../includes/scriptlist.jsp" %>
	<%@ include file="../includes/draganddrop.jsp" %>
	
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
	<script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script> 
	<script src="../js/grabRanks.js"></script>
	
</body>
</html>