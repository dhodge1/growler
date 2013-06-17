<%-- 
    Document   : surveyReport
    Created on : Jun 10, 2013, 2:18:37 PM
    Author     : 162107
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
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

        <title>Techtoberfest Report</title>

        <link rel="stylesheet" href="../css/jquery-ui/jquery-ui-1.9.2.custom.min.css" />
        <link rel="stylesheet" href="../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../css/prettify/prettify.css" /> 
        <link rel="stylesheet" type="text/css" href="../css/general.css" /><!--General CSS-->

        <script src="../js/libs/modernizr.2.6.2.custom.min.js"></script><!--Modernizer-->
    </head>
    <body id="growler1">
        <%
                   int user = 0;
                    if (null == session.getAttribute("id")) {
                        response.sendRedirect("../index.jsp");
                    }
                    else if (!session.getAttribute("user").equals("admin")) {
                        response.sendRedirect("../index.jsp");
                    }
                    try {
                        user = Integer.parseInt(String.valueOf(session.getAttribute("id")));
                        String name = String.valueOf(session.getAttribute("user"));                  
                    }
                    catch (Exception e) {
                        
                    }
                %>
        <%@ include file="../includes/header.jsp" %> 
        <%@ include file="../includes/adminnav.jsp" %>  
        <div class="row">
            <div class="span3">
                <img class="logo" src="../images/Techtoberfest2013admin.png" alt="Techtoberfest 2013 admin"/>
            </div>
            <div class="span5">
                <h1 class = "bordered largeBottomMargin">Report: Interest in Sessions</h1>
            </div>
        </div>
        <div class="container-fluid">
            <div class="content" role="main"><!-- Begin Content -->	
                <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                    <tr>                    
                        <th>Session Name</th>
                        <th>Description</th>
                        <th>Speaker(s)</th>
                        <th># Interested</th>
                    </tr>
                    <%  ReportGenerator rg = new ReportGenerator();
                        ArrayList<InterestReport> interest = rg.generateInterestReport();
                        
                        
                        for(int i = 0; i < interest.size(); i++) {
                            out.print("<tr>");
                            out.print("<td>");
                            out.print(interest.get(i).getSessionName());
                            out.print("</td>");
                            out.print("<td>");
                            out.print(interest.get(i).getSessionDescription());
                            out.print("</td>");
                            out.print("<td>");
                            ArrayList<Speaker> speakers = interest.get(i).getSpeakers();
                            for (int x = 0; x < speakers.size(); x++) {
                                out.print(speakers.get(x).getLastName() + ", " + speakers.get(x).getFirstName() + " <br/> ");
                            }
                            out.print("</td>");
                            out.print("<td>");
                            out.print(interest.get(i).getInterested());
                            out.print("</td>");
                            out.print("</tr>");
                        }
                    %>
                </table>
                <label><a href="../admin/download.jsp?type=interset">Download a PDF</a></label>
            </div><!-- /.content -->
        </div><!-- /.container-fluid -->

        <%@ include file="../includes/footer.jsp" %> 
        <%@ include file="../includes/scriptlist.jsp" %>
    </body>
</html>
