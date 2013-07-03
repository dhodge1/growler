<%-- 
    Document   : logout
    Created on : Mar 12, 2013, 12:19:01 PM
    Author     : Justin Bauguess
    Purpose    : To process logging out of the system
--%>
        <%
            String username = (String) session.getAttribute("user");
            if (username != null) {
                session.removeAttribute("user");
                session.removeAttribute("id");
                session.removeAttribute("message");
            }
            response.sendRedirect("../index.jsp");

        %>