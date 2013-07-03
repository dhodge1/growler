<%-- 
    Document   : registerinterest
    Created on : Jun 11, 2013, 9:04:19 AM
    Author     : 162107
    Purpose    : Processes data received from sessionschedule.jsp.
                 First, it clears the previous registrations of interest for the user.
                 Next, it takes the interests received from the form and inserts them
                 into the database.  Finally, it returns to the sessionschedule page
                 with a success message.
--%>

<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.scripps.growler.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <%
        //Get the necessary values
        
        String[] interest = request.getParameterValues("interest");
        String[] names = request.getParameterValues("name");
        //Convert the List of sessionIDs into integers   
        int ids[] = new int[names.length];
        for (int i = 0; i < ids.length; i++) {
            ids[i] = Integer.parseInt(names[i]);
        }
        //Clear out the old ranks
        DataConnection dc = new DataConnection();
        Connection connection = dc.sendConnection();
        Statement dstatement = connection.createStatement();
        dstatement.execute("delete from registration where user_id = " + user);
        try {
            //Convert the List of registered sessionIDs into integers   
            int interests[] = new int[interest.length];
            for (int i = 0; i < interest.length; i++) {
                interests[i] = Integer.parseInt(interest[i]);
            }
            PreparedStatement statement = connection.prepareStatement("insert into registration (user_id, session_id, date_registered, time_registered) "
                    + " values (?, ?, curdate(), curtime())");
            //Search through the array for values to enter, then execute the PreparedStatement
            Arrays.sort(interests);
            Arrays.sort(ids);
            for (int i = 0; i < ids.length; i++) {
                if (Arrays.binarySearch(interests, ids[i]) >= 0) {
                    try {
                        statement.setInt(1, user);
                        statement.setInt(2, ids[i]);
                        statement.execute();
                    } catch (Exception e) {
                    }
                }
            }
            session.setAttribute("message", "Success: Your interest has been registered!");
        } catch (Exception e) {
            //It makes it here if/when it cannot process the for loop because of a null pointer - which means there are no sessions to register
            session.setAttribute("message", "Success: Your interests have been removed!");
        }
        response.sendRedirect("../private/employee/sessionschedule.jsp");

    %>