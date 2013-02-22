<%-- 
    Document   : index
    Created on : Feb 21, 2013, 10:09:16 PM
    Author     : Chase, Justin
--%>

<%@page import="java.util.logging.Level"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.Properties"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet" %>
<%@page import="com.scripps.growler.DataConnection" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="application" />
<jsp:setProperty name="dataConnection" property = "*" />
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
  <link rel="stylesheet" href="css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
  <link rel="stylesheet" href="css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
	<link rel="stylesheet" href="draganddrop.css" /><!--Drag and drop style-->
  <script src="js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
</head>
<body id="growler1">
    
    
    

    
  <header class="pageHeader">
    <div class="pageHeader-portal">
      <div class="pageHeader-logo">
        <a href="/"></a>
      </div>
    </div>
  </header><!-- /.pageHeader -->
	<nav class="globalNavigation">
        <ul>
						<li class="selected"><a href="../index.html">Themes</a></li>
            <li><a href="themeentry.html">Suggest a Theme</a></li>
            <li><a href="">Speakers</a></li>
            <li><a href="">Suggest a Speaker</a></li>
            <li><a href="">Help</a></li>
        </ul>
  </nav><!-- /.globalNavigation -->
  <div class="container-fixed">
		<div class="content">
			<!-- Begin Content -->
			<div class="row">
				<div class="span12">
					<img class="logo" src="Techtoberfest2013.png" alt="Techtoberfest 2013"/>  <!-- Techtoberfest logo-->
					<h1 class = "bordered">Themes</h1>
					</br>
					</br>
                                        <%-- Here's some testing stuff Justin did --%>
                                        <% ResultSet results = dataConnection.selectThemes();
                                         
                                            while (results.next()) {
                                        %> <p> <% out.println(results.getString("name")); %></p>
    <% }%>
                                        <% Connection connection = dataConnection.sendConnection();
                                        Statement other = connection.createStatement();
                                        ResultSet descriptions = other.executeQuery("select description from theme");
                                        while (descriptions.next()) {
                                        %> <p><%out.println(descriptions.getString("description")); %></p>
                                        <% } %>
                                        
                                            
                                           
                                        
							<h3>Drag and drop themes to rank them!<h3>
							<h5>**Only the top ten themes will be ranked</h5>
					</br>
					<div id="tabs-1">
					<div class="row">
						<div class="span3">
						<p></p>
						</div>
						<div class="span1">
							</br> 
							<div>1</div>
							</br>
							</br>
							</br>
							<div>2</div>
							</br>
							</br>
							</br>
							<div>3</div>
							</br>
							</br>
							</br>
							<div>4</div>
							</br>
							</br>
							</br>
							<div>5</div>
							</br>
							</br>
							</br>
							<div>6</div>
							</br>
							</br>
							</br>
							<div>7</div>
							</br>
							</br>
							</br>
							<div>8</div>
							</br>
							</br>
							</br>
							<div>9</div>
							</br>
							</br>
							<div>10</div>
							</br>
							</br>
							<div>11</div>
							</br>
							</br>
						</div>
					<div class="span2">
					<section>
						<ul class="sortable grid">
							<li>Cloud Computing</li>
							<li>Development Frameworks</li>
							<li>Software Process / Lifecycle</li>
							<li>Mobility</li>
							<li>Social and Collaboration</li>
							<li>Show & Tell</li>
							<li>Cross Platform Programming</li>
							<li>Happy Shining People</li>
							<li>Holding Hands</li>
							<li>It's the end of the world</li>
							<li>and I feel fine...</li>
						</ul>
					</section>
					</div>
					<div class="span7">
					<p></p>
					</div>
					</div>
					<!--
					<div id="tabs-1">
						<div class="row">
							<div class="span6">
								<table class="table table-alternatingRow table-border table-columnBorder">
									<thead>
									<tr>
									<th>Ranking</th>
									<th>Suggested Themes</th>
									</tr>
									</thead>
									<tbody>
										<tr>
											<td>1</td>
											<td>
												<div id="div1" ondrop="drop(event)" ondragover="allowDrop(event)">
													<p id="drag1" draggable="true" ondragstart="drag(event)">Cloud Computing</p>
												</div>
											</td>
										</tr>
										<tr>
											<td>2</td>
											<td>
												<div id="div1" ondrop="drop(event)" ondragover="allowDrop(event)">
													<p id="drag1" draggable="true" ondragstart="drag(event)">Development Frameworks</p>
												</div>
											</td>
										</tr>
										<tr>
											<td>3</td>
											<td id="drag1">Software Process / Lifecycle</td>
										</tr>
										<tr>
											<td>4</td>
											<td id="drag1">Mobility</td>
										</tr>
										<tr>
											<td>5</td>
											<td id="drag1">Social and Collaboration</td>
										</tr>
										<tr>
											<td>6</td>
											<td id="drag1">Show & Tell</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>-->
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

  <footer class="pageFooter">
    <hr />
    <p>Scripps Networks Interactive Bootstrap version 1.2.0.<!-- Application name --></p>
    <p>Copyright &copy; 2013 Scripps Networks Interactive</p>
  </footer><!-- /.pageFooter -->
	
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="jquery.sortable.js"></script><!--Drag and drop for non-iOS-->
	<script src="js/libs/jquery-1.8.3.min.js" type="text/javascript"></script>
	<script src="js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
	<script src="js/libs/jquery.dataTables.1.9.3.min.js" type="text/javascript"></script>
	<script src="js/libs/sniui.dataTables.1.0.0.min.js" type="text/javascript"></script>
	
	<!--drag and drop extra script-->
	<script>
	$(function() {
	$('.sortable').sortable();
	$('.handles').sortable({
	handle: 'span'
	});
	$('.connected').sortable({
	connectWith: '.connected'
	});
	$('.exclude').sortable({
	items: ':not(.disabled)'
	});
	});
	</script>
	<script type="text/javascript">
			$(function () {
					$("#tabs").tabs();

					$('#showsTable').dataTable({
							'aoColumns': [
									{ 'bSortable': false },
									{ 'bSortable': true },
									{ 'bSortable': true },
									{ 'bSortable': true },
									{ 'bSortable': true },
									{ 'bSortable': true },
									{ 'bSortable': true }, 
									{ 'bSortable': true },
									{ 'bSortable': true },
									{ 'bSortable': false }    
							],
							'aaSorting': [[1, 'asc']],
							'fnHeaderCallback': Scripps.DataTables.fnHeaderCallback,
							'bFilter': false,
							'bLengthChange': false,
							'sPaginationType': 'scripps'
					});

					$("#assignmentsTabs").tabs();

					$('#assignmentsTable').dataTable({
							'aoColumns': [
									{ 'bSortable': false },
									{ 'bSortable': true },
									{ 'bSortable': true },
									{ 'bSortable': true },
									{ 'bSortable': true },
									{ 'bSortable': true },
									{ 'bSortable': true },
									{ 'bSortable': false },
							],
							'aaSorting': [[1, 'asc']],
							'fnHeaderCallback': Scripps.DataTables.fnHeaderCallback,
							'bFilter': false,
							'bLengthChange': false,
							'sPaginationType': 'scripps'
					});
			});
	</script>
	<script type="text/javascript">
	$(function() {
    $( ".inlineTabs" ).tabs();
    });
	</script>
</body>
</html>
