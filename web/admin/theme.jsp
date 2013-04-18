<%-- 
    Document   : theme
    Created on : Feb 28, 2013, 7:15:03 PM
    Author     : Justin Bauguess
    Purpose    : The theme (admin) page is for admins to edit theme information. 
                The editable fields are simply if the theme is visible to a user 
                or not.  It will display the theme name, how many rating points 
                it has earned, and how many times someone has rated it.  It will 
                also display the creator of the theme.
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
  <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <style>  ul { list-style-type: decimal-leading-zero; margin: 0; padding: 0; margin-bottom: 10px; }  #lisort { margin: 5px; padding: 5px; list-style-type: decimal-leading-zero; style: none; width: 600px; }  </style>
  <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
  <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
	<link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
  <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
  <script src="../js/grabRanks.js"></script>
</head>
<body id="growler1">    
    <%@include file="../includes/isadmin.jsp" %>
  <%@ include file="../includes/header.jsp" %> 
  <%@ include file="../includes/adminnav.jsp" %>
  <div class="container-fixed">
		<div class="content">
			<!-- Begin Content -->
			<div class="row">
				<div class="span12">
					<img class="logo" src="../images/Techtoberfest2013.png" alt="Techtoberfest 2013"/>  <!-- Techtoberfest logo-->
					<h1 class = "bordered">Default Themes</h1>
					</br>
					</br>
                                            <h3>Default Themes</h3>
                                            <h4>This is the Admin View </h4>
					</br>
                                        <div id="tabs-1">
					<div class="row">
						<div class="span3">
						<p></p>
						</div>
						<div class="span1">
							<br/>
                                             <% Connection newConnect = dataConnection.sendConnection();
                                                
                                                Statement newStatement = newConnect.createStatement();
                                                ResultSet themeResult = newStatement.executeQuery(queries.returnThemeRanking());
                                             %>
						</div>
					<div class="span2">
					<section>
                                            <form method="post" action="../model/admintheme.jsp">
                                                <table>
                                                    <tr>
                                                        <td>Name</td>
                                                        <td>Rating</td>
                                                        <td>Times Rated</td>
                                                        <td>Visible?</td>
                                                        <td>Created By</td>
                                                    </tr>
						<% 
                                                while (themeResult.next()) {
                                                %>
                                                <tr>
                                                <td><% out.print(themeResult.getString("name")); %>
                                                <input type="hidden" name="list" value="<% out.print(themeResult.getInt("id")); %>" /></td>
                                                <td><% out.print(themeResult.getInt("ranking")); %></td>
                                                <td><% out.print(themeResult.getInt("count")); %></td>
                                                <td><input type="checkbox" name="visible" value="<% out.print(themeResult.getInt("id")); %>"
                                                           <% if (themeResult.getInt("visible") == 0) {
                                                                  out.print(" checked");} %>/>
                                                <td><% out.print(themeResult.getString("creator")); %>
                                                </tr>
                                                <% } 
                                                newConnect.close();
                                                themeResult.close();
                                                newStatement.close(); %>
                                                </table>
                                                <input type="submit" value="Submit" class="button-primary" />
                                            </form>
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


	<%@ include file="../includes/footer.jsp" %>
	<%@ include file="../includes/scriptlist.jsp" %>
	<!--drag and drop extra script-->
	<%@ include file="../includes/draganddrop.jsp" %>
</body>
</html>

