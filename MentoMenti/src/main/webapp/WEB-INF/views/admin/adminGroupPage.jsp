<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@include file="adminMenuPart1.jsp" %>

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4" id="pageHeading">
	<h3>그룹 관리</h3>
</div>

<%
	String strPage = request.getParameter("page");
	int curPage;
	if (strPage == null)
		curPage = 1;
	else curPage = Integer.parseInt(strPage);
%>

<!-- 리스트 -->
<table class="table table-bordered dataTable" id="dataTable"
	width="100%" cellspacing="0" role="grid"
	aria-describedby="dataTable_info"
	style="width: 100%; background: white; text-align: center;">
	<thead>
		<tr role="row">
			<th tabindex="0" rowspan="1" colspan="1" style="width: 10%">번호</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 25%">이름</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 15%">멘토 아이디</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 40%;">소개글</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 10%;">해체</th>
		</tr>
	</thead>
	
	<tbody>
		<%
			List<GroupDTO> groupList = HomeController.dao.getGroupDAO().selectGroups();
			if (groupList.size() == 0){	//결과가 없다면
		%>
	</tbody>
</table>
	<div style="height:200px; text-align:center; line-height:200px">
		그룹이 존재하지 않습니다.	
	</div>
		
		<%
			}
			else {	//결과가 있다면
				for (int i=(curPage-1)*10; i<(curPage-1)*10+10;i++){
					if(i==groupList.size()){
						break;
					}
					GroupDTO g = groupList.get(i);
		%>
		<tr role="row" class="odd">
			<td><%=g.getGroupid()%></td>
			<td><a href="group?groupid=<%=g.getGroupid()%>"><%=g.getName() %></a></td>
			<td><%=g.getMentoid() %></td>
			<td><%=g.getIntro()%></td>
			<td>	<!-- 해체 버튼 -->
				<input type="button" class="btn btn-danger deleteBtn" value="X" style="padding:2px 10px" onclick="delGroup(<%=g.getGroupid()%>)">
			</td>
		</tr>
		<%
				}
		%>
	</tbody>
</table>
		<%
			}
		%>
		
<!-- 페이지 버튼 -->
<input type="hidden" id="curPage" value="<%=curPage%>"/>
<input type="hidden" id="groupSize" value="<%=groupList.size() %>"/>
<div class="d-flex align-items-center justify-content-between">
		<nav aria-label="Page navigation example" style="margin: 0 auto;">
  			<ul class="pagination justify-content-center" id="list-body">
    			<!-- 페이징 생성 -->
 			</ul>
		</nav>
</div>


<%@include file="adminMenuPart2.jsp" %>
<script>
	//작성한 글 개수 가져오기
	var postData = document.getElementById("groupSize").value;
	var curpage = document.getElementById("curPage").value;
	$(document).ready(function () {
		paging(postData,curpage);
	});

	function paging(totalData, currentPage){
		
		var dataPerPage = 10; //한 페이지에 보여지는 데이터 수
		var countPage = 5; //한번에 보여지는 페이지 수
		
		//총페이지수
		var totalPage = totalData / dataPerPage;
		if(totalData%dataPerPage>0){
			totalPage++;
		}
		
		//보여지는 페이지번호
		var startPage = Math.floor(((currentPage-1)/countPage))*countPage+1;
		var endPage = startPage + countPage-1;
		if(endPage>totalPage){
			endPage = totalPage;
		}
		const prev = startPage-1;
		const next = endPage+1;
		
		$('#list-body').empty();
		if(startPage > countPage){
			$("#list-body").append("<li class='page-item'><a class='page-link' href='adminGroupPage?page="+prev+"'"+" aria-label='Next'><span aria-hidden='true'>&laquo;</span></a></li>");	
		}
		for(var j=startPage ; j<=endPage ; j++){
			if(currentPage==(j)){
				$("#list-body").append("<li class='page-item active'><a class='page-link' href='adminGroupPage?page=" + j + "'>" + j + "</a></li>");
			}else if(j>0){
				$("#list-body").append("<li class='page-item'><a class='page-link' href='adminGroupPage?page=" + j + "'>" + j + "</a></li>");		
			}
		}
		if(next > 5 && next < totalPage)
		$("#list-body").append("<li class='page-item'><a class='page-link' href='adminGroupPage?page="+next+"'"+" aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>")
	} 
	
	function delGroup(groupid){
		if (confirm(groupid+"번 그룹을 해체시키겠습니까?")){
			location.href="processDeleteGroup?from=adminPage&groupid="+groupid;
		}
	}
</script>