<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
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
		Statement stmt_info = con.createStatement();
		Statement stmt1 = con.createStatement();
		Statement stmt2 = con.createStatement();
		Statement stmt3 = con.createStatement();
		Statement stmtf = con.createStatement();

		String userID = (String) session.getAttribute("user");
		int auctionID = Integer.parseInt(request.getParameter("auctionID"));
		
		
		ResultSet resulti = stmt_info.executeQuery("SELECT DATE(end_date_time) as end_date, TIME(end_date_time) as end_time, product_id, min_price, highest_bid, highest_user, sold FROM auction WHERE auction_id = " + auctionID + ";");
		resulti.next();
		
		int productID = resulti.getInt("product_id");
		int sold = resulti.getInt("sold");
		float min_price = resulti.getFloat("min_price");
		float highest_bid = resulti.getFloat("highest_bid");
		
		if (sold == 1) {
			%> <h4>The winner of this auction is: <b><% out.print(resulti.getString("highest_user")); %></b>. Congratulations to them!</h4> <% 
		} else if (highest_bid >= min_price && highest_bid > 0) {
			%> <h4>There was a user that had the highest bid upon the end of the auction, but they have yet to <em>officially</em> purchase the item.</h4> <% 
		} else {
			%> <h5>No one bid higher than the reserve price set by the auctioner, so there was <b>no winner</b> for this auction.</h5> <% 
		}
	%> 
	
	<%
			ResultSet result1 = stmt1.executeQuery("select * from phone where product_id = " + productID + ";");
			ResultSet result2 = stmt2.executeQuery("select * from smartwatch where product_id = " + productID + ";");
			ResultSet result3 = stmt3.executeQuery("select * from laptop where product_id = " + productID + ";");
		
			if (result1.next()) {
			// IF WE'RE HERE, THE AUCTION WAS FOR A PHONE
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
			// IF WE'RE HERE, THE AUCTION WAS FOR A SMARTWATCH
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
			// IF WE'RE HERE, THE AUCTION WAS FOR A LAPTOP
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
	%> 
	
	<%
	
		// THE FOLLOWING SHOWS THE HISTORY OF BIDS ON THIS AUCTION
			Statement stmt_bid = con.createStatement();
			ResultSet result_bid = stmt_bid.executeQuery("SELECT username, bid_amount FROM bids WHERE auction_id = " + auctionID + " ORDER BY bid_amount desc;");
			
			if (!result_bid.next()) {
			// IF WE'RE HERE, THERE'S BEEN NOTHING BID YET
	%> 
			<p>There were no bids on this auction, unfortunately.</p> 
			
	<% 		} else { %> 
			
			<p>Here's a history of the bids that were placed in this auction.</p>
			<br>
			
			<table> 
				<tr>
					<td> User </td>
					<td> Current Highest Bid </td>
				</tr>
				
		<%		do { %> 
				<tr>
					<td> <% out.print(result_bid.getString("username")); %> </td>
					<td> <% out.print(result_bid.getFloat("bid_amount")); %> </td>
				</tr>
		<% 		} while (result_bid.next()); 
		%> 
			</table>
		<%}
	
			
		con.close();
	}
	
	catch (Exception ex){
		out.print(ex);
	}
		
	%>

</body>
</html>