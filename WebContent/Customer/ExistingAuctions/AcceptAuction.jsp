<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="Customer.css" type="text/css">
	<title>Congratulations!</title>
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
		Statement stmt = con.createStatement();
		
		String userId = (String) session.getAttribute("user");
		int auctionID = Integer.parseInt(request.getParameter("auctionID"));
		
		// CHANGING THE AUCTION TUPLE TO READ AS "SOLD"
		PreparedStatement stmtc = con.prepareStatement("UPDATE auction SET sold = 1 WHERE auction_id = ?;");
		stmtc.setInt(1, auctionID);
		stmtc.executeUpdate();
		
		%> 
		<h3>Fantastic!</h3>
		<p>You're now the proud owner of <% out.print(request.getParameter("productName")); %>. Expect a delivery in the next 5-7 business days.</p>
		
		<a href="../CustomerPage.jsp"><button>Return to Main Menu</button></a>
		<% 
		
		con.close();
	}
	catch (Exception ex){
		out.print(ex);
	}
		
	%>

</body>
</html>