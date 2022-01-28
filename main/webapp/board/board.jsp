<!-- 게시판 메인 -->

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
    	<jsp:useBean id="dao" class="board.BoardDAO"/>
    	<%
    	
    		BoardVO selectboard = null;
    		request.setCharacterEncoding("UTF-8");
    		String id = request.getParameter("bn");
    		
    		String duration = request.getParameter("dates");
    		String startdate = null, enddate = null;
    		if(duration != null){
    			int index = duration.indexOf(" ");
    			startdate = duration.substring(0,index);
    			enddate = duration.substring(index+3);
    		}
    		
    		if(id != null){
    			selectboard = dao.getBoard(id);
    		}
    	%>
    
    	<meta charset="UTF-8">
	
        <!--jquery-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" 
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

        <!--bootstrap-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
        <link rel="stylesheet" href="boardcontent.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
    	<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    </head>
    <body id="boardp">
    	<% List<BoardVO> list;
    	if(startdate != null && enddate != null){
    		list = dao.getList2(startdate, enddate);
    	}
    	else{
    		list = dao.getList();
    	}%>
    
        <div class="title">작업 관리/게시판</div>
        <div class="panel panel-default border searchbox">
            <div class="panel-body">
                제목:&nbsp;&nbsp;&nbsp;<input type="text" class="form-control searchtitle">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                작성일:&nbsp;&nbsp;&nbsp;<input type="text" name="dates" class="form-control searchtitle">
            
            	<script>
	                $('input[name="dates"]').daterangepicker({
	                    timePicker: false,
	                    locale:{
	                        format: 'YY/MM/DD'
	                    }
	                });
	                
	                $('input[name="dates"]').change(function(){
	                    location.href="./board.jsp?dates=" + $('input[name="dates"]').val();
	                });
	                
	                <% if(duration != null){ %>
	                	$('input[name="dates"]').val("<%=duration%>");
	                <%}%>
	            </script>
            </div>
        </div>
        
        

		<div class="row">
        <div class="panel panel-default border boardlistbox col-md-6">
            <div class="panel-heading">
                <h5 class="panel-title">게시판 리스트</h5>
            </div>

            <div class="panel-body">
                <table class="table table-bordered table-hover">
                    <thead class="tablehead">
                        <th style="width: 10%;">No.</th>
                        <th style="width: 30%;">제목</th>
                        <th style="width: 30%;">작성자</th>
                        <th style="width: 30%;">작성일</th>
                    </thead>
                    <%for(BoardVO b: list) {%>
                    <tr class="tablecontent" id='<%= b.getBoard_num() %>' onclick="javascript:location.href='./board.jsp?bn=<%= b.getBoard_num() %>'">
                        <td><%=b.getBoard_num() %></td>
                        <td><%=b.getTitle() %></td>
                        <td><%=b.getWriter() %></td>
                        <td><%=b.getW_day() %></td>
                    </tr>
                    <%}; %>
                </table> 

                <ul class="pagination">
                    <li><a href="#">&laquo;</a></li>
                    <li class="active"><a href="#">1</a></li>
                    <li><a href="">2</a></li>
                    <li><a href="">3</a></li>
                    <li><a href="">4</a></li>
                    <li><a href="">5</a></li>
                    <li><a href="">&raquo;</a></li>
                </ul>
            </div>
        </div>
        
        <div class="panel panel-default border boardinputbox col-md-6">
            <div class="panel-heading">
                <h5 class="panel-title">게시판 등록/수정</h5>
            </div>

            <div class="panel-body">
                <form action="boardinsert.jsp" method="post">
                    <table style="border: 0; width: 98%;">
                        <tr>
                            <td>
                            	<div class="form-group boardnum">
                                    <label for="boardnuminput">게시판 번호 <span style="color: red;">*</span></label>
                                    <input type="text" id="boardnuminput" class="form-control" name="num" value=<%=dao.getLastnum() + 1 %> readonly>
                                </div>
                                <div class="form-group writeday">
                                    <label for="writedayinput">작성일자 <span style="color: red;">*</span></label>
                                    <input type="text" id="writedayinput" class="form-control" name="day" value=<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date()) %> readonly>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <div class="form-group boardtitle">
                                    <label for="boardtitleinput">게시판 제목</label>
                                    <input type="text" id="boardtitleinput" class="form-control" name="title">
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <div class="form-group boardcontents">
                                    <label for="boardcontentsinput">게시판 내용</label>
                                    <textarea id="boardcontentsinput" style="resize:none;" class="form-control" rows="7" name="content"></textarea>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <div class="buttongruops">
                                    <input class="btn btn-primary" type="reset" value="초기화" id="boardreset"/>
                                    <input class="btn btn-primary" type="submit" value="저장"/>
                                    <input class="btn btn-danger" type="button" value="삭제" onclick="javascript:location.href='./boarddelete.jsp?bn=<%= id %>'"/>
                                </div>
                                
                                <script>
                                	$("#boardreset").click(function(){
                                		$(".tablecontent").css({"background":"white"});
                                	})
                                </script>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
		</div>
		</div>
		
		<script>
		<%if(selectboard != null) { %>
		
			var row = document.getElementById("<%=selectboard.getBoard_num() %>");

            row.style.background = "lightgray";
            

            $(document).ready(function() {
                $('#boardnuminput').val("<%=selectboard.getBoard_num() %>");
            });
            $(document).ready(function() {
                $('#writedayinput').val("<%=selectboard.getW_day() %>");
            });
            $(document).ready(function() {
                $('#boardtitleinput').val("<%=selectboard.getTitle() %>");
            });
            $(document).ready(function() {
                $('#boardcontentsinput').val("<%=selectboard.getContent() %>");
            });
            
		<% } %>
		</script>
    </body>
</html>