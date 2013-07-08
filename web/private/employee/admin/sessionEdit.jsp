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
        <link rel="stylesheet" href="../../../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../../../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../../../css/draganddrop.css" /><!--Drag and drop style-->
        <script src="../../../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%
            int user = 0;
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../../../index.jsp");
            } else if (!session.getAttribute("user").equals("admin")) {
                response.sendRedirect("../../../index.jsp");
            }
            try {
                user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                String name = String.valueOf(session.getAttribute("user"));
            } catch (Exception e) {
            }
        %>
        <%@ include file="../../../includes/adminheader.jsp" %> 
        <%@ include file="../../../includes/adminnav.jsp" %>
        <div class="container-fixed">
            <br/><br/><br/>
            <div class="row">
                
                    <h2 class="bordered"><img src='../../../images/Techtoberfest2013small.png'/><span>Edit a Session</span></h2>
                
            </div>
            <br/>
            <div class="row">
                
                    <%
                        int id = Integer.parseInt(request.getParameter("id"));
                        SessionPersistence sp = new SessionPersistence();
                        Session s = sp.getSessionByID(id);
                    %>
                    <form action="../../../action/processSessionEdit.jsp" method="post" onsubmit="return validateForm();">
                        <div class="form-group">
                            <label class="required">Name:</label>
                            <input type="text" name="name" value="<% out.print(s.getName());%>" class="input-xlarge" size="50" id="tip" data-content="70 characters or less please" maxlength="70"/>
                            <input type="hidden" name="id" value="<% out.print(s.getId());%>"/>
                        </div>
                        <div class="form-group">
                            <label>Description:</label>
                            <textarea name="description" class="input-xlarge" cols="50" rows='5' id="tip2" data-content="250 characters or less please" maxlength="250"><% out.print(s.getDescription());%></textarea>
                        </div>
                        <div class="form-actions">
                            <input type="submit" class="button button-primary" value="Submit"/>
                            <a id="cancel" class="button" href="session.jsp">Cancel</a>
                        </div>
                    </form>
                
            </div>
        </div>

        <%@ include file="../../../includes/footer.jsp" %> 
        <%@ include file="../../../includes/scriptlist.jsp" %>
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
