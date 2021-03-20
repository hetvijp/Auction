<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Representative Page</title>
</head>
<body>
	<h1>Successfully logged in!</h1>
	<h3>Welcome <%= session.getAttribute("name") %>!</h3>
	<div><a href="CustomerRepLogout.jsp"><button>Logout</button></a></div>
</body>
</html>