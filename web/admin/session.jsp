<%-- 
    Document   : speaker
    Created on : Feb 27, 2013, 11:23:26 PM
    Author     : Justin Bauguess
    Purpose    : The purpose of speaker(admin) is the page where administrators 
                can edit speaker information.  It uses the rank_2012 table and 
                the speaker table.  The editable data includes: rating, count of 
                ratings, and visibility to users.
--%>
<%@page import="sun.java2d.pipe.SpanClipRenderer"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<jsp:useBean id="giveStars" class="com.scripps.growler.GiveStars" scope="page" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page" />
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
                                            <h3>Admin View</h3>
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
                                                       ResultSet speaker = statement.executeQuery("select s.id, r.rating, r.count, s.first_name, s.last_name, s.visible, s.suggested_by, u.name from speaker s, ranks_2012 r, user u where s.id = r.speaker_id and u.id = s.suggested_by order by r.rating desc, s.last_name");
 %>
 </div>
					<div class="span2">
					<section>
                                            <form id="entry" name="entry" action="../model/adminspeaker.jsp" method="post">
                                            <table>
                                                <tr>
                                                    <td>Speaker Name</td>
                                                    <td>2012 Rating</td>
                                                    <td>Times Ranked</td>
                                                    <td>New Rating</td>
                                                    <td>New Times Ranked</td>
                                                    <td>Visible?</td>
                                                    <td>Suggested By</td>
                                                </tr>
                                                
<% 
 while (speaker.next()) {
     %>
     <tr>
         <td><% out.print(speaker.getString("last_name") + ", " + speaker.getString("first_name")); %>
         <input name="list" type="hidden" value="<% out.print(speaker.getInt("id")); %>" />
         <td><% out.print(speaker.getDouble("rating")); %></td>
         <td><% out.print(speaker.getInt("count")); %></td>
         <% double d = speaker.getDouble("rating");
         
             out.print("<td><input id=\"" + speaker.getInt("id") +"\" type=\"number\" min=\"0\" max=\"5\" name=\"newrank\" value=" + d + " /></td>");
         %>
         <% int i = speaker.getInt("count");
         
             out.print("<td><input id=\"" + speaker.getInt("id") +"\" type=\"number\" min=\"0\" max=\"100\" name=\"newcount\" value=" + i + " /></td>");
         
         %>
        
         <td><input name="visible" type="checkbox" value="<% out.print(speaker.getInt("id")); %>"
                    <% if (speaker.getInt("visible") == 0) {
                        out.print("checked"); }%> />
         </td>
         <td><% out.print(speaker.getString("name")); %></td>
     </tr>
           
    
  <% } 
 speaker.close();
 statement.close();
 connection.close();%>
 </table>
 <input type="submit" value="Submit" class="button button-primary" />
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
<script src="../js/validation.js"></script>
    </body>
</html>
