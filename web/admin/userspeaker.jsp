<%-- 
    Document   : speaker
    Created on : Feb 27, 2013, 11:23:26 PM
    Author     : Justin Bauguess & Jonathan C. McCowan
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
        <meta name="description" content="" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <title>Admin User Speaker</title><!-- Title -->

        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/demo.css" />  
        <link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
        <link rel="stylesheet" type="text/css" href="../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="../css/speaker.css" /><!--Speaker CSS-->
        <link rel="stylesheet" href="/resources/demos/style.css" />

        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <%@include file="../includes/isadmin.jsp" %>
    <%@ include file="../includes/header.jsp" %> 
    <%@ include file="../includes/adminnav.jsp" %>
    <div class="row">
        <div class="span3">
            <img class="logo" src="../images/Techtoberfest2013admin.png" alt="Techtoberfest 2013 admin"/><!-- Techtoberfest logo-->
        </div>
        <div class="span6 largeBottomMargin">
            <h1 class = "bordered">Speakers - Admin View</h1>
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
                                                <td>
                                                    <% out.print(speaker.getString("last_name") + ", " + speaker.getString("first_name"));%>
                                                    <input type="hidden" name="list" value="<% out.print(speaker.getInt("id"));%>"/>
                                                </td>
                                                <td>
                                                    <input name="visible" type="checkbox" value="<% out.print(speaker.getInt("id"));%>"
                                                           <% if (speaker.getInt("visible") == 0) {
                                                                                                                out.print("checked");
                                                                                                            }%> />
                                                </td>
                                                <td>
                                                    <% out.print(speaker.getString("name"));%>
                                                </td>
                                            </tr>
                                            <% }
                                                speaker.close();
                                                statement.close();
                                                                                                    connection.close();%>
                                        </table>

                                </section>
                            </div>
                            <div class="span7">
                                <p></p>
                            </div>
                        </div><!--end row-->
                    </div>
                </div>
            </div><!--end row-->
            <div class="span2 offset3"><!--button div-->
                <input type="submit" value="Submit" class="button button-primary" />
            </div>
            </form>
        </div><!-- End Content -->	
    </div><!--/.container-fluid-->

    <%@ include file="../includes/footer.jsp" %>
    <%@ include file="../includes/scriptlist.jsp" %>
    <%@ include file="../includes/draganddrop.jsp" %>

    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
    <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
    <script src="../js/grabRanks.js"></script>

    <!--Additional Script-->
    <script>
        $(function() {
            $("#sortable").sortable({revert: true});
            $("#draggable").draggable({connectToSortable: "#sortable", helper: "clone", revert: "invalid"});
            $("ul, li").disableSelection();
        });
    </script>
</body>
</html>
