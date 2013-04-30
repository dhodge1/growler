<%-- 
    Document   : theme
    Created on : Feb 28, 2013, 7:15:03 PM
    Author     : Justin Bauguess
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
  <title>Growler Project</title><!-- Title -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />  <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>  <link rel="stylesheet" href="/resources/demos/style.css" />  <style>  ul { list-style-type: decimal-leading-zero; margin: 0; padding: 0; margin-bottom: 10px; }  #lisort { margin: 5px; padding: 5px; list-style-type: decimal-leading-zero; style: none; width: 600px; }  </style>  <script>  $(function() {    $( "#sortable" ).sortable({      revert: true    });    $( "#draggable" ).draggable({      connectToSortable: "#sortable",      helper: "clone",      revert: "invalid"    });    $( "ul, li" ).disableSelection();  });  </script>
  <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
  <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
	<link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
  <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
  <script src="../js/grabRanks.js"></script>

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
					<h1 class = "bordered">Themes</h1>
					</br>
					</br>
					</br>
                                        <div id="tabs-1">
					<div class="row">
					
						<div class="span1">
							<br/>
                                                        
                                             <% 
                                                String user = String.valueOf(session.getAttribute("id"));
                                                Connection newConnect = dataConnection.sendConnection();
                                                Statement newStatement = newConnect.createStatement();
                                                Statement themeStatement = newConnect.createStatement();
                                                ResultSet preranked = newStatement.executeQuery("select r.theme_id, t.name from theme_ranking r, theme t where t.id = r.theme_id and r.user_id = " + user);
                                                ResultSet themeResult = themeStatement.executeQuery(queries.selectVisibleThemes());
                                        %>
						</div>
					<div class="span2">
					<section>
                               
                                            <%
                                            int counter = 1;
                                               while(preranked.next()) {
                                                   out.println("Rank " + counter + ":" + preranked.getString("name") + "<br/><br/>");
                                                   counter++;
                                                   themeResult = null;
                                                   
                                               }
                                            preranked.close();
                                             %>
                                            <form action="../model/processThemeRanking.jsp" >
						<ul id="sortable">
						<%            
                                                    if (themeResult != null) {
                                                        out.print("<h3>Drag and drop themes to rank them!</h3>");
						out.print("<h5>**Only the top ten themes will be ranked</h5>");
                                                        while (themeResult.next()) {
                                                %>
                                                <li class="ui-state-default" id="lisort">
                                                    <strong><% out.print(themeResult.getString("name") + " : "); %></strong>
                                                            <% out.print(themeResult.getString("description")); %>
                                                    
                                                </li>
                                                
                                                <% out.print("<input type=\"hidden\" name=\"list\" value=\"" + themeResult.getInt("id") + "\" >");%>
                                                
                                                <% }
                                                        themeResult.close();
                                                   }
                                                
                                                newStatement.close();
                                                themeStatement.close();
                                                newConnect.close(); %>
							
						
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
                    
                        
                        <% if (counter == 1) {
                        out.print("<input type=\"submit\" value=\"Submit Ratings\" class=\"button button-primary\"/>");
                                                               }
                                %>
                        </form>
                        
			
                
		</div>
	</div>	


	<%@ include file="../includes/footer.jsp" %>
	<%@ include file="../includes/scriptlist.jsp" %>
        
	
	<!--drag and drop extra script-->
	<%@ include file="../includes/draganddrop.jsp" %>
</body>
</html>
