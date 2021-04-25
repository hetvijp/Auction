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
<%
	try{
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		String userId = (String) session.getAttribute("user");
		String question = request.getParameter("question");
		
		String insert = "INSERT INTO question(q, ans)" + "VALUES(?,?)";
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setString(1, question);
		ps.setString(2, "Waiting for the answer");
		ps.executeUpdate();
				
		String questions = "SELECT qid from question where q = '" + question + "'";
		ResultSet result = stmt.executeQuery(questions);
		result.next();
		int queId = result.getInt("qid");
		
		String insert1 = "INSERT INTO ask(username, qid, date_time)" + "VALUES(?,?,NOW())";
		PreparedStatement ask = con.prepareStatement(insert1);
		ask.setString(1, userId);
		ask.setInt(2, queId);
		ask.executeUpdate();
				
		response.sendRedirect("CustomerPage.jsp");
		
	}
	catch(Exception ex){
		out.print(ex);
	}
%>
</body>
</html>