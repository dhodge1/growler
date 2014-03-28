<%-- 
    Document   : sessionKeyEmail-confirm.jsp
    Created on : March 21, 2014, 10:05:31 PM
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

        <title>Session Key Email Confirm</title><!-- Title -->

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
             <h1 style="font-weight:normal;">Session Key Email Confirmation</h1>
           </div>
           <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
           
          <%
                 if(request.getAttribute("infoMessage")!= null)
                 {
                     
           %>

              <div class="feedbackMessage-success row">
                 <p style="text-align: center"><%=request.getAttribute("infoMessage")%></p>
              </div>
              
           <%
                 }
                 if(request.getAttribute("speakerVList")!= null)
                 {
           %>         
          
           <div class="feedbackMessage-success">
             <h3 style="font-weight:normal;">
                 <p style ="text-align: center"> <b>session key has been sent to the list of presenter(s) below</b><p>
                 <p style="text-align: center" ><%=request.getAttribute("speakerVList")%></p>
             </h3>
           </div>
          <%
                 }
              
                if(request.getAttribute("speakerIList")!= null)
                 {
          %>
          
          <form class="form">
             <div class="form-group"> 
                <table  class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                  <thead>
                    <tr>
                      <th>Speaker Id</th>
                      <th>Last Name</th>
                      <th>First Name</th>
                      <th>Session Name</th>
                      <th>Session Key</th>
                      <th>Valid Email Address</th>
                    </tr>
                  </thead>
                  <tr>
                    <td>97324</td>
                    <td>To</td>
                    <td>Thuy</td>
                    <td>dkfkddkfjdkfjkjfk kfjkdjf  kdjfkdj  kdjfkdjf kj fkdjf</td>
                    <td>8bt2</td>
                    <td><input type="text" name="email" autofocus="true" required="required"/></td>      
                  </tr>
                  <tr>
                    <td>97765</td>
                    <td>Huynh</td>
                    <td>Adam</td>
                    <td>dkfkddkfjdkfjkjfk kfjkdjf  kdjfkdj  kdjfkdjf kj fkdjf</td>
                    <td>89e3</td>
                    <td><input type="text" name="email" autofocus="true" required="required"/></td>      
                  </tr>             
                </table>    
             </div>
              <input type="submit" id="send" class="button button-primary, pull-right"
                                    value="Re-send the session key and update email address" />
          </form>
          
          
          
          
        
          
          
          
          
          
          
            <div class="feedbackMessage-warning">
             <h3 style="font-weight:normal;">
                 <p style ="text-align: center"><b> session key could not be sent to the list of presenter(s) below<br>
                                                 due to invalid email address information</b><br>
                 <p>
                 <p style="text-align: center" ><%=request.getAttribute("speakerIList")%></p>
             </h3>
           </div>            
             
          <%
                 }
                     request.removeAttribute("infoMessage");
                     request.removeAttribute("speakerIList");
                     request.removeAttribute("speakerVList");
          %>
        </div> <%--END THE CONTAINER-FIXED div tag--%>
      
       <%@ include file="../../../includes/footer.jsp" %> 
       <%@ include file="../../../includes/scriptlist.jsp" %>
    </body>
</html>


