import java.util.*;
import java.io.*;
import javax.sql.*;
import javax.servlet.*;

/**
 @author Justin Bauguess
 @version 1.0
 @since 02-21-13
 */
public class DBConnect extends HttpServlet {
	Connection connection = null;
	/**
	Connects to the growler_db database
	
	Uses the mysql JConnect driver to establish a connection to the Project Growler Database
	*/
	public void service(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connnection = DriverManager.getConnection("jdbc:mysql://localhost/growler_db","admin","password");
			}
		catch (SQLException e) {
			throw new ServletException("Servlet Could not display records.", e);
		} 
		catch (ClassNotFoundException e) {
			throw new ServletException("JDBC Driver not found.", e);
		}
	}
 };