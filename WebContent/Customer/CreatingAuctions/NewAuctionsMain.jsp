<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="Customer.css" type="text/css">
	<title>Create a New Auction</title>
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
	
	<a href="../CustomerPage.jsp"><button>Back to Main Menu</button></a>
	
	<%
	try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		String userId = (String) session.getAttribute("user");
		
		// THIS SECTION GIVES US THE CONFIRMATION STEP FOR BUYERS THAT WON AUCTIONS
		Statement stmt_closeAuc = con.createStatement();
		ResultSet resultca = stmt_closeAuc.executeQuery("SELECT * FROM auction a join technology t using (product_id) WHERE a.sold = 0 and a.end_date_time < NOW() and a.highest_bid >= a.min_price and a.highest_user='" + userId + "';");
		
		if (resultca.next()) {
			%> <h4>There are some auctions that you have won, and you need to confirm purchase to complete.</h4> <%
			do {
				String productName = resultca.getString("product_name");
				int auctionID = resultca.getInt("auction_id");
				%> 
				<p>The auction involving "<% out.print(productName); %>" is over and you were the highest bidder! Congratulations! Complete the purchase.</p>
				<form action="../ExistingAuctions/AcceptAuction.jsp" method="POST">
					<input class="descSubmit" type="Submit" value="Confirm Purchase">
					<input type="hidden" name="auctionID" value=<%=auctionID%>>
					<input type="hidden" name="productName" value=<%=productName%>>				
				</form>
				<br>
				<% 
			} while (resultca.next());
			
		}
		
		// HERE, WE CHECK FOR ANY ALERTS OF HIGHER BIDS IN AUCTIONS THAT THIS USER IS INVOLVED IN
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
		<h3>Creating a New Auction</h3>
		<p><%= session.getAttribute("name") %>, do you see the item you would like to sell here?</p> 
		<%
		// THIS WILL SHOW THE USER ALL THE ITEMS THAT ARE CURRENTLY STORED IN OUR DATABASE
		// IF THEY SEE THE ONE THEY WANT TO SELL, THEY SIMPLY CHOOSE THAT ITEM AND SET ALL OTHER INFORMATION ACCORDINGLY
		ResultSet result = stmt.executeQuery("select * from technology;");
		
		if (!result.next()) { // JUST IN CASE SOMEONE WOULD'VE WIPED ALL OF THE PRODUCTS FROM OUR DATABASE
			%> <p>There are no products in our system as of yet. Please enter your item below.</p> <%
		} else { // DISPLAY ALL ITEMS
		%> 
		<br>
		<br>
		<table>
			<tr>
				<td>Product Name</td>
				<td>Brand</td>
				<td>Data Storage</td>
				<td>Link to Create Auction</td>
			</tr>
		
		<%
			do {
				int productID = result.getInt("product_id");
		%>
			<tr>
				<td>
					<% out.print(result.getString("product_name")); %>
				</td>
				<td>
					<% out.print(result.getString("brand"));%>
				</td>
				<td>
					<% out.print(result.getString("storage")); %>
				</td>
				<td>
					<form action="SellingItem.jsp">
						<input class="WantToSell" type="Submit" value="Here's my item!">
						<input type="hidden" name="productID" value=<%=productID%>>
					</form>
				</td>
			</tr>
	<%
			} while (result.next());
		}
		
		// IF THE USER DOESN'T SEE THE ITEM THEY WISH TO SELL IN OUR DATABASE, THEY WILL ENTER ALL THE OTHER SPECS AND INFO ON ANOTHER PAGE (USING FORM BELOW)
	%>
		</table>
		<br>
		<br>
		<p>If you don't see your item in the above list (please check all of the details by clicking "Here's My Item"), please help us by providing some information regarding your product.</p>
		<form method="post" action="UnknownProduct.jsp">
			<input type="radio" name="Item Type" value="Phone"/> My item is a phone.
		  	<br>
		  	<input type="radio" name="Item Type" value="Smartwatch"/> My item is a smartwatch.
		 	<br>
		 	<input type="radio" name="Item Type" value="Laptop"/> My item is a laptop.
		 	<br>
		 	<br>
		  	<input type="submit" value="submit" />
		</form>
<%
		con.close();
	}
	catch (Exception ex){
		out.print(ex);
	}
%>

</body>
</html>