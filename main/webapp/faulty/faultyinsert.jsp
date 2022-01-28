<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ page import="faulty.Faulty"%>
<%@ page import="faulty.FaultyDAO"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="vo" class="faulty.Faulty"/>
	<jsp:useBean id="dao" class="faulty.FaultyDAO"/>
	
	<jsp:setProperty name="vo" property="link_info" param="num"/>
	<jsp:setProperty name="vo" property="faulty_type" value="admin"/>
	<jsp:setProperty name="vo" property="cause_of_defect" param="title"/>
	<jsp:setProperty name="vo" property="date_of_occurrence" value="<%= new Date() %>"/>
	<jsp:setProperty name="vo" property="materials_cost" param="content"/>
	<jsp:setProperty name="vo" property="cost" value="admin"/>
	<jsp:setProperty name="vo" property="faluty_title" value="admin"/>
	<jsp:setProperty name="vo" property="faulty_content" value="admin"/>
	<jsp:setProperty name="vo" property="solution" value="admin"/>
	<jsp:setProperty name="vo" property="user_id" value="admin"/>
	<jsp:setProperty name="vo" property="proc_date" value="<%= new Date() %>"/>

	
	<%if(dao.insertBoard(vo) > 0){ %>
		<script>alert('완료하였습니다!'); location.href="faulty.jsp"</script>
	<%}else{ %>
		<script>alert('실패하였습니다!'); history.back();</script>
		<%} %>
</body>
</html>