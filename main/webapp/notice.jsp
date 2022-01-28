<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="Notice.noticeDAO"%>
<%@ page import="Notice.notice"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width-device-width" , initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
	// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
	String userId = null;
	if (session.getAttribute("userId") != null) {
		userId = (String) session.getAttribute("userId");
	}
	int pageNumber = 1; //기본은 1 페이지를 할당
	// 만약 파라미터로 넘어온 오브젝트 타입 'pageNumber'가 존재한다면
	// 'int'타입으로 캐스팅을 해주고 그 값을 'pageNumber'변수에 저장한다
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>
	<nav class="navbar navbar-default">
		<!-- 네비게이션 -->
		<div class="navbar-header">
			<!-- 네비게이션 상단 부분 -->
			<!-- 네비게이션 상단 박스 영역 -->
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<!-- 이 삼줄 버튼은 화면이 좁아지면 우측에 나타난다 -->
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<!-- 상단 바에 제목이 나타나고 클릭하면 main 페이지로 이동한다 -->
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<!-- 게시판 제목 이름 옆에 나타나는 메뉴 영역 -->
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="notice.jsp">게시판</a></li>
			</ul>
			<%
			// 로그인 하지 않았을 때 보여지는 화면
			if (userId == null) {
			%>
			<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a> <!-- 드랍다운 아이템 영역 -->
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<%
			// 로그인이 되어 있는 상태에서 보여주는 화면
			} else {
			%>
			<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a> <!-- 드랍다운 아이템 영역 -->
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
			}
			%>
		</div>
	</nav>
	<!-- 네비게이션 영역 끝 -->



	<!-- 우아아아아아ㅏ아아아아아ㅏㅇ ㅌ테이블 시작이에오오오오오옹 -->
	<table class="table" style="table-layout: auto;">

		<!-- 게시판 글쓰기 양식 영역 시작 -->
		<tr>
			<td>
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">게시판
								리스트</th>
						</tr>
					</thead>

				</table>
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">

					<!-- 게시판 메인 페이지 영역 시작 -->

					<td>
						<div id="list" class="card-body">

							<div class="col">

								<table class="table table-striped"
									style="text-align: center; border: 1px solid #dddddd">
									<thead>
										<tr>
											<th style="background-color: #eeeeee; text-align: center;">게시판
												번호</th>
											<th style="background-color: #eeeeee; text-align: center;">작성일자</th>
											<th style="background-color: #eeeeee; text-align: center;">게시판
												제목</th>
											<th style="background-color: #eeeeee; text-align: center;">작성자</th>
										</tr>
									</thead>
									<tbody>
										<%
										noticeDAO Notice = new noticeDAO(); // 인스턴스 생성
										ArrayList<notice> list = Notice.getList(pageNumber);
										for (int i = 0; i < list.size(); i++) {
										%>
										<tr>
											<td><%=list.get(i).getNoticeId()%></td>
											<!-- 게시글 제목을 누르면 해당 글을 볼 수 있도록 링크를 걸어둔다 -->
											<td><%=list.get(i).getNoticeDate()%></td>
											<td><a
												href="view.jsp?nID=<%=list.get(i).getNoticeId()%>"> <%=list.get(i).getNoticeTitle()%></a></td>
											<td><%=list.get(i).getNoticeWriter()%></td>

										</tr>
										<%
										}
										%>
									</tbody>

								</table>
								<!-- 페이징 처리 영역 -->
								<%
								if (pageNumber != 1) {
								%>
								<a href="notice.jsp?pageNumber=<%=pageNumber - 1%>"
									class="btn btn-success btn-arraw-left">이전</a>
								<%
								}
								if (Notice.nextPage(pageNumber + 1)) {
								%>
								<a href="notice.jsp?pageNumber=<%=pageNumber + 1%>"
									class="btn btn-success btn-arraw-left">다음</a>
								<%
								}
								%>

							</div>
						</div>
					</td>
				</table>
			</td>
			<td>
				<!-- 게시판 메인 페이지 영역 끝 -->
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr
							style="background-color: #eeeeee; text-align: center; ">
							<th style=" text-align: center;">게시판 등록/수정</th>
						</tr>
					</thead>
					<th>
						<form method="post" action="writeAction.jsp">
							<div id="write" class="card-body">
								<div class="col">

									<table class="table table-striped"
										style="text-align: center; border: 1px solid #dddddd">

										<tbody>
											<tr>
												<label for="nid">게시판 번호 </label>
												<input type="text" class="form-control" id="nid"
													name="noticeID" maxlength="50" readonly>
											</tr>
											<tr>
												<label for="nid">작성 일자 </label>
												<input type="text" class="form-control" id="ndate"
													name="noticeDATE" maxlength="50" readonly>
											</tr>
											<tr>
												<label for="nid">글 제목</label>
												<input type="text" class="form-control" name="noticeTitle"
													maxlength="50">
											</tr>
											<tr>
												<label for="nid">글 내용</label>
												<textarea class="form-control" name="noticeContents"
													maxlength="2048" style="height: 350px;"></textarea>
											</tr>
											<tr>
												<!-- 글쓰기 버튼 생성 -->
												<input type="submit" class="btn btn-primary pull-right"
													value="글쓰기">
											</tr>
										</tbody>

									</table>

								</div>
							</div>
						</form>
					</th>
					<!-- 게시판 글쓰기 양식 영역 끝 -->
				</table>
			</td>
		</tr>
	</table>

		</div>
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>