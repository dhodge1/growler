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
        <link rel="shortcut icon" type="image/png" href="../../../images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <style>
            .message_container {
                display: none;
                color: red;
                font-weight: bold;
            }
            h1, h3 {
                font-weight: normal;
            }
        </style>
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%
            int user = 0;
            if (null == session.getAttribute("id") || null == session.getAttribute("role")) {
                response.sendRedirect("../../../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
        %>

        <%@ include file="../../../includes/adminheader.jsp" %> 
        <% if (String.valueOf(session.getAttribute("role")).equals("admin")) { %>
            <jsp:include page="../../../includes/supernav.jsp" flush="true"/>
        <% } else {%>
            <jsp:include page="../../../includes/adminnav.jsp" flush="true"/>
        <% } %>
        <%--<%@ include file="../../../includes/adminnav.jsp" %>--%>
        <div class="container-fixed">
            <div class="mediumBottomMargin row"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="../../../private/employee/admin/home.jsp">Home</a></li>
                    <li class='ieFix'>Add a Room</li>
                </ul>
            </div>
            <div class='row mediumBottomMargin'>
                <h1 style="margin-top:0px;font-weight: normal;">Add a New Room</h1>
            </div>
            <div class='mediumBottomMargin row' style='border: 1px dotted #ddd;'></div>
            <div class="row largeBottomMargin">
                <h3>Please fill out the form below to add a new room.</h3>
            </div>
            <div class="row mediumBottomMargin">
                <label><span style="color: red;">*</span>Required field</label>
            </div>
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='${pageContext.request.contextPath}/images/Techtoberfest2013small.png'/><span style="padding-left:12px;">Add a Room</span></h2>
            </div>
            <div class="row mediumBottomMargin">
                <%@include file="../../../includes/messagehandler.jsp" %>
                    <form id="action" method="post" action="../../../action/processaddroom.jsp" >
                        <fieldset>
                            <div class="form-group">
                                <label class="required">Room Number:</label>
                                <input type="text" maxlength="10" id="tip" name="id" class="input-xlarge" data-content="Room ID, 10 Characters or Less"/>
                                <br/><span id="error_id" class="message_container">
                                    <span>Please enter a room number</span>
                                </span>
                            </div>
                            <div class="form-group">
                                <label class="required">Room Name:</label>
                                <input type="text" maxlength="20" id="tip1" name="name"  class="input-xlarge" data-content="Room Name, 20 Characters or Less"/>
                                <br/><span id="error_name" class="message_container">
                                    <span>Please enter a room name</span>
                                </span>
                            </div>
                            <div class="form-group">
                                <label class="required">Capacity:</label>
                                <input type="number" min="0" max="999" step="1" id="tip2" name="capacity"  data-content="Maximum Capacity, 0 to 999"/>
                                <br/><span id="error_capacity" class="message_container">
                                    <span>Please enter room capacity</span>
                                </span>
                            </div>
                            <div class="form-group">
                                <label class="required">Building Name:</label>
                                <select id="building" name="building">
                                    <option value="0"> - Please Select a Building- </option>
                                    <option value="KXTC">Knoxville Tech Center</option>
                                    <option value="KXOFFICE">Knoxville Office</option>
                                </select>
                                <br/><span id="error_building" class="message_container">
                                    <span>Please select building name</span>
                                </span>
                            </div>
                            <div class="form-actions" style="padding-top:12px;">
                                <input id="send" type="submit" value="Submit" class="button button-primary"/>
                                <a href='../../../private/employee/admin/room.jsp'>Cancel</a>
                            </div>
                        </fieldset>
                    </form>
            </div>
        </div>
    <%@ include file="../../../includes/footer.jsp" %>
    <%@ include file="../../../includes/scriptlist.jsp" %>
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>  
    <script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>           
    <script src="../../../js/addroom.js"></script>
</body>

</html>
