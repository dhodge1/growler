<%-- 
    Document   : getSNIinfo
    Created on : May 23, 2013, 11:56:28 AM
    Author     : 162107
    Purpose    : This file is included with the index.jsp file.
                It looks for the SiteMinder headers, and places them in variables.
                Then it attempts to find the user in the database based on that info.
                If if finds the user, it adds the session variables and forwards to the website.
                If not, it adds the user to the database, then forwards them on.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.scripps.growler.*" %>
<%

    String first_name = request.getHeader("sn_first_name");
    String last_name = request.getHeader("sn_last_name");
    String email = request.getHeader("sn_email");
    String id = request.getHeader("sn_employee_id");
    String name = last_name + ", " + first_name;

    UserPersistence up = new UserPersistence();
    User u = up.getUserByEmail(email);

    if (u != null) {
        session.setAttribute("user", u.getUserName());
        session.setAttribute("id", u.getCorporateId());
        response.sendRedirect("../private/employee/home.jsp");
    } else if (!id.equals(null) || !id.equals("null")) {
        User newUser = new User();
        newUser.setId(Integer.parseInt(id));
        newUser.setCorporateId(id);
        newUser.setUserName(name);
        newUser.setEmail(email);
        up.addUser(newUser);
        response.sendRedirect("../private/employee/home.jsp");
    }




%>
