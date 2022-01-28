<!-- 게시판 삽입 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardVO" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<jsp:useBean id="vo" class="board.BoardVO"/>
	<jsp:useBean id="dao" class="board.BoardDAO"/>
	
	<jsp:setProperty name="vo" property="board_num" param="num"/>
	<jsp:setProperty name="vo" property="writer" value="admin"/>
	<jsp:setProperty name="vo" property="w_day" value="<%= new Date() %>"/>
	<jsp:setProperty name="vo" property="title" param="title"/>
	<jsp:setProperty name="vo" property="content" param="content"/>
	
	<%if(dao.insertBoard(vo) > 0){ %>
		<script>alert('완료하였습니다!'); location.href="board.jsp"</script>
	<%}else{ %>
		<script>alert('실패하였습니다!'); history.back();</script>
		<%} %>
</body>
</html>
