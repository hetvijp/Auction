<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" href="Customer.css" type="text/css">
	<title>Input New Product</title>
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
	
	<a href="NewAuctionsMain.jsp"><button>Back to List of Items</button></a>
	
	<%
	try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		String userID = (String) session.getAttribute("user");
		String itemType = request.getParameter("Item Type");
		
		if (itemType.equals("Phone")) {
			// IF WE'RE HERE, THEY'RE AUCTIONING A PHONE
	%> 
			<p>Please input your phone's information below.</p>
			<br>
			<form action="ProcessNewItem.jsp" method="POST">
				<div>
					<label for="product_name">Name of your product: </label>
					<input type="text" name="Product Name" id="product_name" required />
				</div>
				<div>
					<label for="brand">Brand Name: </label>
					<input type="text" name="Brand" id="brand" required />
				</div>
				<div>
					<label for="storage">Storage Size: </label>
					<input type="text" name="Storage" placeholder="64GB" id="storage" required />
				</div>
				<div>
					<label for="size">Approximate Size (Dimensions): </label>
					<input type="text" name="Size" placeholder="5.75 in. x 3 in." id="size" />
				</div>
				<div>
					<label for="color">Color: </label>
					<input type="text" name="Color" placeholder="Black" id="color" />
				</div>
				<div>
					<label for="carrier">Cell Carrier: </label>
					<input type="text" name="Carrier" placeholder="T-Mobile, AT&T, Verizon, etc." id="carrier" />
				</div>
				<div>
					<label for="cell_service">Highest cell service capability: </label>
					<input type="text" name="Cell Service" placeholder="5G" id="cell_service" />
				</div>
				<div>
					<label for="camera_quality">Camera Quality: </label>
					<input type="text" name="Camera Quality" placeholder="4K or 1080p" id="camera_quality" />
				</div>
				<div>
					<label for="battery">Battery Life: </label>
					<input type="text" name="Battery" placeholder="12 hours" id="battery" />
				</div>
				<div>
					<input type="submit" value="Submit"/>
					<input type="hidden" name="Item Type" value=<%=itemType%>>
				</div>				
			</form>
	<% 
			
		} else if (itemType.equals("Smartwatch")) {
			// IF WE'RE HERE, THEY'RE AUCTIONING A SMARTWATCH
	%> 
			<p>Please input your smartwatch's information below.</p>
			<br>
			<form action="ProcessNewItem.jsp" method="POST">
				<div>
					<label for="product_name">Name of your product: </label>
					<input type="text" name="Product Name" id="product_name" required />
				</div>
				<div>
					<label for="brand">Brand Name: </label>
					<input type="text" name="Brand" id="brand" required />
				</div>
				<div>
					<label for="storage">Storage Size: </label>
					<input type="text" name="Storage" placeholder="16GB" id="storage" required />
				</div>
				<div>
					<label for="gen">Generation: </label>
					<input type="text" name="Generation" placeholder="Series 3" id="gen" />
				</div>
				<div>
					<label for="battery">Battery Life: </label>
					<input type="text" name="Battery" placeholder="12 hours" id="battery" />
				</div>
				<div>
					<label for="ekg">EKG-Enabled: </label>
					<input type="radio" name="EKG" value="1" /> Yes
					<input type="radio" name="EKG" value="0" /> No
 				</div>
				<div>
					<label for="cell">Cell-Enabled: </label>
					<input type="radio" name="Cell" value="1" /> Yes
					<input type="radio" name="Cell" value="0" /> No
				</div>
				<div>
					<input type="submit" value="Submit"/>
					<input type="hidden" name="Item Type" value=<%=itemType%>>
				</div>
			</form>
	<%
			
		} else if (itemType.equals("Laptop")) {
			// IF WE'RE HERE, THEY'RE AUCTIONING A LAPTOP
	%> 
			
			<p>Please input your laptop's information below.</p>
			<br>
			<form action="ProcessNewItem.jsp" method="POST">
				<div>
					<label for="product_name">Name of your product: </label>
					<input type="text" name="Product Name" id="product_name" required />
				</div>
				<div>
					<label for="brand">Brand Name: </label>
					<input type="text" name="Brand" id="brand" required />
				</div>
				<div>
					<label for="storage">Storage Size: </label>
					<input type="text" name="Storage" placeholder="100GB" id="storage" required />
				</div>
				<div>
					<label for="ram">RAM: </label>
					<input type="text" name="RAM" placeholder="16GB" id="ram" />
				</div>
				<div>
					<label for="size">Screen Size: </label>
					<input type="text" name="Size" placeholder="15.6 in" id="size" />
				</div>
				<div>
					<label for="resolution">Screen Resolution: </label>
					<input type="text" name="Resolution" placeholder="4K" id="resolution" />
				</div>
				<div>
					<label for="ssd">Solid-State Drive: </label>
					<input type="radio" name="SSD" value="1" /> Yes
					<input type="radio" name="SSD" value="0" /> No
 				</div>
				<div>
					<label for="tablet">Tablet Convertible: </label>
					<input type="radio" name="Tablet" value="1" /> Yes
					<input type="radio" name="Tablet" value="0" /> No
				</div>
				<div>
					<input type="submit" value="Submit"/>
					<input type="hidden" name="Item Type" value=<%=itemType%>>
				</div>
			</form>
	<%
			
		} else {
			// IF WE'RE HERE, SOMETHING HAS GONE WRONG WITH THE FORM ON THE LAST PAGE
			%> <p>An error has occurred. Please contact the administrator of the website to get the issue resolved.</p> <%
		}
		
		con.close();
	}
	catch (Exception ex){
		out.print(ex);
	}
		
	%>

</body>
</html>