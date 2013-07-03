<%-- 
    Document   : admintheme
    Created on : Apr 2, 2013, 2:56:26 PM
    Author     : Justin Bauguess
    Purpose    : The purpose of admintheme.jsp is to process modifications to 
                the theme table from the admin's POV.  The fields modified will
                be the visible field, which determines if a regular user can see
                the theme in order to vote on it.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.DataConnection" %>
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
            String visible[] = request.getParameterValues("visible");
            //Get the list of ids
            int ids[] = new int[list.length];
            for (int i = 0; i < list.length; i++) {
                ids[i] = Integer.parseInt(list[i]);
            }
            //Get the list of items checked visible
            int[] visibles = new int[visible.length];
            for (int i = 0; i < visible.length; i++) {
                visibles[i] = Integer.parseInt(visible[i]);
            }
            Connection connection = dataConnection.sendConnection();
            Statement statement = connection.createStatement();
            PreparedStatement insert = connection.prepareStatement(queries.promoteTheme());
            //You have to sort the array first for binary search to work
            Arrays.sort(visibles);
            //If the visible value is in the visibles array, set it to 1.  Otherwise, 0.
            for (int j = 0; j < ids.length; j++) {
                if (Arrays.binarySearch(visibles, ids[j]) >= 0) {
                    insert.setInt(1, 1);
                } else {
                    insert.setInt(1, 0);
                }
                insert.setInt(2, ids[j]);
                insert.execute();
            }
            connection.close();
            statement.close();
            insert.close();
            session.setAttribute("message", "Success: Updates Successful");
            response.sendRedirect("../private/employee/admin/theme.jsp");
        %>