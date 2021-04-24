<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Auction Confirm</title>
</head>
<body>
<% 
	try{
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		int auctionId = Integer.parseInt(request.getParameter("auctionId"));
		
		stmt.executeUpdate("delete from auction where auction_id=" + auctionId);
		
		ResultSet result = stmt.executeQuery("select auction_id from auction where auction_id=" + auctionId);
		
		if(result.next()){
			%>
					<p>Auction is not deleted yet. Try again!</p>
					<div class="back">
							<a href="CustomerRepPage.jsp"><button>Back</button></a>
					</div>
			<%
					}
					else{
			%>
						<h4>Auction deleted</h4>
						<div class="back">
							<a href="CustomerRepPage.jsp"><button>Back</button></a>
						</div>
			<%	
					}			
	}
	catch(Exception ex){
		out.print(ex);
	}
%>
</body>
</html>