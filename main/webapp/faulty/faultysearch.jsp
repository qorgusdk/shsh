<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    
<%@ page import="faulty.FaultyDAO" %>
<%@ page import="faulty.Faulty" %>
<%@ page import="java.util.List" %>


<%
	request.setCharacterEncoding("UTF-8");
	int lastboardnum = -1;
	String pagenum = request.getParameter("page");
	int p = 1;
	if(pagenum != null){
		p = Integer.parseInt(pagenum);
	}
	
	String duration = request.getParameter("date");
	String startdate = null, enddate = null;
	
	if(duration != "" && duration != null){
		int index = duration.indexOf(" ");
		startdate = duration.substring(0,index);
		enddate = duration.substring(index+3);
	}
	
	if(duration == ""){
		duration = null;
	}
	
	String sda = request.getParameter("sdata");
	if(sda == ""){
		sda = null;
	}
%>

<jsp:useBean id="dao" class="faulty.FaultyDAO"/>

<%	
	List<Faulty> list = null;
	if(duration == null && sda == null){
		list = dao.getList();
		//lastboardnum = dao.getNext() - 1;
		
	}
	
%>
<table class="table table-bordered table-hover">
		<thead class="tablehead">
			<th style="width: 10%;">유형</th>
			<th style="width: 30%;">발생일자</th>
			<th style="width: 30%;">부품명</th>
			<th style="width: 30%;">공정</th>
		</thead>
<%
for(Faulty b: list) {%>
		<tbody>
		<tr class="tablecontent" id='<%= b.getFaulty_no() %>'>      
			<td id="flink" style='display:none'><%=b.getLink_info() %></td>
			<td id="ftype"><%=b.getFaulty_type() %></td>
			<td id="fdefect" style='display:none'><%=b.getCause_of_defect() %></td>
			<td id="fdate"><%=b.getDate_of_occurrence() %></td>
			<td id="fmcost" style='display:none'><%=b.getMaterials_cost() %></td>
			<td id="fcost" style='display:none'><%=b.getCost() %></td>
			<td id="ftitle" style='display:none'><%=b.getFaulty_title() %></td>
			<td id="fcont" style='display:none'><%=b.getFaulty_content() %></td>
			<td id="fsolu" style='display:none'><%=b.getSolution() %></td>
			<td id="fid" style='display:none'><%=b.getUser_id() %></td>
			<td id="fpdate" style='display:none'><%=b.getProc_date() %></td>
			<td id="fpname"><%=b.getPart_name() %></td>
			<td id="fproc"><%=b.getProcess() %></td>
			
		</tr>
		</tbody>
		<%}; %>
		
<% if(list.isEmpty()){ %>
		<tr>
			<td colspan="4" align="center"><div>불량이 없습니다.</div></td>
		</tr>
<%}; %>
<script>
			$(".tablecontent").click(function(){
				$(".tablecontent").css("background","white");
				$(this).css("background","lightgray");
				
				$('#faultynoinput').val($(this).attr("id"));
				$('#linkinfoinput').val($(this).children("#flink").text());
				$('#faultytypeinput').val($(this).children("#ftype").text());
				$('#faultydefectinput').val($(this).children("#fdefect").text());
				$('#faultydateinput').val($(this).children("#fdate").text());
				$('#faultymcostinput').val($(this).children("#fmcost").text());
				$('#faultycostinput').val($(this).children("#fcost").text());
				$('#faultytitleinput').val($(this).children("#ftitle").text());
				$('#faultycontinput').val($(this).children("#fcont").text());
				$('#faultysoluinput').val($(this).children("#fsolu").text());
				$('#faultyidinput').val($(this).children("#fid").text());
				$('#faultypdateinput').val($(this).children("#fpdate").text());
				$('#faultypnameinput').val($(this).children("#fpname").text());
				$('#faultyprocinput').val($(this).children("#fproc").text());
				
				let bnn = $(this).attr("id");
				
				$('#deletefaulty').click(function(){
					$.ajax({
						type:"GET",
						url:"./faultydelete.jsp",
						data:{bn:bnn},
						success:function(){
							alert('삭제하였습니다!');
							location.href = "./faulty.jsp";
						}
					});
				});
			});
		</script>
</table>