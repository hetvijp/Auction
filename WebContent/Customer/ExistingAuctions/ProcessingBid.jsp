<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.math.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="Customer.css" type="text/css">
	<title>Processing Manual Bid</title>
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
		
		// TRYING TO PARSE OUT THE BID STRING TO MAKE SURE THAT IT IS A VALID INPUT
		String bid = request.getParameter("Bid Amount");
		int stringptr = 0;
		while (stringptr < bid.length()) {
			if (bid.charAt(stringptr) == '.') {
				break;
			}
			stringptr++;
		}
		String roundedBid;
		if (stringptr < bid.length() - 3) { // THERE WERE MORE DECIMAL PLACES INPUTTED AFTER THE HUNDREDTHS PLACE
			roundedBid = bid.substring(0, stringptr + 3);
		} else {
			roundedBid = bid;
		}
		BigDecimal actualBid = new BigDecimal(roundedBid);
		
		int auctionID = Integer.parseInt(request.getParameter("Auction ID"));
		
		// IF THIS IS SOMEONE'S FIRST BID, WE NEED TO SET UP THEIR AUTO_BID INFORMATION (ESTABLISHING THEIR RELATIONSHIP WITH THE AUCTION)
		Statement stmt3 = con.createStatement();
		ResultSet result3 = stmt3.executeQuery("SELECT * FROM auto_bids WHERE username = '" + username + "' and auction_id = " + auctionID + ";");
		if (!result3.next()) {
			PreparedStatement stmt4 = con.prepareStatement("INSERT into auto_bids (username, auction_id, new_high) values (?, ?, false)");
			stmt4.setString(1, username);
			stmt4.setInt(2, auctionID);
			stmt4.executeUpdate();
		} // THE UPPER BOUND AND INCREMENT ATTRIBUTES REGARDING THE AUTO-BIDDING WILL REMAIN NULL IN THIS PAGE
		
		// INSERT THE NEW BID INFORMATION INTO THE DB
		PreparedStatement stmt2 = con.prepareStatement("INSERT into bids values (?, ?, NOW(), ?)");
		stmt2.setString(1, username);
		stmt2.setInt(2, auctionID);
		stmt2.setBigDecimal(3, actualBid);
		stmt2.executeUpdate();
		
		// UPDATE THE CORRESPONDING TUPLE IN THE AUCTION TABLE TO INCLUDE THE NEW HIGHEST BID AND ASSOCIATED USER
		PreparedStatement stmt1 = con.prepareStatement("UPDATE auction set highest_bid = ?, highest_user = ? where auction_id = " + auctionID + ";");
		stmt1.setBigDecimal(1, actualBid);
		stmt1.setString(2, username);
		stmt1.executeUpdate();
		
		
		// AUTO-BIDDING SECTION (ADDENDUM)
		// ADD NEW BIDS WHEN A BUYER BIDS HIGHER
		Statement stmta1 = con.createStatement();
		ResultSet result1 = stmta1.executeQuery("SELECT max(bid_amount) as amount from bids where auction_id =" + auctionID);
		result1.next();
		float currentHighestBid = result1.getFloat("amount");
		float newHighestBid = 0;
		
		ResultSet result2 = stmta1.executeQuery("SELECT * from auto_bids where auction_id = '" + auctionID +"' and auto_upper_bound <> 'NULL' and auto_increment <> 'NULL';");
		result2.next();
			
		while(result2.next())
		{
			String name = result2.getString("username");
			float upperBound = result2.getFloat("auto_upper_bound");
			float increment = result2.getFloat("auto_increment");
					
			if(currentHighestBid + increment < upperBound){
				newHighestBid = currentHighestBid + increment;
				String newBid = "INSERT INTO bids(username, auction_id, date_time, bid_amount)" + "VALUES(?,?,NOW(),?)";
				PreparedStatement ps3 = con.prepareStatement(newBid);
				ps3.setString(1, name);
				ps3.setInt(2, auctionID);
				ps3.setFloat(3, newHighestBid);
				ps3.executeUpdate();	
					
				PreparedStatement update = con.prepareStatement("UPDATE auto_bids set new_high = true where auction_id = ? and username = ?");
				update.setInt(1, auctionID);
				update.setString(2, name);
				update.executeUpdate();
					
				// UPDATE AUCTION WITH NEW HIGHEST USER
				PreparedStatement ps2 = con.prepareStatement("UPDATE auction set highest_bid = ?, highest_user = ? where auction_id = " + auctionID + ";");
				ps2.setFloat(1, newHighestBid);
				ps2.setString(2, name);
				ps2.executeUpdate();
			}
		}
		
		Statement lastcheck = con.createStatement();
		ResultSet highestBidder = lastcheck.executeQuery("SELECT highest_user FROM auction WHERE auction_id = " + auctionID + ";");
		highestBidder.next();
		String highestUser = highestBidder.getString("highest_user");
		
		// SET ALERT BOOLEAN FOR EVERYONE WHO HAS BID ON THIS AUCTION (TELL THEM THAT THERE'S BEEN A HIGHER BID)
		PreparedStatement stmtf = con.prepareStatement("UPDATE auto_bids set new_high = true WHERE auction_id = ? and username <> ?");
		stmtf.setInt(1, auctionID);
		stmtf.setString(2, highestUser);
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