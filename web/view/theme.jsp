<%-- 
    Document   : theme
    Created on : Feb 28, 2013, 7:15:03 PM
    Author     : Robert Brown
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
  <title>Growler Project</title><!-- Title -->
  <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
  <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
	<link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
  <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
</head>
<body id="growler1">    
  <%@ include file="../includes/header.jsp" %> 
  <div class="container-fixed">
		<div class="content">
			<!-- Begin Content -->
			<div class="row">
				<div class="span12">
					<img class="logo" src="../images/Techtoberfest2013.png" alt="Techtoberfest 2013"/>  <!-- Techtoberfest logo-->
					<h1 class = "bordered">Themes</h1>
					</br>
					</br>
                                            <h3>Drag and drop themes to rank them!</h3>
						<h5>**Only the top ten themes will be ranked</h5>
					</br>
                                        <div id="tabs-1">
					<div class="row">
						<div class="span3">
						<p></p>
						</div>
						<div class="span1">
							</br>
                                             <% Connection newConnect = dataConnection.sendConnection();
                                                Statement newStatement = newConnect.createStatement();
                                                ResultSet themeResult = newStatement.executeQuery("select name from theme");
                                                int count = dataConnection.countRows();
                                                int i = 1;
  
                                                while (i < count) {
                                                    %>
                                                    <div> <% out.println(i); %> </div>
                                                    </br>
                                                    </br>
                                                    </br>
                                                    <%
                                                i++; 
                                                }
                                        %>
						</div>
					<div class="span2">
					<section>
						<ul class="sortable grid">
						<% 
                                                
                                                while (themeResult.next()) {
                                                %>
                                                <li><% out.print(themeResult.getString("name")); %></li>
                                                <% }
                                                newConnect.close(); %>
							
						</ul>
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
			<input type="submit" value="Submit Ratings" class="button button-primary"/>
		</div>
	</div>	


	<%@ include file="../includes/footer.jsp" %>
	<%@ include file="../includes/scriptlist.jsp" %>
	
	<!--drag and drop extra script-->
	<%@ include file="../includes/draganddrop.jsp" %>
</body>
</html>

