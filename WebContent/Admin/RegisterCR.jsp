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
	try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		String userId = request.getParameter("Username");
		String name = request.getParameter("Name");
		String email = request.getParameter("Email");
		String phone = request.getParameter("Phone");
		String dob = request.getParameter("DOB");
		String address = request.getParameter("Address");
		String password = request.getParameter("Password");
		
		ResultSet result = stmt.executeQuery("SELECT * from account where username='" + userId + "'");
		
		if(result.next()){
	%>
		<p>Username already exists.</p>
		<div class="submit">
			<a href="CreateCR.jsp"><button>Back</button></a>
		</div>
	<%
		}
		else{
			String insert = "INSERT INTO account(username, name, password, email, phone, dob, address)" + "VALUES (?,?,?,?,?,?,?)";
			
			PreparedStatement ps = con.prepareStatement(insert);
			
			ps.setString(1, userId);
			ps.setString(2, name);
			ps.setString(3, password);
			ps.setString(4, email);
			ps.setString(5, phone);
			ps.setString(6, dob);
			ps.setString(7, address);
			
			ps.executeUpdate();
			
			String insertEndUser = "INSERT INTO customerrep values (?)";
			PreparedStatement ps2 = con.prepareStatement(insertEndUser);
			ps2.setString(1, userId);
			ps2.executeUpdate();
	%>
			<h4>Account Created!</h4>
			<div class="submit">
				<a href="AdminPage.jsp"><button>Back</button></a>
			</div>
	<%	
		}
		
		con.close();
	}
	catch (Exception ex){
		out.print(ex);
	}
		
	%>
</body>
</html>