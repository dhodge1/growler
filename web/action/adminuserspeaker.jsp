<%-- 
    Document   : adminuserspeaker.jsp
    Created on : Mar 5, 2013, 8:13:49 PM
    Author     : Justin Bauguess
    Purpose    : The purpose of adminuserspeaker.jsp is for admins to be able to
                edit the speaker data of user suggested speakers.  The data that can be edited will be:
                2012 rank, the count of 2012 ranks, and whether or not it is 
                visible to the regular users.  It uses the ranks_2012 table, and
                speaker table.
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
            String visible[];
            visible = request.getParameterValues("visible");


            //Convert the List of IDs into integers   
            int ids[] = new int[list.length];
            for (int i = 0; i < ids.length; i++) {
                ids[i] = Integer.parseInt(list[i]);
            }
            int visibles[] = new int[1];
            visibles[0] = -1;
            //Get the list of visibles from the check boxes
            try {
                visibles = new int[visible.length];
                for (int i = 0; i < visibles.length; i++) {
                    visibles[i] = Integer.parseInt(visible[i]);
                }
            } catch (Exception e) {
                visibles = new int[1];
                visibles[0] = -1;
            }


            Connection connection = dataConnection.sendConnection();
            Statement statement = connection.createStatement();
            PreparedStatement visibility = connection.prepareStatement(queries.promoteSpeaker());
            //Sort the array before using binary search
            Arrays.sort(visibles);
            //If the key is in the visibles array, we know the admin wants it visible
            for (int k = 0; k < ids.length; k++) {
                if (Arrays.binarySearch(visibles, ids[k]) >= 0) {
                    visibility.setInt(1, 1);
                } else {
                    visibility.setInt(1, 0);
                }
                visibility.setInt(2, ids[k]);
                visibility.execute();
            }
            connection.close();
            statement.close();
            visibility.close();
            session.setAttribute("message", "Success: Changes were successful.");
            response.sendRedirect("../private/employee/admin/userspeaker.jsp");
        %>