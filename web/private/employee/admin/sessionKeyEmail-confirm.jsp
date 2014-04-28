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
        
        <div class="container-fixed largeBottomMargin">  
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
           
           <div class="row mediumBottomMargin">
               <label><span style="color: red;">*</span>Required field</label>
           </div>           
           
           
           
           <%
              if((request.getAttribute("infoMessage")!= null)&&
                 (request.getAttribute("notSuccess")!= null))
              {          
           %>

                   <div class="feedbackMessage-warning row">
                     <p style="text-align: center;"><%=request.getAttribute("infoMessage")%></p>
                   </div>
                      
           <%
              }
              else
              {
                 if(request.getAttribute("infoMessage")!= null)
                 {          
           %>

                   <div class="feedbackMessage-success row">
                     <p style="text-align: center;"><%=request.getAttribute("infoMessage")%></p>
                   </div>
              
           <%
                 }
                 if(request.getAttribute("speakerVList")!= null)
                 {
           %>         
                    <div class="feedbackMessage-success row"> 
                       <p style ="text-align: center;"> <b>session key has been sent to the list of presenter(s) below</b></p>
                       <p style="text-align: center;" ><%=request.getAttribute("speakerVList")%></p>
                    </div>
                    
            <%
                 }            
                 if(request.getAttribute("speakerIList")!= null)
                 {
                     String strThuy = request.getAttribute("speakerIList").toString();  
            %>
           
                 <div class="feedbackMessage-warning row">
                        <p style ="text-align: center;">
                            <b> session key could not be sent to the list of presenter(s) below
                                due to invalid email address information. If you would like, you could
                                update the presenter(s) contact information and re-send the session
                                key email.
                            </b>
                        </p>
                            
           
                      <form  id="action" action="reEmailSKnCUpdate" method="POST">
                       <fieldset>  
                        <div class="form-group"> 
                           <table  class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                              <thead>
                                <tr>
                                   <th>Speaker Id</th>
                                   <th>Last Name</th>
                                   <th>First Name</th>
                                   <th>Session Name</th>
                                   <th>Session Key</th>
                                   <th><label class="required">Valid Email Address</label></th>
                                </tr>
                              </thead>           
           
           <%
             
                     String [] records = strThuy.split(";");
                     for(int i=0; i<records.length; i++)
                     {
                        String[] eachRec = records[i].split(",");   
                  
          %>

                              <tr>
                                 <td><%=eachRec[0]%></td>
                                 <td><%=eachRec[1]%></td>
                                 <td><%=eachRec[2]%></td>
                                 <td><%=eachRec[3]%></td>
                                 <td><%=eachRec[4]%></td>
                                 <td><input type="email"   autofocus="true" required="required" name="<%=eachRec[0]%>" /></td>      
                              </tr>
                  
           <%               
                     }             
           %>
                        
                           </table>    
                         </div><!-- Form_group-->
                         <input type="hidden" name="hiddenString"
                                value="<%=request.getAttribute("speakerIList").toString()%>"/>
                         <input type="submit" id="update" class="button button-primary"
                                value="Re-Send and Update Email Info" />
                      </fieldset>    
                     </form>
                    </div>
          
          <%
                 }//END OF IF INVALID LIST
                }//END OF ELSE OF notSuccess is null
                 //*************************************
                 //**remove all the request attributes**
                 //*************************************
                 request.removeAttribute("infoMessage");
                 request.removeAttribute("speakerIList");
                 request.removeAttribute("speakerVList");
                 request.removeAttribute("notSuccess");
          %>
        </div> <%--END THE CONTAINER-FIXED div tag--%>
       <%@ include file="../../../includes/footer.jsp" %> 
       <%@ include file="../../../includes/scriptlist.jsp" %>
    </body>
</html>


