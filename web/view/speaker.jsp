<%-- 
    Document   : speaker
    Created on : Feb 27, 2013, 11:23:26 PM
    Author     : Justin Bauguess
    Purpose    : The purpose of speaker is to display speaker information so a
                user can rank them.  It uses the ranks_2012 and speaker tables. 
                The rank is a score between 0 and 5 that was determined from 
                historical data that was provided by Ian.  (It is not in the database, 
                but can be accessed from raw_data and processed with the DataConnection
                 java class.)
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page">
</jsp:useBean>
<jsp:useBean id="giveStars" class="com.scripps.growler.GiveStars" scope="page"></jsp:useBean>
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page"></jsp:useBean>
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
  <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />  <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>  <link rel="stylesheet" href="/resources/demos/style.css" />  <style>  ul { list-style-type: decimal-leading-zero; margin: 0; padding: 0; margin-bottom: 10px; }  #lisort { margin: 5px; padding: 5px; list-style-type: decimal-leading-zero; style: none; width: 600px; }  </style>  <script>  $(function() {    $( "#sortable" ).sortable({      revert: true    });    $( "#draggable" ).draggable({      connectToSortable: "#sortable",      helper: "clone",      revert: "invalid"    });    $( "ul, li" ).disableSelection();  });  </script>
  <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
  <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
	<link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
  <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
  <style> ul { list-style-type: decimal-leading-zero; margin: 0; padding: 0; margin-bottom: 10px; }  #lisort { margin: 5px; padding: 5px; list-style-type: decimal-leading-zero; style: none; width: 300px; height: 60px; }  </style>
</head>
<body id="growler1">
 <%@ include file="../includes/header.jsp" %> 
<%@ include file="../includes/usernav.jsp" %>
  <div class="container-fixed">
		<div class="content">
			<!-- Begin Content -->
			<div class="row">
				<div class="span12">
					<img class="logo" src="../images/Techtoberfest2013.png" alt="Techtoberfest 2013"/>  <!-- Techtoberfest logo-->
					<h1 class = "bordered">Speakers</h1>
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
                                                        <%
                                                        
                                                        Connection connection = dataConnection.sendConnection();
 Statement statement = connection.createStatement();
 ResultSet speaker = statement.executeQuery(queries.selectVisibleSpeakers());
 %>
 </div>
					<div class="span2">
					<section>
 <form action="../model/processSpeakerRanking.jsp">
 <ul class="sortable">
     
    
<% 
 while (speaker.next()) {
     %>
     <li id="lisort"> <% out.print(speaker.getString("last_name") + ", " + speaker.getString("first_name")); %>
         <% out.print(giveStars.return2012Rank(speaker.getInt("id"))); %>
         <% out.print(giveStars.returnCount(speaker.getInt("id"))); %>
           
         <% out.print("<input type=\"hidden\" name=\"list\" value=\"" + speaker.getInt("id") + "\" />"); %></li>
  <% } 
 statement.close();
 speaker.close();
 connection.close();%>
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
                    </div>
	</div>	
  <input type="submit" value="Submit Ratings" class="button button-primary"/>
  </form>
<%@ include file="../includes/footer.jsp" %> 
<%@ include file="../includes/scriptlist.jsp" %>
<%@ include file="../includes/draganddrop.jsp" %>
    </body>
</html>
