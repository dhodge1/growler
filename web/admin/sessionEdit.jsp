<%-- 
    Document   : sessionEdit
    Created on : Jun 10, 2013, 10:34:56 AM
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
        <title>Techtoberfest Sessions</title><!-- Title -->
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/draganddrop.css" /><!--Drag and drop style-->
        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%
                    int user = 0;
                    if (null == session.getAttribute("id")) {
                        response.sendRedirect("../index.jsp");
                    }
                    try {
                        user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
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
                <h1 class = "bordered">Edit a Session</h1>
            </div>
            
        </div>
        <div class="container-fluid">
            <div class="content">
                <!-- Begin Content -->
                <div class="row"><!--row-->
                    
                    <div class="span9 offset2"><!--span-->
                        <%
                            //Displaying error or success messages -- clear it out when done
                            String message = (String) session.getAttribute("message");
                            if (message != null) {
                                out.print("<p class=feedbackMessage-success>" + message + "</p>");
                                session.removeAttribute("message");
                            }
                        %>
                        <section>
                            <%
                                int id = Integer.parseInt(request.getParameter("id"));
                                SessionPersistence sp = new SessionPersistence();
                                Session s = sp.getSessionByID(id);
                            %>
                            <form action="../model/processSessionEdit.jsp" method="post" onsubmit="return validateForm();">
                                <div class="form-group">
                                    <label class="required">Name:</label>
                                    <input type="text" name="name" value="<% out.print(s.getName());%>" class="input-xlarge" id="tip" data-content="70 characters or less please" maxlength="70"/>
                                    <input type="hidden" name="id" value="<% out.print(s.getId());%>"/>
                                </div>
                                <div class="form-group">
                                    <label>Description:</label>
                                    <input type="text" name="description" value="<% out.print(s.getDescription());%>" class="input-xlarge" id="tip2" data-content="200 characters or less please" maxlength="200"/>
                                </div>
                                <div class="form-actions">
                                    <input type="submit" class="button button-primary" value="Submit"/>
                                </div>
                            </form>
                        </section>
                    </div>
                    <div class="span7">
                        <p></p>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Content -->

        <div class="row">
            <div class="span8">
                <p></p>
            </div>
            <div class="span2">
            </div>
        </div>

        <%@ include file="../includes/footer.jsp" %> 
        <%@ include file="../includes/scriptlist.jsp" %>
        <script>
                                $(function() {
                                    $("input").autoinline();
                                });
                                function validateForm() {
                                    var name = document.getElementsByName("name");
                                    for (var i = 0; i < name.length; i++) {
                                        name[i].value = name[i].value.trim();
                                        if (name[i].value == "") {
                                            alert("Name cannot be empty!");
                                            name[i].focus();
                                            return false;
                                        }
                                    }
                                    return true;
                                }
        </script>
    </body>
</html>
