<!-- 게시판 삭제 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.BoardVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
		<%
			BoardDAO dao = new BoardDAO();
			BoardVO selectboard = null;
    		request.setCharacterEncoding("UTF-8");
    		String id = request.getParameter("bn");
    	%>
</head>
<body>
<script>
		<%
		if(id != null){
			int result = dao.deleteBoard(id);
			
			if(result != 0){%> 
			alert('삭제하였습니다!'); location.href="board.jsp";
			<%}else { %>
	        alert('실패하였습니다!'); history.back();
	        <%}
	    }%>
</script>
</body>
</html>