<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="Customer.css" type="text/css">
	<title>Processing Bid</title>
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
		String username = request.getParameter("Username");
		float bid = Float.parseFloat(request.getParameter("Bid Amount"));
		int auctionID = Integer.parseInt(request.getParameter("Auction ID"));
		
		// IF THIS IS SOMEONE'S FIRST BID, WE NEED TO SET UP THEIR AUTO_BID INFORMATION (ESTABLISHING THEIR RELATIONSHIP WITH THE AUCTION)
		Statement stmt3 = con.createStatement();
		ResultSet result3 = stmt3.executeQuery("SELECT * FROM auto_bids WHERE username = '" + username + "' and auction_id = " + auctionID + ";");
		if (!result3.next()) {
			PreparedStatement stmt4 = con.prepareStatement("INSERT into auto_bids (username, auction_id, new_high) values (?, ?, false)");
			stmt4.setString(1, username);
			stmt4.setInt(2, auctionID);
			stmt4.executeUpdate();
		}
		
		// INSERT THE NEW BID INFORMATION INTO THE DB
		PreparedStatement stmt2 = con.prepareStatement("INSERT into bids values (?, ?, NOW(), ?)");
		stmt2.setString(1, username);
		stmt2.setInt(2, auctionID);
		stmt2.setFloat(3, bid);
		stmt2.executeUpdate();
		
		// UPDATE THE CORRESPONDING TUPLE IN THE AUCTION TABLE TO INCLUDE THE NEW HIGHEST BID AND ASSOCIATED USER
		PreparedStatement stmt1 = con.prepareStatement("UPDATE auction set highest_bid = ?, highest_user = ? where auction_id = " + auctionID + ";");
		stmt1.setFloat(1, bid);
		stmt1.setString(2, username);
		stmt1.executeUpdate();
		
		// SET ALERT BOOLEAN FOR EVERYONE WHO HAS BID ON THIS AUCTION (TELL THEM THAT THERE'S BEEN A HIGHER BID)
		PreparedStatement stmtf = con.prepareStatement("UPDATE auto_bids set new_high = true WHERE auction_id = ? and username <> ?");
		stmtf.setInt(1, auctionID);
		stmtf.setString(2, username);
		stmtf.executeUpdate();
		
		
	%>
		<p>Your bid has been successfully processed. Please proceed to the complete list of auctions.</p>
		<br>
		<a href="AuctionsMain.jsp"><button>View All Auctions</button></a>
		
	<%
		
		con.close();
	}
	catch (Exception ex){
		out.print(ex);
	}
		
	%>

</body>
</html>