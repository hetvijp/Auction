<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sales Report</title>
</head>
<body>
<%@ page import="java.sql.*" %>
<%
	try{
		
		String type = request.getParameter("type");
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		PreparedStatement ps = null;
		ResultSet result = null;
		
		if(type.equals("totalEarnings")){
			String totalEarnings = "SELECT SUM(highest_bid) as total from auction where sold = 1";
			ps = con.prepareStatement(totalEarnings);
			result = ps.executeQuery();
			
			if(result.next()){
%>
				<h2>Sales Report:</h2>
				<table>
					<tr>
						<th>Total Earnings</th>
					</tr>
				<% do { %>
					<tr>
						<td>$<%= result.getFloat("total")%></td>
					</tr>
				<% } while (result.next()); %>
				</table>
				<br><a href="SalesReport.jsp">Generate more sales reports</a>
<%	
			}
		}else if(type.equals("earningsPerItem")){
			String earningPerItem = "SELECT product_id, SUM(highest_bid) as total FROM auction where sold = 0 GROUP BY product_id";
			ps = con.prepareStatement(earningPerItem);
			result = ps.executeQuery();
			
			if(result.next()){
%>
				<h2>Sales Report:</h2>
				<table>
					<tr>
						<th>Product Id</th>
						<th></th>
						<th>Earnings</th>
					</tr>
				<% do { %>
					<tr>
						<td><%= result.getInt("product_id") %></td>
						<td></td>
						<td>$<%= result.getFloat("total") %></td>
					</tr>
				<% } while (result.next()); %>
				</table>
				<br><a href="SalesReport.jsp">Generate more sales reports</a>
<%	
			}else{
				out.print("No items is sold yet");
			}
		}else if(type.equals("earningPerItemType")){
			String earningPerItemTypePhone = "SELECT sum(highest_bid) as phone from auction join phone using (product_id) where sold = 1";
			ps = con.prepareStatement(earningPerItemTypePhone);
			result = ps.executeQuery();
			
			if(result.next()){
%>
				<h2>Sales Report:</h2>
				<table>
					<tr>
						<th>Type</th>
						<th></th>
						<th>Earnings</th>
					</tr>
				<% do { %>
					<tr>
						<td>Phone</td>
						<td></td>
						<td>$<%= result.getFloat("phone") %></td>
					</tr>
				<% 
					} while (result.next()); 
				%>
				</table>
	<%	
			}else{
				out.print("No items is sold yet");
			}
			
			String earningPerItemTypeLaptop = "SELECT sum(highest_bid) as laptop from auction join laptop using (product_id) where sold = 1";
			PreparedStatement ps1 = con.prepareStatement(earningPerItemTypeLaptop);
			ResultSet result1 = ps1.executeQuery();
			if(result1.next()){
	%>
				<table>
					<tr>
					</tr>
					<% do { %>
						<tr>
							<td>Laptop</td>
							<td></td>
							<td>$<%= result1.getFloat("laptop") %></td>
						</tr>
					<% } while (result1.next()); %>
				</table>
				<%	
				}else{
				out.print("No items is sold yet");
				}
			String earningPerItemTypeWatch = "SELECT sum(highest_bid) as watch from auction join smartwatch using (product_id) where sold = 1";
			PreparedStatement ps2 = con.prepareStatement(earningPerItemTypeWatch);
			ResultSet result2 = ps2.executeQuery();
			if(result2.next()){
				%>
					<table>
						<tr></tr>
					<% do { %>
						<tr>
							<td>Watch</td>
							<td></td>
							<td>$<%= result2.getFloat("watch") %></td>
						</tr>
					<% 
						} while (result2.next()); 
					%>
						</table>
						<br><a href="SalesReport.jsp">Generate more sales reports</a>
				<%	
				}else{
					out.print("No items is sold yet");
				}
			
		}else if(type.equals("earningPerEndUser")){
			String earningPerEndUser = "SELECT username, SUM(highest_bid) as total FROM auction where sold = 0 GROUP BY username";
			ps = con.prepareStatement(earningPerEndUser);
			result = ps.executeQuery();
			
			if(result.next()){
%>
				<h2>Sales Report:</h2>
				<table>
					<tr>
						<th>User</th>
						<th></th>
						<th>Earnings</th>
					</tr>
				<% do { %>
					<tr>
						<td><%= result.getString("username") %></td>
						<td></td>
						<td>$<%= result.getFloat("total") %></td>
					</tr>
				<% } while (result.next()); %>
				</table>
				<br><a href="SalesReport.jsp">Generate more sales reports</a>
<%	
			}else{
				out.print("No items is sold yet");
			}
			
		}else if(type.equals("bestSelling")){
			String bestSelling = "SELECT product_id, COUNT(product_id) as count, SUM(highest_bid) as total FROM auction where sold = 0 GROUP BY product_id ORDER BY COUNT(product_id) DESC";
			ps = con.prepareStatement(bestSelling);
			result = ps.executeQuery();
			
			if(result.next()){
%>
				<h2>Sales Report:</h2>
				<table>
					<tr>
						<th>Product id</th>
						<th></th>
						<th>Sold</th>
						<th></th>
						<th>Earnings</th>
					</tr>
				<% do { %>
					<tr>
						<td><%= result.getString("product_id") %></td>
						<td></td>
						<td><%= result.getInt("count") %></td>
						<td></td>
						<td>$<%= result.getFloat("total") %></td>
					</tr>
				<% } while (result.next()); %>
				</table>
				<br><a href="SalesReport.jsp">Generate more sales reports</a>
<%	
			}else{
				out.print("No items is sold yet");
			}
			
		}else if(type.equals("bestBuyers")){
			String bestBuyers = "SELECT highest_user, COUNT(highest_user) as count, SUM(highest_bid) as total FROM auction GROUP BY highest_user ORDER BY COUNT(highest_user) DESC";
			ps = con.prepareStatement(bestBuyers);
			result = ps.executeQuery();
			
			if(result.next()){
%>
				<h2>Sales Report:</h2>
				<table>
					<tr>
						<th>Buyer</th>
						<th></th>
						<th>Number of Purchase</th>
						<th></th>
						<th>Earnings</th>
					</tr>
				<% do { %>
					<tr>
						<td><%= result.getString("highest_user") %></td>
						<td></td>
						<td><%= result.getInt("count") %></td>
						<td></td>
						<td>$<%= result.getFloat("total") %></td>
					</tr>
				<% } while (result.next()); %>
				</table>
				<br><a href="SalesReport.jsp">Generate more sales reports</a>
<%	
			}else{
				out.print("No items is sold yet");
			}
			
		}else{
			out.print("Something went wrong");
		}
	
	}
	catch(Exception ex){
		out.print(ex);
	}
%>

</body>
</html>