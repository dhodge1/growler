<%-- 
    Document   : emailForm
    Created on : Feb 21, 2014, 12:49:14 PM
    Author     : Thuy
--%>


<%@page import="java.text.SimpleDateFormat"%>
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
        <meta name="description" content="" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <title>Call To Action</title><!-- Title -->

        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../../../css/demo.css" />  
        <link rel="stylesheet" type="text/css" href="../../../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="../../../css/speaker.css" /><!--Survey CSS-->
        <link rel="stylesheet" href="/resources/demos/style.css" />
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%
            int user = 0;
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../../../index.jsp");
            } else if (!session.getAttribute("role").equals("admin")) {
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
           <div class="row mediumBottomMargin"></div>
           <div class="row">         
             <ul class="breadcrumb">
               <li><a href="../../../private/employee/admin/home.jsp">Home</a></li>
               <li class='ieFix'>Call To Action</li>
             </ul>
           </div>
           <div class="row mediumBottomMargin">
             <h1 style="font-weight:normal;">E-Communications</h1>
           </div>
           <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
           <div class="row largeBottomMargin">
             <h3 style="font-weight:normal;">
                    Send out "call to action" emails before the Techtoberfest event in order to help 
                    increase interest and participation in the event.
             </h3>
           </div>
           <div class="row mediumBottomMargin">
               <label><span style="color: red;">*</span>Required field</label>
           </div>
            <!--<div class='row largeBottomMargin'></div>-->
           <div class="row mediumBottomMargin">
               <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='http://growler.elasticbeanstalk.com/images/Techtoberfest2013small.png'/><span style="padding-left: 12px;">Email Message Details</h2>
           </div> 
        
            <%--
           //***************************************************************
           //*********The code for the email form start here****************
           //***************************************************************
            --%>
           <div class="row">
              <form  id="action" action="callOutAction.jsp" method="POST" >
                 <fieldset>
                    <div class="form-group">
                        <label class="required">Subject</label>
                        <input type="text" required="required" name="emailSubject" class="input-xlarge" />        
                    </div>
                    <div class="form-group">
                        <label class="required">Email Content</label>
                        <textarea cols='75' rows='20' required="required" name="emailContent"  ></textarea>        
                     </div>
                     <div class="form-actions">
                        <input type="submit" id="send" class="button button-primary" value="Send"/>
                        <a id="cancel" href="../../../private/employee/home.jsp">Cancel</a>
                     </div>  
                 </fieldset> 
              </form>	  
           </div> <%--END THE FORM'S div tag--%>
           <%--
           //***************************************************************
           //*******************The code for the email form end here********
           //***************************************************************
           --%>
        </div> <%--END THE CONTAINER-FIXED div tag--%>
      <%--
         <div class="feedbackMessage-success">
            emails successfully sent!
         </div>
      --%> 
       <%@ include file="../../../includes/footer.jsp" %> 
       <%@ include file="../../../includes/scriptlist.jsp" %>
    </body>
</html>