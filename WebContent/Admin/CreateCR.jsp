<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Customer Representative</title>
</head>
<body>
	<h2>Create a Customer Rep Account</h2>
	<form action="RegisterCR.jsp" method="POST">
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
</body>
</html>