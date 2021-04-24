<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Auction</title>
</head>
<body>
	<a href="CustomerRepPage.jsp"><button>Back</button></a>
	<br>
	
	<form action="deleteAuctionConfirmation.jsp" method="POST">
    	<div>
    		<label>Auction Id</label>
        	<input type="text" name="auctionId" placeholder="1" required> 
        </div>
        
        <br>
        
        <input type="submit" value="Delete Auction">
    </form>
</body>
</html>