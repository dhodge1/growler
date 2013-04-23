<%-- 
    Document   : theme
    Created on : Feb 28, 2013, 7:15:03 PM
    Author     : Justin Bauguess and Jonathan C. McCowan
    Purpose    : The theme (user) page is for users to rank themes according to 
                their preferences.  The ranks are saved in the isolated_theme_ranking
                table for now.  Once users are remembered, it will be saved in the 
                theme_ranking table.  A record in that table will contain a user_id,
                theme_id, and rank.  Ranks can only be between 1 and 10.  Once a user
                has submitted rankings, they can change them later.
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
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<title>Theme Ranking Page</title><!-- Title -->
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script><!--JQuery link-->
	<script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script><!--JQuery link-->
	<script src="../js/grabRanks.js"></script><!--Grab Ranks-->	
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /><!--JQuery link-->
	<link rel="stylesheet" href="/resources/demos/style.css" /><!--style link to style.css-->
	<link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
	<link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
	<link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
	<link rel="stylesheet" type="text/css" href="../css/general.css" /><!--General CSS-->
	<link rel="stylesheet" type="text/css" href="../css/theme.css" /><!--Theme CSS-->
	<script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
</head>
<body id="growler1">    
	<%@ include file="../includes/header.jsp" %> 
	<%@ include file="../includes/usernav.jsp" %>
	<div class="row">
		<div class="span3">
			<img class="logo" src="../images/Techtoberfest2013.png" alt="Techtoberfest 2013"/><!-- Techtoberfest logo-->
		</div>
		<div class="span5 largeBottomMargin">
			<h1 class = "bordered">Themes</h1>
		</div>
		<div class="span5">
			<h3>Drag and drop themes to rank them!</h3>
			<h5>**Only the top ten themes will be ranked</h5>
		</div>
    </div>
	<div class="container-fixed">
		<div class="content">
			<!-- Begin Content -->
			<div class="row"><!--row-->
				<div class="span12"><!--span-->
                    <div id="tabs-1">
						<div class="row">
							<div class="span1">
								<br/>					
								<% Connection newConnect = dataConnection.sendConnection();
										 
									Statement newStatement = newConnect.createStatement();
									ResultSet themeResult = newStatement.executeQuery(queries.selectVisibleThemes());
								%>
							</div>
							<div class="span2">
								<section>
									<form action="../model/processThemeRanking.jsp" >
										<ul id="sortable">
											<%
											while (themeResult.next()) {
											%>
											<li class="ui-state-default" id="lisort">
												<strong><% out.print(themeResult.getString("name") + " : "); %></strong>
														<% out.print(themeResult.getString("description")); %>
												
											</li>
											
											<% out.print("<input type=\"hidden\" name=\"list\" value=\"" + themeResult.getInt("id") + "\" >");%></li>
											
											<% }
											themeResult.close();
											newStatement.close();
											newConnect.close(); %>
								</section>
							</div>
							<div class="span7">
							<p></p>
							</div>
						</div>
					</div>
				</div><!--end span-->
			</div><!--end row-->
			<div class="span2"><!--button div-->
				<input type="submit" value="Submit Ratings" class="button button-primary"/>
				</form>
			</div>
		</div><!-- End Content -->
	</div>
	<div class="row">
		<div class="span8">
			<p></p>
		</div>
		
	</div>	
	<%@ include file="../includes/footer.jsp" %><!--footer-->
	<%@ include file="../includes/scriptlist.jsp" %><!--script list-->
	<%@ include file="../includes/draganddrop.jsp" %><!--drag and drop extra script-->
</body>
</html>

