<%-- 
    Document   : addroom
    Created on : Jun 11, 2013, 4:25:33 PM
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

        <title>Add a Room</title><!-- Title -->

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
        <%
                    String user = "";
                    if (null == session.getAttribute("id")) {
                        response.sendRedirect("../index.jsp");
                    }
                    try {
                        user = String.valueOf(session.getAttribute("id"));
                        String name = String.valueOf(session.getAttribute("user"));                  
                    }
                    catch (Exception e) {
                        
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
                <h1 class = "bordered">Add A Room</h1>
            </div>
        </div>
        <div class="container-fluid">
            <div class="content"><!-- Begin Content -->
                <div class="span7 offset4">
                    <%@include file="../includes/messagehandler.jsp" %>
                    <form id="action" method="post" action="../model/processroom.jsp" >
                        <label class="required">Room ID:</label><br/>
                        <input type="text" maxlength="10" id="tip" name="id" class="input-xlarge" data-content="Room ID, 10 Characters or Less"/><br/><br/>
                        <label class="required">Room Name:</label><br/>
                        <input type="text" maxlength="20" id="tip1" name="name"  class="input-xlarge" data-content="Room Name, 20 Characters or Less"/><br/><br/>
                        <label class="required">Capacity:</label><br/>
                        <% out.print("<input type=\"number\" min=\"0\" max=\"999\" step=\"1\" id=\"tip2\" name=\"capacity\"  data-content=\"Maximum Capacity, 0 to 999\"/>");%><br/><br/>
                        <label class="required">Building Name:</label><br/>
                        <input type="text" maxlength="20" id="tip3" name="building" class="input-xlarge" data-content="Building Name, 20 Characters or Less"/>  <br/>
                        <br/>
                        <br/>
                        <input id="send" type="submit" value="Submit Changes" class="button button-primary"/>
                    </form>
                </div>
            </div><!-- End Content -->	
        </div><!--/.container-fluid-->


        <%@ include file="../includes/footer.jsp" %>
        <%@ include file="../includes/scriptlist.jsp" %>
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
        <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>           
        <script>
                            $(document).ready(function() {
                                    $("#send").click(function(event) {
                                        if ($("#tip").val() == "") {
                                            alert("Please enter a Room Number");
                                            event.preventDefault();
                                            $("#action").attr("action", "");
                                        }
                                        else if ($("#tip1").val() == "") {
                                            alert("Please enter a Room name");
                                            event.preventDefault();
                                            $("#action").attr("action", "");
                                        }
                                        else if ($("#tip2").val() == "" || $("#tip2").val() <= 0) {
                                            alert("Please enter a Capacity greater than 0");
                                            event.preventDefault();
                                            $("#action").attr("action", "");
                                        }
                                        else if ($("#tip3").val() == "") {
                                            alert("Please enter a Building name");
                                            event.preventDefault();
                                            $("#action").attr("action", "");
                                        }
                                        else {
                                            $("#action").attr("action", "../model/processroom.jsp");
                                        }
                                    });
                                });

        </script>
    </body>
    
</html>
