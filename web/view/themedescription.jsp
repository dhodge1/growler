<%-- 
    Document   : themedescription
    Created on : Feb 27, 2013, 11:43:17 PM
    Author     : Justin Bauguess & Jonathan C. McCowan
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="application" />
<jsp:setProperty name="dataConnection" property = "*" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="application" />
<jsp:setProperty name="queries" property = "*" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
<head>
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="description" content="Theme Description" /><!-- Description -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
  
	<title>Theme Description</title><!-- Title -->
  
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
	<link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
	<link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
	<link rel="stylesheet" href="../css/demo.css" />  
	<link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
	<link rel="stylesheet" type="text/css" href="../css/general.css" /><!--General CSS-->
	<link rel="stylesheet" href="/resources/demos/style.css" />
	
	<script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
</head>
<body id="growler1">
 <%@ include file="../includes/header.jsp" %> 
 <div class="row">
		<div class="span3">
			<img class="logo" src="../images/Techtoberfest2013small.png" alt="Techtoberfest 2013 small"/>
		</div>
		<div class="span5">
			<h1 class = "bordered largeBottomMargin">Theme Descriptions</h1>
		</div>
	</div>
	<div class="container-fluid">
		<div class="content" role="main">
		<!-- Begin Content -->
			<div class="row"><!--row-->
				<div class="span6 offset3"><!--span-->
					<ul>
					 <% Connection connection = dataConnection.sendConnection();
					 Statement statement = connection.createStatement();
					 ResultSet description = statement.executeQuery(queries.selectThemeDescription());
					 
					 while (description.next()) {
					 %>    
					 <li><% out.print("Name: " + description.getString("name") + " <br/> Description: " + description.getString("description")); %></li>
					 <%
					 }
					 %>
					 </ul>
				</div><!--/.span-->	 
			</div><!--/.row -->		 
		</div><!-- /.content -->
	</div><!-- /.container-fluid -->
<%@ include file="../includes/footer.jsp" %> 
<%@ include file="../includes/scriptlist.jsp" %>
<%@ include file="../includes/draganddrop.jsp" %>
</body>
</html>