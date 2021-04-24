<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="Customer.css" type="text/css">
	<title>New Auction Created</title>
	
	<style>
		body {
			font-family: sans-serif;
		}
		
		table, tr, td {
			border: 1px solid black;
		}
	</style>
	
</head>
<body>
				
	<%
	try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		
		// INSERTING THE NECESSARY INFORMATION INTO THE AUCTION TABLE
		PreparedStatement stmt = con.prepareStatement("INSERT into auction (highest_bid, init_price, min_price, end_date_time, min_increment, username, init_date_time, product_id, sold) VALUES (0, ?, ?, ?, ?, ?, NOW(), ?, false)");
		stmt.setFloat(1, Float.parseFloat(request.getParameter("Initial Price")));
		stmt.setFloat(2, Float.parseFloat(request.getParameter("Minimum Price")));
		stmt.setFloat(4, Float.parseFloat(request.getParameter("Minimum Increment")));
		
		// I'M ASSUMING THAT THE USER WILL USE PROPER JUDGEMENT IN INPUTTING AN END DATE AND TIME THAT IS LATER THAN THE CURRENT DATETIME
		String end_date_time = request.getParameter("End Date") + " " + request.getParameter("End Time") + ":00";
		stmt.setString(3, end_date_time);
		stmt.setString(5, request.getParameter("Username"));
		stmt.setInt(6, Integer.parseInt(request.getParameter("Product ID")));
		stmt.executeUpdate();
		
	%>
	
	<p>Your auction has been successfully created! Please proceed to the full list of auctions.</p>
	<br>
	<a href="../ExistingAuctions/AuctionsMain.jsp"><button>Active Auctions</button></a>
	<% 
		con.close();
	}
	catch (Exception ex){
		out.print(ex);
	}
	%>

</body>
</html>