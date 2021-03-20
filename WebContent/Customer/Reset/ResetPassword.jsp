<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="Reset.css" type="text/css">
<title>Insert title here</title>
</head>
<body>
	<%
		try{
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			
			String userId = request.getParameter("Username");
			String oldPass = request.getParameter("Old_Password");
			String newPass = request.getParameter("New_Password");
			String pass = "";
			
			ResultSet result = stmt.executeQuery("SELECT * FROM ACCOUNT WHERE password='" + oldPass + "'");
			
			while(result.next()){
				pass = result.getString(3);
			}
			
			if(pass.equals(oldPass)){
				stmt.executeUpdate("update account set password='" + newPass + "' where username='" + userId + "'");
	%>
				<p>Password changed successfully</p>
				<a href="../../LoginPage.jsp"><button>Home</button></a>
	<%
				con.close();
			}
			else{
	%>
			<p>Invalid Current Password</p>
			<a href="CustomerLogin.jsp"><button>Login</button></a>
	<%
			}
		}
		catch(Exception ex){
			out.print(ex);
		}
	%>
</body>
</html>