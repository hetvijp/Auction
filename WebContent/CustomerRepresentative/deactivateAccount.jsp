<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
		<form action="deactivateAccountConfirm.jsp" method="POST">
    		<label>Account name</label>
          	<input type="text" name="account_name" placeholder="Username" required> <br>
            	
            <label>Password</label>
            <input type="password" name="password" placeholder="Password" required> <br>
            	 			
    		<input type="submit" value="Deactivate Account">
    	</form>
</body>
</html>