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
		
		int queId = Integer.parseInt(request.getParameter("quesId"));
		String answer = request.getParameter("Answer");
		
		String insert = "UPDATE question SET ans=? where qid=?";
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setString(1, answer);
		ps.setInt(2, queId);
		ps.executeUpdate();
		
		response.sendRedirect("../CustomerRepresentative/CustomerRepPage.jsp");
		
	}
	catch(Exception ex){
		
	}
%>

</body>
</html>