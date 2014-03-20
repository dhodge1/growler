<%--
    Document   : addSessionHost
    Created on : Mar 19, 2014, 4:03:40 PM
    Author     : Chelsea Grindstaff
    Purpose    : Allow admin to designate a user as a host for a specific session
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
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

        <title>Assign Host to Session</title>
        <link rel="shortcut icon" type="image/png" href="http://growler.elasticbeanstalk.com/images/scripps_favicon-32.ico">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/prettify/prettify.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/general.css" /><!--General CSS-->
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
        <style>
            .message_container {
                display: none;
                color: red;
                font-weight: bold;
            }
            h3 {
                font-weight:normal;
            }
            #speaker2Img {
                height: 95%;
                width: 95%;
                border-radius: 50px;
            }
        </style>
    </head>
    <body id="growler1">
            <%      int user = 0;
                    if (null == session.getAttribute("id")) {
                        response.sendRedirect("../../index.jsp");
                    }
                    try {
                        user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                        String name = String.valueOf(session.getAttribute("user"));
                    }
                    catch (Exception e) {

                    }
        %>
        <%@ include file="../../../includes/adminheader.jsp" %>
        <% if (String.valueOf(session.getAttribute("role")).equals("admin")) { %>
            <%--<jsp:include page="../../includes/supernav.jsp" flush="true"/>--%>
            <%@ include file="../../../includes/supernav.jsp" %>
        <% } else {%>
            <%--<jsp:include page="../../includes/testnav.jsp" flush="true"/>--%>
            <%@ include file="../../../includes/testnav.jsp" %>
        <% } %>
        <%--<%@ include file="../../includes/testnav.jsp" %>--%>
        <div class="container-fixed mediumBottomMargin">
            <div class="row mediumBottomMargin"></div>
            <div class="row">
                <ul class="breadcrumb">
                    <li><a href="${pageContext.request.contextPath}/private/employee/home.jsp">Home</a></li>
                    <li>Assign Host to Session</li>
                </ul>
            </div>
            <div class="row mediumBottomMargin">
                <h1 style="font-weight:normal;">Add a Host to a Session</h1>
            </div>
            <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
            <div class="row largeBottomMargin">
                <h3>Designate a user as a host for a particular session. </h3>
            </div>
            <div class="row mediumBottomMargin">
                <label><span style="color: red;">*</span>Required field</label>
            </div>
            <div class="row mediumBottomMargin">
                <h2 class="bordered"><img style="padding-left:0px;padding-bottom:0px;" src="${pageContext.request.contextPath}/images/Techtoberfest2013small.png"/><span class="titlespan">Designate Host</span></h2>
            </div>
            <div class="row">
                    <div class="span6">
                        <form method="POST" id="action" action="${pageContext.request.contextPath}/action/processAddHost.jsp">
                            <fieldset>
                                <!-- Select User -->
                                <div class="form-group">
                                    <label class="required">What user do you want to make a host?</label>
                                    <select name='host' id='host' class='input x-large'>
                                        <option value='0'> Please select a user </option>
                                        <%
                                        UserPersistence up = new UserPersistence();
                                        ArrayList<User> userList = up.getAllUsers();
                                        for (int i=0; i<userList.size(); i++){

                                            out.print("<option value='" + userList.get(i).getId() + "'>");
                                            out.print(userList.get(i).getUserName() );
                                            out.print("</option>");
                                        }
                                        %>
                                    </select>
                                    <br/><span id='error_theme' class='message_container'>
                                        <span>Please select a host</span>
                                    </span>
                                </div>
                                <!-- Select Session -->
                                <div class="form-group">
                                    <label class="required">To what session do you want to assign this host?</label>
                                    <select name='session' id='session' class='input x-large'>
                                        <option value='0'> Please select a session </option>
                                        <%
                                        SessionPersistence sessionPersist = new SessionPersistence();
                                        ArrayList<Session> sessions = sessionPersist.getAllSessions(" order by session.name asc");
                                        for (int j = 0; j < sessions.size(); j++){
                                            out.print("<option value='" + sessions.get(j).getId() + "'>");
                                            out.print(sessions.get(j).getName() );
                                            out.print("</option>");
                                        }
                                        %>
                                    </select>
                                    <br/><span id='error_theme' class='message_container'>
                                        <span>Please select a session</span>
                                    </span>
                                </div>




                                <div class="form-actions">
                                    <input type="submit" id="send" class="button button-primary" value="Submit Host"/>
                                    <a id="cancel" href="${pageContext.request.contextPath}/private/employee/home.jsp">Cancel</a>
                                </div>
                            </fieldset>
                    </form>
                </div>
                <div class="span6">
                    <img id="speaker2Img" src="${pageContext.request.contextPath}/images/theme2.jpg" />
                </div>
            </div>
        </div>
        <%@ include file="../../../includes/footer.jsp" %>
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/bootstrap-popover.2.1.1.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/libs/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/sniui.auto-inline-help.min.js" type="text/javascript"></script>
        <script src="http://growler.elasticbeanstalk.com/js/libs/sniui.auto-inline-help.1.0.0.min.js" type="text/javascript"></script>

    </body>
</html>

