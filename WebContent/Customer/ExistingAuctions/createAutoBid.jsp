<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<%
		try{
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			
			String userId = (String) session.getAttribute("user");
			Integer auctionId = (Integer) session.getAttribute("auctionId"); 
			float autoIncrement = Float.parseFloat(request.getParameter("auto_increment"));
			float autoUpperBound = Float.parseFloat(request.getParameter("auto_upper_bound"));
			
			String username = ""; int id = 0;
			float currentHighestBid = 0; String highestUser = "";
			float newHighestBid = 0;
			
			ResultSet currentPrice = stmt.executeQuery("SELECT init_price from auction where auction_id = " + auctionId);
			currentPrice.next();
			float price = currentPrice.getFloat("init_price");
		
				
			// INSERT INTO AUTO_BIDS TABLE WITH NEW DATA
			String insert = "INSERT into auto_bids(username, auction_id, auto_increment, auto_upper_bound, new_high)" + "VALUES(?,?,?,?,?)";
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1, userId);
			ps.setInt(2, auctionId);
			ps.setFloat(3, autoIncrement);			
			ps.setFloat(4, autoUpperBound);
			ps.setInt(5, 0);	
			ps.executeUpdate();
			
			ResultSet count = stmt.executeQuery("SELECT count(auction_id) as count from bids where auction_id = " + auctionId);
			count.next();
			int countnum = count.getInt("count");
			
			float total = autoIncrement + price;
			
			if(countnum == 0)
			{
				PreparedStatement ps2 = con.prepareStatement("UPDATE auction set highest_bid = ?, highest_user = ? where auction_id = " + auctionId + ";");
				ps2.setFloat(1, total);
				ps2.setString(2, userId);
				ps2.executeUpdate();
				
				PreparedStatement insertIntoBids = con.prepareStatement("INSERT into bids(username,auction_id,date_time,bid_amount)" + "VALUES(?,?,NOW(),?)");
				insertIntoBids.setString(1, userId);
				insertIntoBids.setInt(2, auctionId);
				insertIntoBids.setFloat(3, total);
				insertIntoBids.executeUpdate();
			}
			else
			{
				ResultSet totalBid = stmt.executeQuery("SELECT max(bid_amount) as max1 from bids where auction_id = " + auctionId);
				totalBid.next();
				float totalB = totalBid.getFloat("max1");
				
				float totalBidAmount = totalB + autoIncrement;
				
				PreparedStatement updateAuction = con.prepareStatement("UPDATE auction set highest_bid = ?, highest_user = ? where auction_id = " + auctionId + ";");
				updateAuction.setFloat(1, totalBidAmount);
				updateAuction.setString(2, userId);
				updateAuction.executeUpdate();
				
				PreparedStatement insertIntoBids = con.prepareStatement("INSERT into bids(username,auction_id,date_time,bid_amount)" + "VALUES(?,?,NOW(),?)");
				insertIntoBids.setString(1, userId);
				insertIntoBids.setInt(2, auctionId);
				insertIntoBids.setFloat(3, totalBidAmount);
				insertIntoBids.executeUpdate();
			}
			
			// ADD NEW BIDS WHEN A BUYER BIDS HIGHER
			ResultSet result1 = stmt.executeQuery("SELECT max(bid_amount) as amount from bids where auction_id =" + auctionId);
			result1.next();
			currentHighestBid = result1.getFloat("amount");
			
			ResultSet result2 = stmt.executeQuery("SELECT * from auto_bids where auction_id = '" + auctionId +"' and auto_upper_bound <> 'NULL' and auto_increment <> 'NULL' and username <> '" + userId + "'");
			
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
					ps3.setInt(2, auctionId);
					ps3.setFloat(3, newHighestBid);
					ps3.executeUpdate();	
						
					PreparedStatement update = con.prepareStatement("UPDATE auto_bids set new_high = true where auction_id = ? and username = ?");
					update.setInt(1, auctionId);
					update.setString(2, name);
					update.executeUpdate();
					
					// UPDATE AUCTION WITH NEW HIGHEST USER
					PreparedStatement ps4 = con.prepareStatement("UPDATE auction set highest_bid = ?, highest_user = ? where auction_id = " + auctionId + ";");
					ps4.setFloat(1, newHighestBid);
					ps4.setString(2, name);
					ps4.executeUpdate();
				}
				else if(currentHighestBid > upperBound){ %>
					<p>Someone else bid higher than you</p>
				<%
				}
			}
			
			// SET ALERT BOOLEAN FOR EVERYONE WHO HAS BID ON THIS AUCTION (TELL THEM THAT THERE'S BEEN A HIGHER BID)
			PreparedStatement stmtf = con.prepareStatement("UPDATE auto_bids set new_high = true WHERE auction_id = ? and username <> ?");
			stmtf.setInt(1, auctionId);
			stmtf.setString(2, username);
			stmtf.executeUpdate();
			
			response.sendRedirect("AuctionsMain.jsp");
			con.close();
		}
		catch (Exception ex){
			out.print(ex);
		}
	
	%>

</body>
</html>