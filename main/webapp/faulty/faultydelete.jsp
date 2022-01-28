<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="faulty.Faulty"%>
<%@ page import="faulty.FaultyDAO"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<%
			FaultyDAO dao = new FaultyDAO();
			Faulty selectboard = null;
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
			alert('삭제하였습니다!'); location.href="faulty.jsp";
			<%}else { %>
	        alert('실패하였습니다!'); history.back();
	        <%}
	    }%>
</script>
</body>
</html>