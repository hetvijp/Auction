<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="Admin.css" type="text/css">
<title>Admin Login Page</title>
</head>
<body>
	<h3>Admin Login Page</h3>
	<form action="CheckAdmin.jsp" method="POST">
		<div class="username">
			<label for="text">Username: </label>
			<input type="text" name="Username" id="text" required/>
		</div> 
		<br />
		<div class="password">
			<label for="password">Password: </label>
			<input type="password" name="Password" id="password" required/>
		</div>
		<div class="submit">
			<input type="submit" value="Submit"/>
		</div>
	</form>
	<div class="back">
		<a href="../LoginPage.jsp"><button>Back</button ></a>
	</div>
</body>
</html>