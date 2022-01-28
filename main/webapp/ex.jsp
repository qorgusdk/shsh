<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %> 
<%@ page import = "java.sql.Statement" %> 
<%@ page import = "java.sql.ResultSet" %> 
<%@ page import = "java.sql.SQLException" %>


<!DOCTYPE html>
<html> 
<head>
<title> 이걸 해야합니다</title></head> 

<body>  이걸 해야합니다
<table width="100%" border="1"> 
<button name="button"> 버튼이요

<tr> 
	<td>Name</td><td>ID</td><td>E-Mail</td> 
</tr> 
<% 
	// MySQL JDBC Driver Loading 
	Class.forName("com.mysql.jdbc.Driver"); 

	Connection conn = null;
	Statement stmt = null; 
	ResultSet rs = null; 
	
	try { 
		String jdbcDriver = "jdbc:mysql://localhost:3306/KSH?" + "useUnicode=true&characterEncoding=utf8"; 
		String dbUser = "root"; String dbPass = "12341234"; 
		String query = "select * from users"; 
		
		// Create DB Connection 
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		// Create Statement 
		stmt = conn.createStatement(); 
		// Run Qeury 
		rs = stmt.executeQuery(query); 
		// Print Result (Run by Query) 
		while(rs.next()) { 
%>
<tr> 
	<td><%= rs.getString("id") %></td> 
	<td><%= rs.getString("pw") %></td> 
	<td><%= rs.getString("name") %></td> 
</tr> 

<% 
		} 
	} 
	catch(SQLException ex) { 
		out.println(ex.getMessage()); 
		ex.printStackTrace(); }
	finally { 
		// Close Statement 
		if (rs != null) 
			try { rs.close(); } catch(SQLException ex) {} 
		if (stmt != null) try { stmt.close(); } catch(SQLException ex) {} 
		// Close Connection 
		if (conn != null) try { conn.close(); } catch(SQLException ex) {} 
		} 
%> 
</table> 

</body> 
</html>

