<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="Mento.Menti.Project.dto.PostDTO, Mento.Menti.Project.dao.PostDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.CommentDTO, Mento.Menti.Project.dao.CommentDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@include file="adminMenuPart1.jsp" %>

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4"
	style="margin-top: 50px" id="pageHeading">
	<h3>댓글 관리</h3>
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
			<th tabindex="0" rowspan="1" colspan="1" style="width: 15%">게시판</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 40%">내용</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 10%;">작성자</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 15%;">작성일자</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 10%;">삭제</th>
		</tr>
	</thead>
	
	<tbody>
		<%
			List<CommentDTO> commentList = HomeController.dao.getCommentDAO().selectAllComments();
			if (commentList.size() == 0){	//결과가 없다면
		%>
	</tbody>
</table>
	<div style="height:200px; text-align:center; line-height:200px">
		댓글이 존재하지 않습니다.		
	</div>
		
		<%
			}
			else {	//결과가 있다면
				for (int i=(curPage-1)*10; i<(curPage-1)*10+10;i++){
					if(i==commentList.size()){
						break;
					}
					CommentDTO c = commentList.get(i);
		%>
		<tr role="row" class="odd">
			<td><%=c.getCommentid()%></td>
			<td>
					<%
						PostDTO commentpost = null;
						
						if (HomeController.dao.getPostDAO().searchByPostId(c.getPostid()).size() > 0) {
							commentpost=HomeController.dao.getPostDAO().searchByPostId(c.getPostid()).get(0);
						}
						GroupDTO group = HomeController.dao.getGroupDAO().searchGroupByGroupid(commentpost.getGroupid());
						
						if(!(commentpost.getGroupid()>0) && commentpost.is_notice()){
							%>
							<a href="/notice">공지사항</a>
							<%
						}else if(!(commentpost.getGroupid()>0) && !commentpost.is_notice()){
							%>
							<a href="/freeBoard">자유게시판</a>
							<%
						}else if((commentpost.getGroupid()>0) && commentpost.is_notice()){
							%>
							<a href="groupnotice?groupid=<%=commentpost.getGroupid()%>"><%=group.getName()%> - 공지사항</a>
							<%
						}else if((commentpost.getGroupid()>0) && !commentpost.is_notice()){
							%>
							<a href="groupQnA?groupid=<%=commentpost.getGroupid()%>"><%=group.getName()%> - QnA</a>
							<%
						}
					
					%>
			</td>
			<td>
				<%
					
					if(!(commentpost.getGroupid()>0) && commentpost.is_notice()){
				%>
					<a href="noticeContent?postid=<%=commentpost.getPostid()%>"><%=c.getContent()%></a>
				<%
					}else if(!(commentpost.getGroupid()>0) && !commentpost.is_notice()){
				%>
					<a href="postContent?postid=<%=commentpost.getPostid()%>"><%=c.getContent()%></a>
				<%
					}else if((commentpost.getGroupid()>0) && commentpost.is_notice()){
				%>
					<a href="groupNoticeContent?postid=<%=commentpost.getPostid()%>"><%=c.getContent()%></a>
				<%
					}else if((commentpost.getGroupid()>0) && !commentpost.is_notice()){
				%>
					<a href="groupPostContent?postid=<%=commentpost.getPostid()%>"><%=c.getContent()%></a>
				<%
					}
				%>
			</td>
			<td><%=c.getWriterid() %></td> <!-- 작성자, 현재는 id가 출력되도록. 나중에 닉네임으로 바꿀듯 -->
			<td><%=c.getCommentdate()%></td> <!-- 작성일자 -->
			<td>	<!-- 삭제 버튼 -->
				<input type="button" class="btn btn-danger deleteBtn" value="X" style="padding:2px 10px" onclick="delComment(<%=c.getCommentid()%>)">
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
<input type="hidden" id="postSize" value="<%=commentList.size() %>"/>
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
	var postData = document.getElementById("postSize").value;
	var curpage = document.getElementById("curPage").value;
	$(document).ready(function () {
		paging(postData,curpage);//작성글수, 현재페이지 : activity?page=1??? getParameter
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
			$("#list-body").append("<li class='page-item'><a class='page-link' href='adminCommentPage?page="+prev+"'"+" aria-label='Next'><span aria-hidden='true'>&laquo;</span></a></li>");	
		}
		for(var j=startPage ; j<=endPage ; j++){
			if(currentPage==(j)){
				$("#list-body").append("<li class='page-item active'><a class='page-link' href='adminCommentPage?page=" + j + "'>" + j + "</a></li>");
			}else if(j>0){
				$("#list-body").append("<li class='page-item'><a class='page-link' href='adminCommentPage?page=" + j + "'>" + j + "</a></li>");		
			}
		}
		if(next > 5 && next < totalPage)
		$("#list-body").append("<li class='page-item'><a class='page-link' href='adminCommentPage?page="+next+"'"+" aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>")
	} 
	
	function delComment(commentid){
		if (confirm(commentid+"번 댓글을 삭제하시겠습니까?")){
			location.href="processDeleteComment?from=adminPage&commentid="+commentid;
		}
	}
</script>