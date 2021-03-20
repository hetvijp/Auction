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
	<h3>Create Account</h3>
	<form action="SubmitNewAccount.jsp" method="POST">
		<div>
			<label for="username">Username:</label>
			<input type="text" name="Username" id="username" required />
		</div>
		<br/>
		<div>
			<label for="name">Name:</label>
			<input type="text" name="Name" id="name" required />
		</div>
		<br/>
		<div>
			<label for="email">Email:</label>
			<input type="email" name="Email" id="email" required />
		</div>
		<br/>
		<div>
			<label for="phone">Phone:</label>
			<input type="text" name="Phone" placeholder="1234567890" minlength="10" maxlength="10" id="phone" required />
		</div>
		<br/>
		<div>
			<label for="dob">Date of Birth:</label>
			<input type="date" name="DOB" id="dob" required />
		</div>
		<br/>
		<div>
			<label for="address">Address:</label>
			<input type="text" name="Address" placeholder="Street Name, City, State, Zipcode" id="address" required />
		</div>
		<br/>
		<div>
			<label for="password">Password:</label>
			<input type="password" name="Password" minlength="8" maxlength="20" id="password" required />
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