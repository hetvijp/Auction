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
	<h1>Enter your question</h1>
	<form action="registerQuestion.jsp" method="POST">
		<textarea maxlength=250 id="question" name="question" required></textarea>
		<input type="submit" value="Submit">
	</form>
	
<%
	try{
		ApplicationDB db = new ApplicationDB();
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		
		String userId = (String) session.getAttribute("user");
		String questions = "SELECT * from question";
		ResultSet result = stmt.executeQuery(questions);
		String ans = "Waiting for the answer";
				
		
		if(result.next()){
%>
			<h1>Questions</h1>
			<table>
				<tr>
					<th>Question</th>
					<th>Answer</th>
				</tr>
				<% do { %>
						<tr>
							<td><%= result.getString("q") %></td>
							<% if(session.getAttribute("type") != "CR") { %>
								<td><%= result.getString("ans") %></td>
							<% } else { %>
								<form action="registerAnswers.jsp?quesId=<%= result.getInt("qid") %>" method="POST">
									<td>
										<textarea type="textarea" name="Answer" required></textarea>
										<input type="submit" value="Answer">
									</td>
							</form>
							<% } %>
						</tr>
				<% } while(result.next()); %>	
			</table>		
<%
		}
	}
	catch(Exception ex){
		out.print(ex);
	}
%>
	
</body>
</html>