<%-- 
    Document   : sessionroom-confirm
    Created on : Sep 12, 2013, 12:14:52 PM
    Author     : 162107
--%>
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
        <title>Add Session To Room Confirmation</title>
        <link rel="shortcut icon" type="image/png" href="http://growler.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="../../../css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../../../css/prettify/prettify.css" /> 
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->	
        <style>
            .message_container {
                display: none;
                color: red;
                font-weight: bold;
            }
            .firstlink {
                margin-right: 12px;
            }
            h1 {
                font-weight: normal;
            }
        </style>
    </head>
    <body id="growler1">
        <%      int user = 0;
                if (null == session.getAttribute("id") || null == session.getAttribute("role")) {
                response.sendRedirect("../../../index.jsp");
            }
                try {
                    user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                    String name = String.valueOf(session.getAttribute("user"));                  
                }
                catch (Exception e) {
                        
                }
        %>
        <%@ include file="../../../includes/header.jsp" %> 
        <% if (String.valueOf(session.getAttribute("role")).equals("admin")) { %>
            <jsp:include page="../../../includes/supernav.jsp" flush="true"/>
        <% } else {%>
            <jsp:include page="../../../includes/adminnav.jsp" flush="true"/>
        <% } %>
        <%--<%@ include file="../../../includes/adminnav.jsp" %>--%>
        <div class="container-fixed largeBottomMargin">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <%@include file="../../../includes/messagehandler.jsp" %>
            </div>
            <div class="row mediumBottomMargin">
                <h1>Add Session To Room Confirmation</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <p><span>Session Topic: <%  if (session.getAttribute("sessionName") != null) out.print((String)session.getAttribute("sessionName")); %></span></p>
                <p><span>Session Description: <%if (session.getAttribute("sessionName") != null)  out.print((String)session.getAttribute("sessionDesc")); %></span></p>
                <p><span>Speakers(s): <% if (session.getAttribute("sessionName") != null) out.print((String)session.getAttribute("sessionSpkr")); 
                    if (session.getAttribute("sessionSpkr2") != null) {
                        out.print(" | " + session.getAttribute("sessionSpkr2"));
                    }
                %></span></p>
                <p><span>Session Date: <%if (session.getAttribute("sessionName") != null)  out.print(session.getAttribute("sessionDate")); %></span></p>
                <p><span>Session Time: <%if (session.getAttribute("sessionName") != null)  out.print(session.getAttribute("sessionTime")); %></span></p>
                <p><span>Location: <%if (session.getAttribute("sessionName") != null)  out.print((String)session.getAttribute("locationName")); %></span></p>
                <p><span>Building: <%if (session.getAttribute("sessionName") != null)  out.print((String)session.getAttribute("locationBuilding")); %></span></p>
                <p><span>Capacity: <%if (session.getAttribute("sessionName") != null)  out.print(session.getAttribute("locationCapacity")); %></span></p>
            </div>
            <div class="row">
                <a class="firstlink" href='../../../private/employee/admin/room.jsp'>Return to manage rooms</a>
                <a href='../../../private/employee/admin/session.jsp'>View sessions</a>
            </div>
        </div>
        <% 
                session.removeAttribute("sessionName");
                session.removeAttribute("sessionDesc");
                session.removeAttribute("sessionSpkr");
                session.removeAttribute("sessionSpkr2");
                session.removeAttribute("sessionDate");
                session.removeAttribute("sessionTime");
                session.removeAttribute("sessionID");
                session.removeAttribute("locationName");
                session.removeAttribute("locationBuilding");
                session.removeAttribute("locationCapacity");
        %>
        <%@ include file="../../../includes/footer.jsp" %> 
    </body>
</html>