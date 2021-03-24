<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="CustomerRep.css" type="text/css">
<title>Insert title here</title>
</head>
<body>
	<%@ page import="java.sql.*" %>
	<%
	try {
		String userId = request.getParameter("Username");
		String password = request.getParameter("Password");
		
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		ResultSet username;
		ResultSet pass;
		username = stmt.executeQuery("SELECT * from customerrep where username='" + userId + "'");
		
		if(username.next())
		{
			ResultSet customerrep;
			customerrep = stmt.executeQuery("SELECT * from account where username='" + userId + "'");
			customerrep.next();
			String name = customerrep.getString("name");
			pass = stmt.executeQuery("SELECT * from account where username='" + userId + "' and password='" + password + "'");
	
			if(pass.next()){
				session.setAttribute("user", userId);
				session.setAttribute("name", name);
				response.sendRedirect("CustomerRepPage.jsp");
			}
			else{
	%>
				<p>Invalid password. <a href='CustomerRepLogin.jsp'>Try again!</a></p>
	<%
			}
		}
		else{
			out.println("This customer representative account is not created yet. Contact Administration to create the account.");
	%>
			<div><a href="../LoginPage.jsp"><button>Back</button></a></div>
	<%
		}
		
		db.closeConnection(con);
	}
	catch (Exception ex){
		out.print(ex);
	}
		
	%>
</body>
</html>