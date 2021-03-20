<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="CustomerRep.css" type="text/css">
<title>Customer Representative Login Page</title>
</head>
<body>
	<h3>Customer Representative Login Page</h3>
	<form action="CheckCustomerRep.jsp" method="POST">
		<div class="username">
			<label for="username">Username: </label>
			<input type="text" name="Username" id="username" required/>
		</div>
		<br />
		<div class="password">
			<label for="password">Password: </label>
			<input type="password" name="Password"  minlength="8" maxlength="30" id="password" required/>
		</div>
			<div class="submit">
			<input type="submit" value="Submit"/>
		</div>
	</form>
	<div class="back">
		<a href="../LoginPage.jsp"><button>Back</button></a>
	</div>
</body>
</html>