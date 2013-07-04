<%-- 
    Document   : theme
    Created on : Feb 28, 2013, 7:15:03 PM
    Author     : Justin Bauguess & Jonathan C. McCowan
    Purpose    : The theme (admin) page is for admins to edit theme information. 
                The editable fields are simply if the theme is visible to a user 
                or not.  It will display the theme name, how many rating points 
                it has earned, and how many times someone has rated it.  It will 
                also display the creator of the theme.
--%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page" />
<jsp:useBean id="giveStars" class="com.scripps.growler.GiveStars" scope="page" />
<jsp:useBean id="persist" class="com.scripps.growler.ThemePersistence" scope="page" />
<jsp:useBean id="upersist" class="com.scripps.growler.UserPersistence" scope="page" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js lt-ie9" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="description" content="Growler Project Tentative Layout" /><!-- Description -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <title>Admin Themes</title><!-- Title -->

        <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" /> 
        <link rel="stylesheet" href="../../../css/bootstrap/bootstrap.1.2.0.css" /><!--Using bootstrap 1.2.0-->
        <link rel="stylesheet" href="../../../css/bootstrap/responsive.1.2.0.css" /><!--Basic responsive layout enabled-->
        <link rel="stylesheet" href="../../../css/demo.css" />  
        <link rel="stylesheet" href="../../../css/draganddrop.css" /><!--Drag and drop style-->
        <link rel="stylesheet" type="text/css" href="../../../css/general.css" /><!--General CSS-->
        <link rel="stylesheet" type="text/css" href="../../../css/theme.css" /><!--Theme CSS-->
        <link rel="stylesheet" href="/resources/demos/style.css" />

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

        <%@ include file="../../../includes/header.jsp" %> 
        <%@ include file="../../../includes/adminnav.jsp" %>
        <div class="container-fixed">
            <br/><br/><br/>
            <div class="row">
                <div class="span8">
                    <h2 class="bordered"><img src='../../../images/Techtoberfest2013small.png'/>Themes</h2>
                </div>
            </div>
            <br/>
            <div class="row">
                <div class="span8">
                    <%
                        ArrayList<Theme> themes = persist.getAllThemes(" order by rating desc, name asc ");
                    %>
                    <form action="../../../action/admintheme.jsp" >
                        <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                            <tr>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Reason</th>
                                <th>Rating</th>
                                <th>Times Rated</th>
                                <th>Visible?</th>
                                <th>Created By</th>
                                <th>Edit Theme</th>
                                <th>Remove Theme</th>
                            </tr>
                            <%
                                for (int i = 0; i < themes.size(); i++) {
                            %>
                            <tr>
                                <td><% out.print(themes.get(i).getName());%>
                                    <input type="hidden" name="list" value="<% out.print(themes.get(i).getId());%>" /></td>
                                <td><% out.print(themes.get(i).getDescription());%></td>
                                <td><% if (themes.get(i).getReason() != null) {
                                                            out.print(themes.get(i).getReason());
                                                        }%></td>
                                <td><% out.print(themes.get(i).getRank());%></td>
                                <td><% out.print(themes.get(i).getCount());%></td>
                                <td><input type="checkbox" name="visible" value="<% out.print(themes.get(i).getId());%>"
                                           <% if (themes.get(i).getVisible() == true) {
                                                                       out.print(" checked");
                                                                   }%>/></td>
                                <td><% out.print(upersist.getUserByID(themes.get(i).getCreatorId()).getUserName());%></td>
                                <td><a href="edittheme.jsp?id=<%out.print(themes.get(i).getId());%>">Edit</a></td>
                                <td><a href="../../../action/removeTheme.jsp?id=<%out.print(themes.get(i).getId());%>">Remove</a></td>
                            </tr>
                            <% } //close the for loop %>
                        </table>
                        <input type="submit" value="Submit" class="button button-primary" />
                    </form>
                </div>
            </div>
        </div>
        <%@ include file="../../../includes/footer.jsp" %>
        <%@ include file="../../../includes/scriptlist.jsp" %>
    </body>
</html>

