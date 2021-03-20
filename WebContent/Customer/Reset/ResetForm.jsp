<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="Reset.css" type="text/css">
<title>Reset Password Page</title>
</head>
<body>

		<form action="ResetPassword.jsp">
			<div>
				<label for="username">Username:</label>
				<input type="text" name="Username" id="username" required/>
			</div>
			<br />
			<div>
				<label for="old_password">Old password:</label>
				<input type="text" name="Old_Password" id="old_password" required/>
			</div>
			<br />
			<div>
				<label for="new_password">New password:</label>
				<input type="text" name="New_Password" id="new_password" required/>
			</div>
			<br />
			<div class="submit">
				<button>Submit</button>
			</div>
		</form>
	
	<div class="back">
			<a href="../CustomerPage.jsp"><button>Back</button></a>
	</div>
	
</body>
</html>