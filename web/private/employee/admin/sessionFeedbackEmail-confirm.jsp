<%-- 
    Document   : sessionFeedbackEmail-confirm
    Created on : Apr 7, 2014, 11:13:19 PM
    Author     : ThuyTo
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

        <title>Session Feedback Confirm</title><!-- Title -->

        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="http://growler.elasticbeanstalk.com/css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/demo.css" />  
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/speaker.css" /><!--Survey CSS-->
        <link rel="stylesheet" href="/resources/demos/style.css" />
        <script src="http://growler.elasticbeanstalk.com/js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%
            int user = 0;
            if (null == session.getAttribute("id")) {
                response.sendRedirect("http://sniforms.scrippsnetworks.com/siteminderagent/sniforms/logout.html");
            } else if (!session.getAttribute("role").equals("admin")) {
                response.sendRedirect("http://sniforms.scrippsnetworks.com/siteminderagent/sniforms/logout.html");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
        %>
        <%@ include file="../../../includes/adminheader.jsp" %>
        <% if (String.valueOf(session.getAttribute("role")).equals("admin")) { %>
            <%--<jsp:include page="../../includes/supernav.jsp" flush="true"/>--%>
            <%@ include file="../../../includes/supernav.jsp" %>
        <% } else {%>
            <%--<jsp:include page="../../includes/adminnav.jsp" flush="true"/>--%>
            <%@ include file="../../../includes/adminnav.jsp" %>
        <% } %>
        <%--<%@ include file="../../../includes/adminnav.jsp" %>--%>
        
        <div class="container-fixed">  
           <div class="row mediumBottomMargin"></div>
           <div class="row">         
             <ul class="breadcrumb">
               <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
               <li class='ieFix'>Email Confirm</li>
             </ul>
           </div>
           <div class="row mediumBottomMargin">
             <h1 style="font-weight:normal;">Session Feedback Confirmation</h1>
           </div>
           <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
           
                    
           <% 
                 if(request.getAttribute("infoMessage")!= null)
                 {
                    if(request.getAttribute("isSuccess")!= null)
                    {
           %>     
                       <div class="feedbackMessage-success row">
                          <p style="text-align: center"><%=request.getAttribute("infoMessage")%></p>
                       </div>
           <%
                    }
                    else
                    {  
           %>
           
                       <div class="feedbackMessage-warning row">
                          <p style="text-align: center"><%=request.getAttribute("infoMessage")%></p>
                       </div>                  
           
            <%
                     }//END ELSE isSuccess STMT
                     //**************************
                     //** clear the attributes **
                     //**************************  
                     request.removeAttribute("infoMessage");
                     request.removeAttribute("isSuccess");    
                 }//END IF (infoMessage!=null) STMT
               
           %>
        </div>
       <%@ include file="../../../includes/footer.jsp" %> 
       <%@ include file="../../../includes/scriptlist.jsp" %>
    </body>
</html>