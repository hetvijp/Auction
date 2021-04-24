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
	
	<a href="NewAuctionsMain.jsp"><button>Back To List of Items</button></a>
	
	<h3>Creating a New Auction</h3>
	
	<p>Please verify this is the item you wish to sell before continuing. If not, return to the previous page.</p>
	<br>
	
	<%
	try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt1 = con.createStatement();
		Statement stmt2 = con.createStatement();
		Statement stmt3 = con.createStatement();
		Statement stmtf = con.createStatement();
		
		int productID = Integer.parseInt(request.getParameter("productID"));
		
		// THE FOLLOWING IS TRICKY TO IMPLEMENT, BUT IT PRINTS A TABLE OF ALL SPECS ACCORDING TO WHAT TYPE OF ITEM IT IS
		ResultSet result1 = stmt1.executeQuery("select * from phone where product_id = " + productID + ";");
		ResultSet result2 = stmt2.executeQuery("select * from smartwatch where product_id = " + productID + ";");
		ResultSet result3 = stmt3.executeQuery("select * from laptop where product_id = " + productID + ";");
		
		if (result1.next()) {
			// IF WE'RE HERE, THEN THE ITEM IS A PHONE
			ResultSet resultf = stmtf.executeQuery("select * from technology join phone using (product_id) where product_id = " + productID + ";");
			resultf.next();
	%> 
			<table>
				<tr>
					<td>Product Name</td>
					<td>Brand</td>
					<td>Data Storage</td>
					<td>Size</td>
					<td>Color</td>
					<td>Carrier</td>
					<td>Cell Service Capability</td>
					<td>Camera Quality</td>
					<td>Battery Life</td>
				</tr>
				<tr>
					<td><% out.print(resultf.getString(2));%></td>
					<td><% out.print(resultf.getString(4)); %></td>
					<td><% out.print(resultf.getString(3)); %></td>
					<td><% out.print(resultf.getString(5)); %></td>
					<td><% out.print(resultf.getString(6)); %></td>
					<td><% out.print(resultf.getString(7)); %></td>
					<td><% out.print(resultf.getString(8)); %></td>
					<td><% out.print(resultf.getString(9)); %></td>
					<td><% out.print(resultf.getString(10)); %></td>
				</tr>
				
			</table>
	<% 
			
			
		} else if (result2.next()) {
			// IF WE'RE HERE, THEN THE ITEM IS A SMARTWATCH
			ResultSet resultf = stmtf.executeQuery("select * from technology join smartwatch using (product_id) where product_id = " + productID + ";");
			resultf.next();
			boolean ekg = resultf.getBoolean(5);
			boolean cell = resultf.getBoolean(7);
			
	%> 
			<table>
				<tr>
					<td>Product Name</td>
					<td>Brand</td>
					<td>Data Storage</td>
					<td>Generation</td>
					<td>Battery Life</td>
					<td>EKG-Enabled</td>
					<td>Cell-Enabled</td>
				</tr>
				<tr>
					<td><% out.print(resultf.getString(2));%></td>
					<td><% out.print(resultf.getString(4)); %></td>
					<td><% out.print(resultf.getString(3)); %></td>
					<td><% out.print(resultf.getString(6)); %></td>
					<td><% out.print(resultf.getString(8)); %></td>
					<td><%  
					if (ekg) { out.print("Y"); }
					else { out.print("N"); }
					%></td>
					<td><% 
					if (cell) { out.print("Y"); }
					else { out.print("N"); }
					%></td>
				</tr>
				
			</table>
	<%
			
		} else if (result3.next()) {
			// IF WE'RE HERE, THEN THE ITEM IS A LAPTOP
			ResultSet resultf = stmtf.executeQuery("select * from technology join laptop using (product_id) where product_id = " + productID + ";");
			resultf.next();
			boolean ssd = resultf.getBoolean(5);
			boolean tablet = resultf.getBoolean(8);
	%> 
			<table>
				<tr>
					<td>Product Name</td>
					<td>Brand</td>
					<td>Data Storage</td>
					<td>RAM</td>
					<td>Screen Size</td>
					<td>Screen Resolution</td>
					<td>SSD</td>
					<td>Tablet Convertible</td>
				</tr>
				<tr>
					<td><% out.print(resultf.getString(2));%></td>
					<td><% out.print(resultf.getString(4)); %></td>
					<td><% out.print(resultf.getString(3)); %></td>
					<td><% out.print(resultf.getString(6)); %></td>
					<td><% out.print(resultf.getString(7)); %></td>
					<td><% out.print(resultf.getString(9)); %></td>
					<td><% 
					if (ssd) { out.print("Y"); }
					else { out.print("N"); }
					%></td>
					<td><% 
					if (tablet) { out.print("Y"); }
					else { out.print("N"); }
					%></td>
				</tr>
			</table>
	<%
			
		} else {
			// SOMETHING WRONG HAS HAPPENED IF WE DIDN'T GET ANY HITS ON THE JOIN
			%> <p>An error has occurred. Please contact the administrator of the website to get the issue resolved.</p> <%
		}
		
		String userID = (String) session.getAttribute("user");
		// THE FOLLOWING IS A FORM FOR ALL THE AUCTION INFO
		%>
		<br>
		<form action="CreatingAuction.jsp" method="POST">
		<div>
			<label for="initPrice">Initial Price For Your Item: $</label>
			<input type="number" name="Initial Price" step="0.01" placeholder="0.00" min="0.00" id="init_price" required />
		</div>
		<br/>
		<div>
			<label for="minPrice">Minimum Price You Would Sell For: $</label>
			<input type="number" name="Minimum Price" step="0.01" placeholder="5.00" min="0.01" id="min_price" required />
		</div>
		<br/>
		<div>
			<label for="minIncrement">Minimum Increment In Between Bids: $</label>
			<input type="number" name="Minimum Increment" step="0.01" placeholder="0.05" min="0.01" id="min_increment" required />
		</div>
		<br/>
		<div>
			<label for="endDate">End Date of Auction: </label>
			<input type="date" name="End Date" placeholder="2021-05-01" id="end_date" required />
		</div>
		<br/>
		<div>
			<label for="endTime">End Time of Auction (in military time): </label>
			<input type="time" name="End Time" placeholder="18:00" id="end_time" required />
		</div>
		<br/>
		<div class="submit">
			<input type="submit" value="Submit"/>
			<input type="hidden" name="Product ID" value=<%=productID%>>
			<input type="hidden" name="Username" value=<%=userID%>>
		</div>
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