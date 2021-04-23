<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h3>What type of sales report do you want to check?</h3>
	<ul>
		<li><a href="salesReportFile.jsp?type=totalEarnings">Total Earnings</a></li>
		<li><a href="salesReportFile.jsp?type=earningsPerItem">Earnings per item</a></li>
		<li><a href="salesReportFile.jsp?type=earningPerItemType">Earnings per item type</a></li>
		<li><a href="salesReportFile.jsp?type=earningPerEndUser">Earnings per end-user</a></li>
		<li><a href="salesReportFile.jsp?type=bestSelling">Best-selling items</a></li>
		<li><a href="salesReportFile.jsp?type=bestBuyers">Best Buyers</a></li>
	</ul>

	<a href="AdminPage.jsp"><button>Back</button></a>
</body>
</html>