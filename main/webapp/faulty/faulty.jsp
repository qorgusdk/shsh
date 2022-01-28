<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="faulty.Faulty"%>
<%@ page import="faulty.FaultyDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>


<!DOCTYPE html>
<html>
<head>
<jsp:useBean id="dao" class="faulty.FaultyDAO"/>
	<%
   		request.setCharacterEncoding("UTF-8");
   	%>
<meta charset="UTF-8">

<!--jquery-->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
	rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<!--bootstrap-->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="faultycontent.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<meta charset="UTF-8">
<title>불량관리</title>
</head>
<body id=faultyp>
	<div class="title">작업 관리/불량 관리</div>
	<div class="panel panel-default border searchbox">
		<div class="panel-body">
			유형: <select name="items1" class="form-control searchtitle">
				<option value="전체">전체</option>
				<option value="수주">수주</option>
				<option value="자재 입고">자재 입고</option>
				<option value="공정">공정</option>
			</select> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 부품명:&nbsp;&nbsp;&nbsp;<input
				type="text" name="part" class="form-control searchtitle">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 공정:&nbsp;&nbsp;&nbsp;<input
				type="text" name="process" class="form-control searchtitle">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 발생일자:&nbsp;&nbsp;&nbsp;<input
				type="text" name="dates" class="form-control searchtitle">
		</div>
	</div>

	<script>
		
		$('input[name="dates"]').daterangepicker({
			timePicker : false,
			locale : {
				format : 'YY/MM/DD'
			}
		});
	</script>

	<div class="row">
		<div class="panel panel-default border boardlistbox col-md-6">
			<div class="panel-heading">
				<h5 class="panel-title">불량 리스트</h5>
			</div>
			
			<div class="panel-body">
            	<div id="boardt"></div>
			</div>
		</div>
	</div>

		<div class="panel panel-default border boardinputbox col-md-6">
			<div class="panel-heading">
				<h5 class="panel-title">불량 등록/수정</h5>
			</div>

			<div class="panel-body">
			<input type="text" id="faultynoinput" style="display:none;"/>
				<form action="faultyinsert.jsp" method="post">
					<table style="border: 0; width: 98%;">
						<tr>
							<td>
								<div class="form-group boardtitle">
									<label for="linkinfoinput">링크 정보 <span style="color: red;">*</span></label>
									<input type="text" id="linkinfoinput" class="form-control"
										name="link_info">
								</div>

							</td>
						</tr>
						<tr>
							<td>
								<div class="form-group faulty-type"
									>
									<label for="faulty_type">불량 유형 <select
										name="faulty_type" class="form-control" id="faultytypeinput">
											<option value="수주">수주</option>
											<option value="자재 입고">자재 입고</option>
											<option value="공정">공정</option>
									</select>
								</div>

								<div class="form-group faulty-type"
									>
									<label for="cause_of_defect">불량 원인 <select
										name="items1" class="form-control" id="faultydefectinput">
											<option value="원인1">원인1</option>
											<option value="원인2">원인2</option>
											<option value="원인3">원인3</option>
									</select>
								</div>

								<div class="form-group faulty-type"
									>
									<label for="date_of_occurrence">발생 일자 <input
										type="date" id="date_of_occurrence" class="form-control"
										name="date_of_occurrence" id="faultydateinput">
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="form-group left"
									>
									<label for="materials_cost">자재비용(원) <input type="text"
										id="faultymcostinput" class="form-control" name="materials_cost">
								</div>
								<div class="form-group right"
									>
									<label for="cost">비용(원) <input type="text" id="faultycostinput"
										class="form-control" name="cost">
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="form-group boardtitle">
									<label for="faluty_title">불량 제목</label> <input type="text"
										id="faultytitleinput" class="form-control" name="faluty_title">
								</div>
							</td>
						</tr>

						<tr>
							<td>
								<div class="form-group boardcontents">
									<label for="faulty_content">불량 내용</label>
									<textarea id="faultycontinput" style="resize: none;"
										class="form-control" rows="3" name="faulty_content"></textarea>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="form-group boardtitle">
									<label for="solution">해결방안</label> <input type="text"
										id="faultysoluinput" class="form-control" name="solution">
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="form-group left"
									>
									<label for="user_id">담당자 <select
										name="user_id" class="form-control" id="faultyidinput">
											<option value="adminName">adminName</option>
											<option value="qorgusdk">백현</option>
									</select>
								</div>
								<div class="form-group right"
									>
									<label for="proc_date">처리일자 <input type="date"
										id="faultypdateinput" class="form-control" name="proc_date">
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<div class="buttongruops">
									<input class="btn btn-primary" type="reset" value="초기화"
										id="faultyreset" /> <input class="btn btn-primary"
										type="submit" value="저장" /> <input class="btn btn-danger"
										type="button" value="삭제">
								</div> <script>
									$("#faultyreset").click(function() {
										$(".tablecontent").css({
											"background" : "white"
										});
									})
								</script>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>


</body>
</html>
<script>
	var pnum = "1";
	
	<!-- 게시판 테이블 셋팅 -->
	$(document).ready(function(){
		$.ajax({
	        type:"GET",
	        url:"./faultysearch.jsp",
	        data:{page:pnum},
	        dataType:"html",
	        success:function(data){
	            $("#boardt").html(data);
	        }
	    });
	});
</script>