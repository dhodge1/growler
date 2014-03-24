
<%-- 
    Document   : emailToAllParticipants
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

        <title>Email To All Participants</title><!-- Title -->

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
               <li class='ieFix'>Participants of the Current Year</li>
             </ul>
           </div>
           <div class="row mediumBottomMargin">
             <h1 style="font-weight:normal;">E-Communications</h1>
           </div>
           <div class="row mediumBottomMargin" style="border:1px dotted #ddd"></div>
           <div class="row largeBottomMargin">
             <h3 style="font-weight:normal;">
                    Send out email to all participants of the 2014 Techtoberfest event. 
             </h3>
           </div>
           <div class="row mediumBottomMargin">
               <label><span style="color: red;">*</span>Required field</label>
           </div>
            <!--<div class='row largeBottomMargin'></div>-->
           <div class="row mediumBottomMargin">
               <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='${pageContext.request.contextPath}/images/Techtoberfest2013small.png'/><span style="padding-left: 12px;">Email Message Details</h2>
           </div> 
        
            <%--
           //***************************************************************
           //*********The code for the email form start here****************
           //***************************************************************
            --%>
            <%      
              //BEGIN**************************************************
              //**strStatus is the disable status *********************
              //**only set to true when the userArrayList is empty**
              //*******************************************************
              String strStatus = "";
              UserPersistence uPersistence = new UserPersistence();
              ArrayList<User> userArrayList = uPersistence.getUsersLikedASessionORSubmittedSurveys();
              //*********************************************
              //**Error checking for empty sessionArraylist**
              //*********************************************
              if(userArrayList.size() == 0)
              {
                strStatus = "disabled";
             //END                
           %>                       

           
                <div class="feedbackMessage-warning row">
                     <p style="text-align: center">No participants have used the system in 2014.</p>
                </div>
           
           <%
              }//END IF STMT
              else
              {
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
               }//END ELSE STMT
           %>
            
                                       
           <div class="row">
                   
              <form  id="action" action="eAllParticipants" method="POST">
                 <fieldset>
                    <div class="form-group">
                        <label class="required">Subject</label>
                      
                        <%
                           //*************************************************
                           //** inefficient way of toggling between disabled**
                           //** disabled and enabled but it works*************
                           if(strStatus.compareTo("disabled") == 0)
                           {
                        %>   
                               <input type="text" required="required" name="emailSubject" 
                                      class="input-xlarge" disabled />        
                        <%   
                           }//END OF IF
                           else
                           {
                        %> 
                        <input type="text" required="required" name="emailSubject" 
                               class="input-xlarge"/>        
                        
                        <%
                            }//END OF ELSE
                             //*********************************************
                             //END OF TOGGLING CODE
                             //**********************************************                
                        %>       
                    </div>
                    
                    <div class="form-group">
                        <label class="required">Email Content</label>
                        
                          <%
                           //*************************************************
                           //** inefficient way of toggling between disabled**
                           //** disabled and enabled but it works*************
                           if(strStatus.compareTo("disabled") == 0)
                           {
                         %>   
                       
                              <textarea cols='75' rows='20' required="required" 
                                        name="emailContent" disabled>  
                              </textarea>  
                         <%   
                           }//END OF IF
                           else
                           {
                         %> 
                         
                              <textarea cols='75' rows='20' required="required" 
                                        name="emailContent">   
                              </textarea>  
                        <%
                            }//END OF ELSE
                             //*********************************************
                             //END OF TOGGLING CODE
                             //**********************************************                
                        %>                        
                                               
                                   
                    </div>
                    <div class="form-actions">
                        
                          <%
                           //*************************************************
                           //** inefficient way of toggling between disabled**
                           //** disabled and enabled but it works*************
                           if(strStatus.compareTo("disabled") == 0)
                           {
                         %>   
                       
                              <input type="submit" id="send" class="button button-primary"
                                     value="Send" disabled/>
                         <%   
                           }//END OF IF
                           else
                           {
                         %> 
                         
                              <input type="submit" id="send" class="button button-primary"
                                     value="Send" />
                        <%
                            }//END OF ELSE
                             //*********************************************
                             //END OF TOGGLING CODE
                             //**********************************************                
                        %>                                   
                        
                         <a id="cancel" href="${pageContext.request.contextPath}/home">Cancel</a>
                    </div>  
                 </fieldset> 
              </form>	  
           </div> <%--END THE FORM'S div tag--%>                   
           
       </div> <%--END THE CONTAINER-FIXED div tag--%>
       <%@ include file="../../../includes/footer.jsp" %> 
       <%@ include file="../../../includes/scriptlist.jsp" %>
    </body>
</html>
