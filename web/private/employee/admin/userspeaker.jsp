<%-- 
    Document   : speaker
    Created on : Feb 27, 2013, 11:23:26 PM
    Author     : Justin Bauguess & Jonathan C. McCowan
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="application" />
<jsp:setProperty name="dataConnection" property = "*" />
<jsp:useBean id="giveStars" class="com.scripps.growler.GiveStars" scope="application" />
<jsp:setProperty name="giveStars" property = "*" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="application" />
<jsp:setProperty name="queries" property = "*" />
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

        <title>Admin User Speaker</title><!-- Title -->

        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="../../../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../../../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../../../css/demo.css" />  
        <link rel="stylesheet" href="../../../css/draganddrop.css" /><!--Drag and drop style-->
        <link rel="stylesheet" type="text/css" href="../../../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="../../../css/speaker.css" /><!--Speaker CSS-->

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
                
                    <h2 class="bordered"><img src='../../../images/Techtoberfest2013small.png'/>User Suggested Speakers</h2>
                
            </div>
            <br/>
            <div class="row">
                
                    <form action="../../../action/adminuserspeaker.jsp" method="post">
                        <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                            <tr>
                                <th>Speaker Name</th>
                                <th>Visible?</th>
                                <th>Suggested By</th>
                                <th>Remove</th>
                            </tr>
                            <%
                                SpeakerPersistence sp = new SpeakerPersistence();
                                ArrayList<Speaker> speakers = sp.getNonDefaultSpeakers();
                                for (int i = 0; i < speakers.size(); i++) {
                            %>
                            <tr>
                                <td>
                                    <% out.print(speakers.get(i).getLastName() + ", " + speakers.get(i).getFirstName());%>
                                    <input type="hidden" name="list" value="<% out.print(speakers.get(i).getId());%>"/>
                                </td>
                                <td>
                                    <input name="visible" type="checkbox" value="<% out.print(speakers.get(i).getId());%>"
                                           <% if (speakers.get(i).getVisible() == true) {
                                                                   out.print("checked");
                                                               }%> />
                                </td>
                                <td>
                                    <% UserPersistence up = new UserPersistence();
                                                        User u = up.getUserByID(speakers.get(i).getSuggestedBy());
                                                        out.print(u.getUserName());%>
                                </td>
                                <td><%out.print("<a href=\"../../../action/removeSpeaker.jsp?id=" + speakers.get(i).getId() + "\">Remove</a></td>");%></td>
                            </tr>
                            <% } //close for loop%>
                        </table>
                        <input type="submit" value="submit" class="button button-primary" />
                    </form>
                
            </div>
        </div>

        <%@ include file="../../../includes/footer.jsp" %>
        <%@ include file="../../../includes/scriptlist.jsp" %>
    </body>
</html>
