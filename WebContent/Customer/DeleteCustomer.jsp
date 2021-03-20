<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="Customer.css" type="text/css">
<title>Insert title here</title>
</head>
<body>
	<%
		try{
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			
			String userId = (String) session.getAttribute("user");
			String name = request.getParameter("name");
			
			stmt.executeUpdate("delete from account where username='" + userId + "' and name= (select trim(name))");
			
			ResultSet result = stmt.executeQuery("select username from account where username='" + userId + "'");
			
			if(result.next()){
	%>
			<p>Account is not deleted yet. Try again!</p>
			<p>Or contact Help Desk</p>
			<div class="back">
				<a href="../LoginPage.jsp"><button>Home</button></a>
			</div>
	<%
			}
			else{
	%>
				<h4>Account deleted</h4>
				<div class="back">
					<a href="../LoginPage.jsp"><button>Home</button></a>
				</div>
	<%	
			}			
		}
		catch (Exception ex){
			out.print(ex);
		}
	
	%>
	
</body>
</html>