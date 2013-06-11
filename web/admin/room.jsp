<%-- 
    Document   : room
    Created on : Jun 11, 2013, 12:57:59 PM
    Author     : 162107
--%>

<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
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

        <title>Admin Rooms</title><!-- Title -->

        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/demo.css" />  
        <link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
        <link rel="stylesheet" type="text/css" href="../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="../css/theme.css" /><!--Theme CSS-->
        <link rel="stylesheet" href="/resources/demos/style.css" />

        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <% String user = "";
            try {
                user = String.valueOf(session.getAttribute("id"));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
            if (user == null) {
                response.sendRedirect("../index.jsp");
            }
        %>
        <%@include file="../includes/isadmin.jsp" %>
        <%@ include file="../includes/header.jsp" %> 
        <%@ include file="../includes/adminnav.jsp" %>

        <div class="row">
            <div class="span3">
                <img class="logo" src="../images/Techtoberfest2013admin.png" alt="Techtoberfest 2013 admin"/><!-- Techtoberfest logo-->
            </div>
            <div class="span6 largeBottomMargin">
                <h1 class = "bordered">Rooms</h1>
            </div>
        </div>
        <div class="container-fluid">
            <div class="content"><!-- Begin Content -->
                <%
                    LocationPersistence lp = new LocationPersistence();
                    ArrayList<Location> locations = lp.getAllLocations();
                %>
                <div class="span9 offset2">
                    <% 
                            //Displaying error or success messages -- clear it out when done
                            String message = (String) session.getAttribute("message");
                            if (message != null && message.startsWith("Room")) {
                                out.print("<p class=feedbackMessage-success>" + message + "</p>");
                                session.removeAttribute("message");
                            }
                            else if (message != null) {
                                out.print("<p class=feedbackMessage-error>" + message + "</p>");
                                session.removeAttribute("message");
                            }
                    %>
                    <form method="post" action="../model/addroom.jsp">
                        <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                            <tr>
                                <th>Room Number</th>
                                <th>Name</th>
                                <th>Capacity</th>
                                <th>Building</th>
                                <th>Edit</th>
                                <th>Remove</th>
                            </tr>
                            <%
                                for (int i = 0; i < locations.size(); i++) {
                                    out.print("<tr>");
                                    out.print("<td>");
                                    out.print(locations.get(i).getId());
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print(locations.get(i).getDescription());
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print(locations.get(i).getCapacity());
                                    out.print("</td>");
                                    out.print("<td>");
                                    out.print(locations.get(i).getBuilding());
                                    out.print("</td>");
                                    out.print("<td><a href=\"../admin/editroom.jsp?id=" + locations.get(i).getId() + "\">Edit</td>");
                                    out.print("<td><a href=\"../model/deleteroom.jsp?id=" + locations.get(i).getId() + "\">Delete</td>");
                                    out.print("</tr>");
                                }
                            %>
                            <tr>
                                <td><input required="required" type="text" maxlength="10" name="id" id="tip" data-content="Room Number, 10 Characters or Less"/></td>
                                <td><input required="required" type="text" maxlength="30" name="name" id="tip1" data-content="Room Name, 20 Characters or Less"/></td>
                                <td><input required="required" type="number" min="1" step="1" max="999" name="capacity" id="tip2" data-content="Maximum Capacity, 0 to 999"/></td>
                                <td><input required="required" type="text" maxlength="20" name="building" id="tip3" data-content="Building Name, 20 Characters or Less"/></td>
                                <td><input id="send" type="submit" value="Add New Room"/></td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div><!-- End Content -->	
        </div><!--/.container-fluid-->


        <%@ include file="../includes/footer.jsp" %>
        <%@ include file="../includes/scriptlist.jsp" %>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
        <script>
                        $(function() {
                            $("input").autoinline();
                        });</script>
        <script>
                            $(function() {
                                    $("#send").click(function() {
                                        if ($("#tip").val() === "") {
                                            alert("Please enter a Room Number");
                                            $("#action").attr("action", "");
                                        }
                                        else if ($("#tip1").val() === "") {
                                            alert("Please enter a Room name");
                                            $("#action").attr("action", "");
                                        }
                                        else if ($("#tip2").val() === "" || $("#tip2").val() <= 0) {
                                            alert("Please enter a Capacity greater than 0");
                                            $("#action").attr("action", "");
                                        }
                                        else if ($("#tip3").val() === "") {
                                            alert("Please enter a Building name");
                                            $("#action").attr("action", "");
                                        }
                                        else {
                                            $("#action").attr("action", "../model/addroom.jsp");
                                        }
                                    });
                                });

        </script>


    </body>
</html>