<%-- 
    Document   : speaker
    Created on : Feb 27, 2013, 11:23:26 PM
    Author     : Justin Bauguess & Jonathan C. McCowan
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
  <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  
  <title>Speakers</title><!-- Title -->
  
  <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />
  <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
  <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
  <link rel="stylesheet" href="../css/demo.css" />  
  <link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
  <link rel="stylesheet" type="text/css" href="../css/general.css" /><!--General CSS-->
  <link rel="stylesheet" type="text/css" href="../css/speaker.css" /><!--Speaker CSS-->
</head>
<body id="growler1">
	<%@ include file="../includes/header.jsp" %> 
	<%@ include file="../includes/usernav.jsp" %>
	<div class="row">
		<div class="span3">
			<img class="logo" src="../images/Techtoberfest2013small.png" alt="Techtoberfest 2013 small"/><!-- Techtoberfest logo-->
		</div>
		<div class="span6 largeBottomMargin">
			<h1 class = "bordered">Speakers</h1>
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
                                                                String user = String.valueOf(session.getAttribute("id"));                                                                
                                                                Connection connection = dataConnection.sendConnection();
										 
									Statement newStatement = connection.createStatement();
									ResultSet speaker = newStatement.executeQuery(queries.selectVisibleSpeakers());
                                                                        Statement ranked = connection.createStatement();
                                                                        ResultSet preranked = ranked.executeQuery("select s.first_name, s.last_name from speaker s, speaker_ranking r where r.speaker_id = s.id and r.user_id = " + user);

								%>
							</div>
							<div class="span2">
								<section>
									<%
									int counter = 1;
									   while(preranked.next()) {
										   out.println("Rank " + counter + ":" + preranked.getString("last_name") + ", " + preranked.getString("first_name") + "<br/><br/>");
										   counter++;
										   speaker = null;
										   
									   }
									preranked.close();
                                                                        if (speaker !=null) {
                                                                            out.print("<h3>Drag and drop themes to rank them!</h3>");
                                                                            out.print("<h5>**Only the top ten themes will be ranked</h5>");
                                                                                            
                                                                        }
									%>
									 <form action="../model/processSpeakerRanking.jsp">
										<ul class="sortable">
											<%
											if (speaker != null) {
                                                                                            
                                                                                            
											while (speaker.next()) {
											%>
											<li id="lisort"> 
											<% out.print(speaker.getString("last_name") + ", " + speaker.getString("first_name")); %>
											<% out.print(giveStars.return2012Rank(speaker.getInt("id"))); %>
											<% out.print(giveStars.returnCount(speaker.getInt("id"))); %>
											<% out.print("<input type=\"hidden\" name=\"list\" value=\"" + speaker.getInt("id") + "\" />"); %>
											</li>
											<% } 
											speaker.close();
											}
											newStatement.close();
											ranked.close();
											connection.close();
											%>
										</ul>
									 </form>
								</section>
							</div>
							</br>
						</div>
					</div>
				</div><!--end span-->
			</div><!--end row-->
			<div class="span2 offset3"><!--button div-->
				<% if (counter == 1) {
                        out.print("<input type=\"submit\" value=\"Submit Ratings\" class=\"button button-primary\"/>");
				   }
				%>
                        
			</div>
		</div><!-- End Content -->
	</div><!--/.container-fluid-->
	
	<%@ include file="../includes/footer.jsp" %> 
	<%@ include file="../includes/scriptlist.jsp" %>
	<%@ include file="../includes/draganddrop.jsp" %>
	
	<!--Additional Script-->
	<script>  
		$(function() {
			$( "#sortable" ).sortable({revert: true});    
			$( "#draggable" ).draggable({connectToSortable: "#sortable",helper: "clone",revert: "invalid"});
			$( "ul, li" ).disableSelection();
		});
	</script>
</body>
</html>
