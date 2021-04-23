<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="Customer.css" type="text/css">
	<title>Tech for Sale</title>
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
	
	<a href="../CustomerPage.jsp"><button>Main Menu</button></a>
	
	<%
	try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		String userId = (String) session.getAttribute("user");
		
		// THIS SECTION GIVES US THE CONFIRMATION STEP FOR BUYERS ON AUCTIONS
		Statement stmt_closeAuc = con.createStatement();
		ResultSet resultca = stmt_closeAuc.executeQuery("SELECT * FROM auction a join technology t using (product_id) WHERE a.sold = 0 and a.end_date_time < NOW() and a.highest_bid >= a.min_price and a.highest_user='" + userId + "';");
				
		if (resultca.next()) {
			%> <h4>There are some auctions that you have won, and you need to confirm purchase to complete.</h4> <%
			do {
				String productName = resultca.getString("product_name");
				int auctionID = resultca.getInt("auction_id");
				%> 
				<p>The auction involving "<% out.print(productName); %>" is over and you were the highest bidder! Congratulations! Complete the purchase.</p>
				<form action="AcceptAuction.jsp" method="POST">
					<input class="descSubmit" type="Submit" value="Confirm Purchase">
					<input type="hidden" name="auctionID" value=<%=auctionID%>>
					<input type="hidden" name="productName" value=<%=productName%>>			
				</form>
				<br>
				<% 
			} while (resultca.next());
					
		}
		
		// FIRST OF ALL, WE CHECK IF THERE HAS BEEN A HIGHER BID ON AN AUCTION INVOLVING THIS USER
		// IN THIS TESTING ENVIRONMENT, THE ALERTS WILL ALL POP ON THE MAIN CUSTOMER PAGE, BUT IF THERE WERE MULTIPLE USERS ACTIVE AT THE SAME TIME
		// 		WE WOULD NEED TO GIVE AN ALERT SYSTEM THAT'S NOT JUST ON THE MAIN MENU PAGE
		Statement stmt_bidcheck = con.createStatement();
		ResultSet resultbc = stmt_bidcheck.executeQuery("SELECT * FROM (auto_bids b join auction a using (auction_id)) join technology t using (product_id) where b.username='" + userId + "';");
		
		if (resultbc.next()) {
			do {
				boolean new_high = resultbc.getBoolean("new_high");
				if (new_high == true) {
					 String product = resultbc.getString("product_name");
					 %> 
					 <p>The auction you've made a bid in involving "<% out.print(product); %>" has a new highest bid. Please check active auctions to see if you still have a chance to bid!</p> <%
					 int auction_id = resultbc.getInt("auction_id");
					 PreparedStatement stmtl = con.prepareStatement("UPDATE auto_bids SET new_high = false WHERE auction_id = ? and username = ?");
					 stmtl.setInt(1, auction_id);
					 stmtl.setString(2, userId);
					stmtl.executeUpdate();
				}
			} while (resultbc.next());
			
		}
	%>
	
	<h3><%= session.getAttribute("name") %>, here are the active auctions today! The closer to the top of the list, the sooner it closes!</h3>
	
	<table>
		<tr>
			<td> Product </td>
			<td> End Date and Time </td>
			<td> Initial Price </td>
			<td> Current Highest Bid </td>
			<td> Link for more information </td>
		</tr>
	
	<%	
		// THE FOLLOWING WILL PRINT OUT THE BASIC INFORMATION FOR ALL ACTIVE AUCTIONS IN A TABLE
		ResultSet result = stmt.executeQuery ("SELECT auction_id, product_name, DATE(end_date_time) as date, TIME(end_date_time) as time, init_price, highest_bid FROM auction JOIN technology USING (product_id) WHERE end_date_time > NOW() ORDER BY end_date_time asc;");
		
		while(result.next()) {
			int auctionID = result.getInt(1);
	%>
			<tr>
				<td> <% out.print(result.getString(2)); %> </td>
				<td> 
				<% out.print(result.getDate(3));
					out.print(" @ ");
					out.print(result.getTime(4));
				%> 
				</td>
				<td> <%out.print(result.getFloat(5));%> </td>
				<td> 
					<% if (result.getFloat(6) >= result.getFloat(5)) {
						out.print(result.getFloat(6));	
					} else {
					%> No Current Bids
					<%} %> 
				</td>
				<td> 
					<form action="AuctionDescription.jsp" method="POST">
						<input class="descSubmit" type="Submit" value="Description">
						<input type="hidden" name="auctionID" value=<%=auctionID%>>
					</form> 
				</td>
			</tr>
		
	<%
			
		}
		
		%></table>
		
		<br>
		
		<h3>Here are the auctions that have closed.</h3>
		
		
		<table>
		<tr>
			<td> Product </td>
			<td> End Date and Time </td>
			<td> Winner </td>
			<td> Link for more information </td>
		</tr>
		
		<%
		
		ResultSet result2 = stmt.executeQuery ("SELECT auction_id, product_name, DATE(end_date_time) as date, TIME(end_date_time) as time, min_price, highest_bid, highest_user FROM auction JOIN technology USING (product_id) WHERE end_date_time <= NOW() ORDER BY end_date_time desc;");
		
		while(result2.next()) {
			int auctionID = result2.getInt(1);
	%>
			<tr>
				<td> <% out.print(result2.getString(2)); %> </td>
				<td> 
				<% out.print(result2.getDate(3));
					out.print(" @ ");
					out.print(result2.getTime(4));
				%> 
				</td>
				<td> 
				<%
				if (result2.getFloat(6) >= result2.getFloat(5) && result2.getFloat(6) > 0) {
					out.print(result2.getString(7));
				} else {
					out.print("No winner");
				}
				%> 
				</td>
				<td> 
					<form action="OldAuctionDescription.jsp" method="POST">
						<input class="descSubmit" type="Submit" value="Description">
						<input type="hidden" name="auctionID" value=<%=auctionID%>>
					</form> 
				</td>
			</tr>
	<%
		}
		
	%> </table>
	<% 
		con.close();
	}
	catch (Exception ex){
		out.print(ex);
	}
		
	%>

</body>
</html>