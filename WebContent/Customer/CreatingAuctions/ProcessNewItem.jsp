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
		
	<%
	try {
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		String userID = (String) session.getAttribute("user");
		String itemType = request.getParameter("Item Type");
		
		if (itemType.equals("Phone")) {
			// IF WE'RE HERE, THEY'RE ENTERING A PHONE ITEM
			
			// INSERT INTO TECHNOLOGY TABLE
			PreparedStatement stmt1 = con.prepareStatement("INSERT INTO technology (product_name, brand, storage) VALUES (?, ?, ?);");
			stmt1.setString(1, request.getParameter("Product Name"));
			stmt1.setString(2, request.getParameter("Brand"));
			stmt1.setString(3, request.getParameter("Storage"));
			stmt1.executeUpdate();
			Statement stmt_identifier = con.createStatement();
			
			// THIS DOESN'T ACCOUNT FOR THE VERY RARE CASE THAT SOMEONE WOULD BE INPUTTING THE SAME EXACT INFORMATION AT EXACTLY THE SAME TIME
			// IF THERE WOULD BE AN INTERLEAVING OCCURRENCE DURING THIS, THERE'S A POSSIBILITY THAT WE GET THE WRONG ID, BUT THIS WOULD BE NEAR IMPOSSIBLE IN OUR TESTING ENVIRONMENT
			ResultSet resulti = stmt_identifier.executeQuery("SELECT max(product_id) as id FROM technology WHERE product_name='" + request.getParameter("Product Name") + "' and storage='" + request.getParameter("Storage") + "';");
			resulti.next();
			int productID = resulti.getInt("id");
			
			// INSERT INTO PHONE TABLE
			PreparedStatement stmt2 = con.prepareStatement("INSERT INTO phone VALUES (?, ?, ?, ?, ?, ?, ?);");
			stmt2.setInt(1, productID);
			stmt2.setString(2, request.getParameter("Size"));
			stmt2.setString(3, request.getParameter("Color").toLowerCase());
			stmt2.setString(4, request.getParameter("Carrier").toLowerCase());
			stmt2.setString(5, request.getParameter("Cell Service"));
			stmt2.setString(6, request.getParameter("Camera Quality"));
			stmt2.setString(7, request.getParameter("Battery").toLowerCase());
			stmt2.executeUpdate();
			
		} else if (itemType.equals("Smartwatch")) {
			// IF WE'RE HERE, THEY'RE AUCTIONING A SMARTWATCH
			
			// INSERT INTO TECHNOLOGY TABLE
			PreparedStatement stmt1 = con.prepareStatement("INSERT INTO technology (product_name, brand, storage) VALUES (?, ?, ?);");
			stmt1.setString(1, request.getParameter("Product Name"));
			stmt1.setString(2, request.getParameter("Brand"));
			stmt1.setString(3, request.getParameter("Storage"));
			stmt1.executeUpdate();
			Statement stmt_identifier = con.createStatement();
			
			// THIS DOESN'T ACCOUNT FOR THE VERY RARE CASE THAT SOMEONE WOULD BE INPUTTING THE SAME EXACT INFORMATION AT EXACTLY THE SAME TIME
			// IF THERE WOULD BE AN INTERLEAVING OCCURRENCE DURING THIS, THERE'S A POSSIBILITY THAT WE GET THE WRONG ID, BUT THIS WOULD BE NEAR IMPOSSIBLE IN OUR TESTING ENVIRONMENT
			ResultSet resulti = stmt_identifier.executeQuery("SELECT max(product_id) as id FROM technology WHERE product_name='" + request.getParameter("Product Name") + "' and storage='" + request.getParameter("Storage") + "';");
			resulti.next();
			int productID = resulti.getInt("id");
			
			// INSERT INTO SMARTWATCH TABLE
			PreparedStatement stmt2 = con.prepareStatement("INSERT INTO smartwatch VALUES (?, ?, ?, ?, ?);");
			stmt2.setInt(1, productID);
			stmt2.setInt(2, Integer.parseInt(request.getParameter("EKG")));
			stmt2.setString(3, request.getParameter("Generation").toLowerCase());
			stmt2.setInt(4, Integer.parseInt(request.getParameter("Cell")));
			stmt2.setString(5, request.getParameter("Battery").toLowerCase());
			stmt2.executeUpdate();
			
		} else if (itemType.equals("Laptop")) {
			// IF WE'RE HERE, THEY'RE AUCTIONING A LAPTOP
			
			// INSERT INTO TECHNOLOGY TABLE
			PreparedStatement stmt1 = con.prepareStatement("INSERT INTO technology (product_name, brand, storage) VALUES (?, ?, ?);");
			stmt1.setString(1, request.getParameter("Product Name"));
			stmt1.setString(2, request.getParameter("Brand"));
			stmt1.setString(3, request.getParameter("Storage"));
			stmt1.executeUpdate();
			Statement stmt_identifier = con.createStatement();
			
			// THIS DOESN'T ACCOUNT FOR THE VERY RARE CASE THAT SOMEONE WOULD BE INPUTTING THE SAME EXACT INFORMATION AT EXACTLY THE SAME TIME
			// IF THERE WOULD BE AN INTERLEAVING OCCURRENCE DURING THIS, THERE'S A POSSIBILITY THAT WE GET THE WRONG ID, BUT THIS WOULD BE NEAR IMPOSSIBLE IN OUR TESTING ENVIRONMENT
			ResultSet resulti = stmt_identifier.executeQuery("SELECT max(product_id) as id FROM technology WHERE product_name='" + request.getParameter("Product Name") + "' and storage='" + request.getParameter("Storage") + "';");
			resulti.next();
			int productID = resulti.getInt("id");
			
			// INSERT INTO LAPTOP TABLE
			PreparedStatement stmt2 = con.prepareStatement("INSERT INTO laptop VALUES (?, ?, ?, ?, ?, ?);");
			stmt2.setInt(1, productID);
			stmt2.setInt(2, Integer.parseInt(request.getParameter("SSD")));
			stmt2.setString(3, request.getParameter("RAM").toUpperCase());
			stmt2.setString(4, request.getParameter("Size").toLowerCase());
			stmt2.setInt(5, Integer.parseInt(request.getParameter("Tablet")));
			stmt2.setString(6, request.getParameter("Resolution"));
			stmt2.executeUpdate();
			
		} else {
			// IF WE'RE HERE, SOMETHING HAS GONE WRONG WITH THE FORM ON THE LAST PAGE
			%> <p>An error has occurred. Please contact the administrator of the website to get the issue resolved.</p> <%
		}
		
		
	%> 
	<p>Thank you for submitting your information. You should be able to find this item in our listings for all future auctions.</p> 
	<p>Please return to the list of items to sell and select your <b>newly created item!</b></p>
	<a href="NewAuctionsMain.jsp"><button>View All Items</button></a> 
	<%
	
		con.close();
	}
	catch (Exception ex){
		out.print(ex);
	}
		
	%>

</body>
</html>