<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Account Deactivation Confirmation</title>
</head>
<body>
<% 
	try{
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		String accountName = request.getParameter("account_name");
		String password = request.getParameter("password");
		
		stmt.executeUpdate("delete from account where username='" + accountName + "' and password = '" + password + "'");
		
		ResultSet result = stmt.executeQuery("select username from account where username='" + accountName + "'");
		
		if(result.next()){
			%>
					<p>Account is not deleted yet. Try again!</p>
					<div class="back">
							<a href="CustomerRepPage.jsp"><button>Back</button></a>
					</div>
			<%
					}
					else{
			%>
						<h4>Account deleted</h4>
						<div class="back">
							<a href="CustomerRepPage.jsp"><button>Back</button></a>
						</div>
			<%	
					}			
	}
	catch(Exception ex){
		out.print(ex);
	}
%>
</body>
</html>