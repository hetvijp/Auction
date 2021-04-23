<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.math.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="Customer.css" type="text/css">
	<title>Technology Products for Sale</title>
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
	
	<a href="AuctionsMain.jsp"><button>View All Auctions</button></a>
	
	<%
	try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt_check = con.createStatement();
		Statement stmt_info = con.createStatement();
		Statement stmt1 = con.createStatement();
		Statement stmt2 = con.createStatement();
		Statement stmt3 = con.createStatement();
		Statement stmtf = con.createStatement();

		String userID = (String) session.getAttribute("user");
		int auctionID = Integer.parseInt(request.getParameter("auctionID"));
		
		// THIS PORTION IS TO MAKE SURE A USER IS NOT BIDDING ON THEIR OWN AUCTION, AS THAT WOULD NOT MAKE SENSE
		ResultSet resultc = stmt_check.executeQuery("SELECT username FROM auction WHERE auction_id = " + auctionID + ";");
		resultc.next();
		String auctioner = resultc.getString("username");
		
		if (userID.equals(auctioner)) {
			%> <p>You are not able to bid on your own auction. Please go back to the list of auctions and select another.</p> <%
		
		// OTHERWISE, THE USER CAN INPUT THEIR INFORMATION
		} else {
		
			ResultSet resulti = stmt_info.executeQuery("SELECT DATE(end_date_time) as end_date, TIME(end_date_time) as end_time, product_id, min_increment, highest_bid, init_price FROM auction WHERE auction_id = " + auctionID + ";");
			resulti.next();
		
			// NOTE FOR ANYONE WHO'S CURIOUS: WE'RE CHOOSING TO STORE CURRENCY VALUES IN A BIG DECIMAL OBJECT
			// FLOATING POINTS CANNOT ACCURATELY STORE MOST DECIMALS IN BASE-10 ACCURATELY WITHOUT ROUNDING
			// HOPEFULLY THIS FIXES THE ISSUE
			int productID = resulti.getInt("product_id");
			String mi = resulti.getString("min_increment");
			BigDecimal min_increment = new BigDecimal(mi);
			String hb = resulti.getString("highest_bid");
			BigDecimal highest_bid = new BigDecimal(hb);
			String ip = resulti.getString("init_price");
			BigDecimal initial_price = new BigDecimal(ip);
			BigDecimal baseline = initial_price;
		
			if (highest_bid.compareTo(initial_price) > 0) {
				baseline = highest_bid;
			}
	%> 
	
	<h3>If you're interested in bidding on this item, don't hesitate. The clock is ticking!</h3>
	<p>This auction ends at <b><% out.print(resulti.getTime("end_time")); %></b> on <b><% out.print(resulti.getDate("end_date")); %></b></p>
	<br>
	
	<%
			ResultSet result1 = stmt1.executeQuery("select * from phone where product_id = " + productID + ";");
			ResultSet result2 = stmt2.executeQuery("select * from smartwatch where product_id = " + productID + ";");
			ResultSet result3 = stmt3.executeQuery("select * from laptop where product_id = " + productID + ";");
		
			if (result1.next()) {
			// IF WE'RE HERE, THEY'RE AUCTIONING A PHONE
				ResultSet resultf = stmtf.executeQuery("select * from technology join phone using (product_id) where product_id = " + productID + ";");
				resultf.next();
	%> 
			<table>
				<tr>
					<td> Product Name </td>
					<td> Brand </td>
					<td> Data Storage </td>
					<td> Size </td>
					<td> Color </td>
					<td> Carrier </td>
					<td> Cell Service Capability </td>
					<td> Camera Quality </td>
					<td> Battery Life </td>
				</tr>
				<tr>
					<td> <% out.print(resultf.getString(2));%> </td>
					<td> <% out.print(resultf.getString(4)); %> </td>
					<td> <% out.print(resultf.getString(3)); %> </td>
					<td> <% out.print(resultf.getString(5)); %> </td>
					<td> <% out.print(resultf.getString(6)); %> </td>
					<td> <% out.print(resultf.getString(7)); %> </td>
					<td> <% out.print(resultf.getString(8)); %> </td>
					<td> <% out.print(resultf.getString(9)); %> </td>
					<td> <% out.print(resultf.getString(10)); %> </td>
				</tr>
				
			</table>
	<% 
			
			} else if (result2.next()) {
			// IF WE'RE HERE, THEY'RE AUCTIONING A SMARTWATCH
				ResultSet resultf = stmtf.executeQuery("select * from technology join smartwatch using (product_id) where product_id = " + productID + ";");
				resultf.next();
	%> 
			<table>
				<tr>
					<td> Product Name </td>
					<td> Brand </td>
					<td> Data Storage </td>
					<td> Generation </td>
					<td> Battery Life </td>
					<td> EKG-Enabled </td>
					<td> Cell-Enabled </td>
				</tr>
				<tr>
					<td> <% out.print(resultf.getString(2));%> </td>
					<td> <% out.print(resultf.getString(4)); %> </td>
					<td> <% out.print(resultf.getString(3)); %> </td>
					<td> <% out.print(resultf.getString(6)); %> </td>
					<td> <% out.print(resultf.getString(8)); %> </td>
					<td> <% out.print(resultf.getBoolean(5)); %> </td>
					<td> <% out.print(resultf.getBoolean(7)); %> </td>
				</tr>
				
			</table>
	<%
			
			} else if (result3.next()) {
			// IF WE'RE HERE, THEY'RE AUCTIONING A LAPTOP
				ResultSet resultf = stmtf.executeQuery("select * from technology join laptop using (product_id) where product_id = " + productID + ";");
				resultf.next();
	%> 
			<table>
				<tr>
					<td> Product Name </td>
					<td> Brand </td>
					<td> Data Storage </td>
					<td> RAM </td>
					<td> Screen Size </td>
					<td> Screen Resolution </td>
					<td> SSD </td>
					<td> Tablet Convertible </td>
				</tr>
				<tr>
					<td> <% out.print(resultf.getString(2));%> </td>
					<td> <% out.print(resultf.getString(4)); %> </td>
					<td> <% out.print(resultf.getString(3)); %> </td>
					<td> <% out.print(resultf.getString(6)); %> </td>
					<td> <% out.print(resultf.getString(7)); %> </td>
					<td> <% out.print(resultf.getString(9)); %> </td>
					<td> <% out.print(resultf.getBoolean(5)); %> </td>
					<td> <% out.print(resultf.getBoolean(8)); %> </td>
				</tr>
				
			</table>
	<%
			
			} else {
			// IF WE'RE HERE, SOMETHING HAS GONE WRONG WITH THE JOIN
			%> <p>An error has occurred. Please contact the administrator of the website to get the issue resolved.</p> <%
			}
		
		// WE THEN HAVE A FORM FOR SUBMITTING A NEW BID (MANUALLY)
		
		BigDecimal min = baseline.add(min_increment);
		float legitMin = min.floatValue();
	%> 
	
	<br>
	
	<div>
	If you would like to bid, select the total amount: 
		<form action="ProcessingBid.jsp" Method="POST">
			<input type="number" name="Bid Amount" placeholder=<%=legitMin%> min=<%=legitMin%> step="0.01" id="bid_amount" required>
			<br>
			<input type="submit" value="Submit!">
			<input type="hidden" name="Username" value=<%=userID%>>
			<input type="hidden" name="Auction ID" value=<%=auctionID%>>
		</form>
	</div>
	<%
	
		// THE FOLLOWING SHOWS THE HISTORY OF BIDS ON THIS AUCTION
			Statement stmt_bid = con.createStatement();
			ResultSet result_bid = stmt_bid.executeQuery("SELECT username, bid_amount FROM bids WHERE auction_id = " + auctionID + " ORDER BY bid_amount desc;");
		
			if (!result_bid.next()) {
			// IF WE'RE HERE, THERE'S BEEN NOTHING BID YET
	%> 
			<p>Be the <b>first</b>! There are no other bids at this time.</p> 
			
	<% 		} else { %> 
			
			<p>Here's a history of the bids already placed in this auction!</p>
			<br>
			
			<table> 
				<tr>
					<td> User </td>
					<td> Their Bid </td>
				</tr>
				
		<%		do { %> 
				<tr>
					<td> <% out.print(result_bid.getString("username")); %> </td>
					<td> $<% out.print(result_bid.getFloat("bid_amount")); %> </td>
				</tr>
		<% 		} while (result_bid.next()); %> 
		
			</table>
		<%}
	
			}
		con.close();
	}
	
	catch (Exception ex){
		out.print(ex);
	}
		
	%>

</body>
</html>