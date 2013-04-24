<%-- 
    Document   : header
    Created on : Feb 27, 2013, 9:30:50 PM
    Author     : Justin Bauguess & Jonathan C. McCowan
				 This file goes above the usernav.jsp file in the web pages and adds the header information to the web pages.
				 This file also adds the "welcome <user> !" text to the header and will also send users who aren't logged in to the
                 log in page.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
  <header class="pageHeader">
    <div class="pageHeader-portal">
      <div class="pageHeader-logo">
        <a href="/"></a>
		<font color="#FFFFFF">
		<%
		 //Get the user's info, and post a welcome!
		 if (!String.valueOf(session.getAttribute("user")).isEmpty()) {
			String user = String.valueOf(session.getAttribute("user"));
			out.print("    Welcome, " + user + "!");
			}
		 //If they aren't logged in, we want them to go back and log in.
		 else {
			response.sendRedirect("../index.jsp");
		 }
		%>
		</font>
      </div>
    </div>
  </header><!-- /.pageHeader -->
	
