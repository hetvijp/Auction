<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="Customer.css" type="text/css">
<title>Customer Page</title>
</head>
<body>
	
	<h1>Successfully logged in!</h1>
	<h3>Welcome <%= session.getAttribute("name") %>!</h3>
	<p>Do you want to delete your account?</p>
	
	<%
	
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		String userId = (String) session.getAttribute("user");
		
		ResultSet result = stmt.executeQuery("select * from account where username='" + userId + "'");
		
		while(result.next()){
			String name = result.getString(2);
			
			
	%>
		<form action="DeleteCustomer.jsp">
			<input class="deleteSubmit" type="Submit" value="Delete">
			<input type="hidden" name="name" value=<%=name%>>
		</form>
		
	<%
		}
	%>
	
	<p>Reset Password</p>	
	<div class="submit">
		<a href="Reset/ResetForm.jsp"><button>Reset</button></a>
	</div>
	
	<div class="logout">
		<a href="CustomerLogout.jsp"><button>Logout</button></a>
	</div>

</body>
</html>