<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="Customer.css" type="text/css">
	<title>Main Menu</title>
	<style>
		body {
			font-family: sans-serif;
		}
	</style>
</head>
<body>
	
	<h2>Welcome <%= session.getAttribute("name") %>!</h2>
	
	<%
	try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		String userId = (String) session.getAttribute("user");
		
		ResultSet result = stmt.executeQuery("select * from account where username='" + userId + "'");
		
		result.next();
		String name = result.getString(2);
		
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
				<form action="ExistingAuctions/AcceptAuction.jsp" method="POST">
					<input class="descSubmit" type="Submit" value="Confirm Purchase">
					<input type="hidden" name="auctionID" value=<%=auctionID%>>
					<input type="hidden" name="productName" value=<%=productName%>>				
				</form>
				<br>
				<% 
			} while (resultca.next());
					
		}
		
		// THIS PORTION CHECKS IF THERE'S ANY ALERTS THAT THERE HAS BEEN A HIGHER BID ON ANY AUCTION THAT THIS USER IS INVOLVED IN
		Statement stmt_bidcheck = con.createStatement();
		ResultSet resultbc = stmt_bidcheck.executeQuery("SELECT * FROM (auto_bids b join auction a using (auction_id)) join technology t using (product_id) where b.username='" + userId + "';");
		
		if (resultbc.next()) {
			do {
				boolean new_high = resultbc.getBoolean("new_high");
				if (new_high == true) {
					 String product = resultbc.getString("product_name");
					 %> <p>The auction you've made a bid in involving "<% out.print(product); %>" has a new highest bid. Please check active auctions to see if you still have a chance to bid!</p> <%
					 int auction_id = resultbc.getInt("auction_id");
					 PreparedStatement stmtl = con.prepareStatement("UPDATE auto_bids SET new_high = false WHERE auction_id = ? and username = ?");
					 stmtl.setInt(1, auction_id);
					 stmtl.setString(2, userId);
					stmtl.executeUpdate();
				}
			} while (resultbc.next());
			
		}
	
		// THE FOLLOWING IS ESSENTIALLY THE "TABLE OF CONTENTS", EVERYWHERE THE END-USER MAY NEED TO NAVIGATE
	%>

	<h2>Main Menu</h2>

	<h4>View all auctions <a href="ExistingAuctions/AuctionsMain.jsp"><button>here</button></a></h4>
	<h4>Create a new auction <a href="CreatingAuctions/NewAuctionsMain.jsp"><button>here</button></a></h4>
	<h4>Post a new question <a href="postQuestions.jsp"><button>here</button></a></h4>
	
	<h4>Reset Password <a href="Reset/ResetForm.jsp"><button>here</button></a></h4>
	
	<h4>Do you want to delete your account?</h4>
		<form action="DeleteCustomer.jsp">
			<input class="deleteSubmit" type="Submit" value="Delete">
			<input type="hidden" name="name" value=<%=name%>>
		</form>
	<br>
	<div class="logout">
		<a href="CustomerLogout.jsp"><button>Logout</button></a>
	</div>
<% 
		con.close();
	}
	catch (Exception ex){
		out.print(ex);
	}
	
%>

</body>
</html>