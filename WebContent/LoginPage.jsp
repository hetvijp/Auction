<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="LoginPage.css" type="text/css">
<title>Login Page</title>
</head>
<body>
	<h1>Login Page!!</h1>
	
	<div class="customer">
		<a href="Customer/CustomerLogin.jsp"><button>Customer</button></a>
	</div>
	<div class="admin">
		<a href="Admin/AdminLogin.jsp"><button>Administrator</button></a>
	</div>
	<div class="customerRep">
		<a href="CustomerRepresentative/CustomerRepLogin.jsp"><button>Customer Representative</button></a>
	</div>
	
</body>
</html>