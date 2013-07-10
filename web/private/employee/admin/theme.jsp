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
            String sort = "";
            if (null == session.getAttribute("id")) {
                response.sendRedirect("../../../index.jsp");
            } else if (!session.getAttribute("user").equals("admin")) {
                response.sendRedirect("../../../index.jsp");
            }
            try {
                sort = request.getParameter("sort");
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

                <h2 class="bordered"><img style="padding-bottom:0;padding-left:0;" src='../../../images/Techtoberfest2013small.png'/><span class="titlespan">Themes</span></h2>

            </div>
            <br/>
            <div class="row">

                <%
                    ArrayList<Theme> themes = persist.getAllThemes(" order by rating desc, name asc ");
                    try {
                        if (sort.equals("name_desc") && !sort.isEmpty()) {
                            themes = persist.getAllThemes(" order by name desc");
                        } else if (sort.equals("name_asc") && !sort.isEmpty()) {
                            themes = persist.getAllThemes(" order by name asc");
                        } else if (sort.equals("reason_asc") && !sort.isEmpty()) {
                            themes = persist.getAllThemes(" order by reason asc, id");
                        } else if (sort.equals("reason_desc") && !sort.isEmpty()) {
                            themes = persist.getAllThemes(" order by reason desc, id");
                        } else if (sort.equals("description_asc") && !sort.isEmpty()) {
                            themes = persist.getAllThemes(" order by description asc, name");
                        } else if (sort.equals("description_desc") && !sort.isEmpty()) {
                            themes = persist.getAllThemes(" order by description desc, name");
                        } else if (sort.equals("rating_asc") && !sort.isEmpty()) {
                            themes = persist.getAllThemes(" order by rating asc, name");
                        } else if (sort.equals("rating_desc") && !sort.isEmpty()) {
                            themes = persist.getAllThemes(" order by rating desc, name");
                        } else if (sort.equals("times_asc") && !sort.isEmpty()) {
                            themes = persist.getAllThemes(" order by count asc, name");
                        } else if (sort.equals("times_desc") && !sort.isEmpty()) {
                            themes = persist.getAllThemes(" order by count desc, name");
                        } else if (sort.equals("creator_asc") && !sort.isEmpty()) {
                            themes = persist.getAllThemes(" order by creator asc, name");
                        } else if (sort.equals("creator_desc") && !sort.isEmpty()) {
                            themes = persist.getAllThemes(" order by creator desc, name");
                        } else if (sort.equals("visible_asc") && !sort.isEmpty()) {
                            themes = persist.getAllThemes(" order by visible asc, name");
                        } else if (sort.equals("visible_desc") && !sort.isEmpty()) {
                            themes = persist.getAllThemes(" order by visible desc, name");
                        }
                    } catch (Exception e) {
                        themes = persist.getAllThemes(" order by rating desc, name");
                    }
                %>
                <form action="../../../action/admintheme.jsp" >
                    <table class="table table-alternatingRow table-border table-columnBorder table-rowBorder">
                        <tr>
                            <th>Name
                                <a href="theme.jsp?sort=name_asc"><i class="icon12-sortUp"></i></a>
                                <a href="theme.jsp?sort=name_desc"><i class="icon12-sortDown"></i></a>
                            </th>
                            <th>Description
                                <a href="theme.jsp?sort=description_asc"><i class="icon12-sortUp"></i></a>
                                <a href="theme.jsp?sort=description_desc"><i class="icon12-sortDown"></i></a>
                            </th>
                            <th>Reason
                                <a href="theme.jsp?sort=reason_asc"><i class="icon12-sortUp"></i></a>
                                <a href="theme.jsp?sort=reason_desc"><i class="icon12-sortDown"></i></a>
                            </th>
                            <th>Rating
                                <a href="theme.jsp?sort=rating_asc"><i class="icon12-sortUp"></i></a>
                                <a href="theme.jsp?sort=rating_desc"><i class="icon12-sortDown"></i></a>
                            </th>
                            <th>Times Rated
                                <a href="theme.jsp?sort=times_asc"><i class="icon12-sortUp"></i></a>
                                <a href="theme.jsp?sort=times_desc"><i class="icon12-sortDown"></i></a>
                            </th>
                            <th>Visible?
                                <a href="theme.jsp?sort=visible_asc"><i class="icon12-sortUp"></i></a>
                                <a href="theme.jsp?sort=visible_desc"><i class="icon12-sortDown"></i></a>
                            </th>
                            <th>Created By
                                <a href="theme.jsp?sort=creator_asc"><i class="icon12-sortUp"></i></a>
                                <a href="theme.jsp?sort=creator_desc"><i class="icon12-sortDown"></i></a>
                            </th>
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
        <%@ include file="../../../includes/footer.jsp" %>
        <%@ include file="../../../includes/scriptlist.jsp" %>
    </body>
</html>

