<%-- 
    Document   : surveylist
    Created on : Apr 25, 2013, 7:15:03 PM
    Author     : Justin Bauguess
    Purpose    : List the surveys for sessions a user has attended
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page" />
<jsp:useBean id="giveStars" class="com.scripps.growler.GiveStars" scope="page" />
<jsp:useBean id="persist" class="com.scripps.growler.AttendancePersistence" scope="page" />
<jsp:useBean id="spersist" class="com.scripps.growler.SessionPersistence" scope="page" />
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
	<link rel="stylesheet" type="text/css" href="../css/survey.css" /><!--Survey CSS-->
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
								<% 
								String user = String.valueOf(request.getAttribute("id"));
                                                                int userId = Integer.parseInt(user);
								ArrayList<Attendance> attendances = persist.getAttendanceByUser(userId);
								if (attendances == null) {
									out.print("<h1 class=bordered>You have not attended any sessions</h1>");
								}
								else{
									out.print("<h1 class=bordered>Surveys</h1>");
								}
								%>
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
											for (int i = 0; i < attendances.size(); i++) {
												if (attendances.get(i).getIsRegistered() == false) {
											%>
											<tr>
												<td><% out.print(spersist.getSessionByID(attendances.get(i).getSessionId()).getName()); %></td>
												<td><% out.print("<a href=\"../view/survey.jsp?session=" + attendances.get(i).getSessionId() +"\">Survey</a>");%></td>
											</tr>
											<% } //close if statement
											} //close for loop
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
	
	<!--Additional Script-->
	<script>  
	$(function() {    
		$( "#sortable" ).sortable({      revert: true    });    
		$( "#draggable" ).draggable({      connectToSortable: "#sortable",helper: "clone",revert: "invalid"});
		$( "ul, li" ).disableSelection();
	});  
	</script>
</body>
</html>