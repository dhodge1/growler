<%-- 
    Document   : processThemeRanking
    Created on : Mar 5, 2013, 3:31:47 PM
    Author     : Justin Bauguess
    Purpose    : The purpose of processThemeRanking is to process the data submitted 
                from theme.jsp.  It will rank the top ten themes only, the store them
                in the database.  For intial user stories, it will be placed in 
                the isolated_theme_ranking table.  Once users are remembered, it
                will be modified to store data in the theme_ranking table.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<jsp:useBean id="dataConnection" class="com.scripps.growler.DataConnection" scope="page" />
<jsp:useBean id="queries" class="com.scripps.growler.GrowlerQueries" scope="page" />
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
				<% String list[] = request.getParameterValues("list");
            ThemePersistence persist = new ThemePersistence();
            //Get a list of theme ids
            int ids[] = new int[list.length];
            for (int i = 0; i < list.length; i++) {
                ids[i] = Integer.parseInt(list[i]);
            }
            
            ArrayList<Theme> themes = persist.getUserRanks(user);
            Theme t = new Theme();
            //Check to see if the user already has voted.  If so, redirect to the theme page
            if (themes.size() > 0) {
                session.setAttribute("message", "Error: You have already voted!");
            } 
            else {
                //If they haven't voted, take their votes and put them in the database
                
                ArrayList<Theme> newThemes  = new ArrayList<Theme>();
                for (int i = 0; i < ids.length; i++) {
                    t = persist.getThemeByID(ids[i]);
                    newThemes.add(t);
                }
                persist.setUserRanks(newThemes, user);
                

                session.setAttribute("message", "Success: Your votes have been recorded");
            }
            response.sendRedirect("../private/employee/theme.jsp");
        %>
