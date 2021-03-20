<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="Customer.css" type="text/css">
<title>Customer Login Page</title>
</head>
<body>
	
	<h3>Customer Login</h3>
	<form action="CheckCustomer.jsp" method="POST">
		<div class="username">
			<label for="username">Username: </label>
			<input type="text" name="Username" id="username" required/>
		</div>
		<br />
		<div class="password">
			<label for="password">Password: </label>
			<input type="password" name="Password" minlength="8" maxlength="20" id="password" required/>
		</div>
		<div class="submit">
			<input type="submit" value="Submit"/>
		</div>
	</form>
	
	<h3>Create New Account</h3>
	<div class="newAccount">
		<a href="CreateCustomer.jsp"><button>Sign Up</button></a>
	</div>
	
	<div class="back">
		<a href="../LoginPage.jsp"><button>Back</button></a>
	</div>
</body>
</html>