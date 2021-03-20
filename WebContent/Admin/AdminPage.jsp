<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Page</title>
</head>
<body>
	<h1>Successfully logged in!</h1>
	<h3>Welcome <%= session.getAttribute("name") %>!</h3>
	<div><a href="AdminLogout.jsp"><button>Logout</button></a></div>
</body>
</html>