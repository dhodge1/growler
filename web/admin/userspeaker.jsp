<%-- 
    Document   : speaker
    Created on : Feb 27, 2013, 11:23:26 PM
    Author     : Robert Brown
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="application" />
<jsp:setProperty name="dataConnection" property = "*" />
<jsp:useBean id="giveStars" class="com.scripps.growler.GiveStars" scope="application" />
<jsp:setProperty name="giveStars" property = "*" />
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
  <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />  <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>  <link rel="stylesheet" href="/resources/demos/style.css" />  <style>  ul { list-style-type: decimal-leading-zero; margin: 0; padding: 0; margin-bottom: 10px; }  #lisort { margin: 5px; padding: 5px; list-style-type: decimal-leading-zero; style: none; width: 600px; }  </style>  <script>  $(function() {    $( "#sortable" ).sortable({      revert: true    });    $( "#draggable" ).draggable({      connectToSortable: "#sortable",      helper: "clone",      revert: "invalid"    });    $( "ul, li" ).disableSelection();  });  </script>
  <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
  <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
	<link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
  <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
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
					<h1 class = "bordered">Speakers</h1>
                                        </br>
					</br>
                                        <h3>Admin Suggested Speaker Page</h3>
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
 ResultSet speaker = statement.executeQuery(queries.selectUserSuggestedSpeakers()); 
 %>
 </div>
					<div class="span2">
					<section>
                                        <form action="../model/adminuserspeaker.jsp" method="post">
                                            <table>
                                                <tr>
                                                    <td>Speaker Name</td>
                                                    <td>Visible?</td>
                                                    <td>Suggested By</td>
                                                </tr>
     
    
<% 
 
 while (speaker.next()) {
     %>
     <tr>
     <td><% out.print(speaker.getString("last_name") + ", " + speaker.getString("first_name")); %>
     <input type="hidden" name="list" value="<% out.print(speaker.getInt("id")); %>"/></td>
     <td><input name="visible" type="checkbox" value="<% out.print(speaker.getInt("id")); %>"
                    <% if (speaker.getInt("visible") == 0) {
                        out.print("checked"); }%> /></td>
     <td><% out.print(speaker.getString("name")); %></td>
     </tr>
  <% } 
 speaker.close();
 statement.close();
 connection.close();%>
                                            </table>
                                            <input type="submit" value="Submit"/>
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
<%@ include file="../includes/draganddrop.jsp" %>
    </body>
</html>