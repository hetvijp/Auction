<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Set up Auto Bid</title>
</head>
<body>

	<%
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		String userId = (String) session.getAttribute("user");
		session.setAttribute("user", userId);
		int auctionId = Integer.parseInt(request.getParameter("auctionId"));
		session.setAttribute("auctionId", auctionId);
		ResultSet result = stmt.executeQuery("SELECT username, max(bid_amount) as max FROM bids WHERE auction_id = " + auctionId);
		result.next();
		float max = result.getFloat("max");
		
	%>
	
	<h2>Set up the auto bidding</h2>
	
	<form action="createAutoBid.jsp">
		<div>
			<label for="auto_increment">Increment:</label>
			<input type="text" name="auto_increment" id="auto_increment" required />
		</div>
		<br />
		<div>
			<label for="auto_upper_bound">Highest Limit:</label>
			<input type="text" name="auto_upper_bound" id="auto_upper_bound" required/>
		</div>
		<div class="submit">
			<button value="submit" name="submit">Submit</button>
		</div>
		<br/>
	</form>
</body>
</html>