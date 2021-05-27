<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.PostDTO, Mento.Menti.Project.dao.PostDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.CommentDTO, Mento.Menti.Project.dao.CommentDAO"%>
<%@ page import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<style>
.text1 {
	font-weight:500;
}

.wrapContents {
	width:100%;
	overflow: hidden;
}

.content1 {
	margin-bottom: 30px;
}

.dataTable{
	margin: 0 auto;
	background: white;
	position: relative; 
	text-align: center; 
	margin-top:20px;
}

.content1 a{
	text-decoration:none !important;
}
.content2 a{
	text-decoration:none !important;
}

</style>
<!--내용 부실시 아래에 흰 공간 생성제거: wrapper=height:100%-->

<title>MOCO</title>

<link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">
<link href="resources/css/component.css" rel="stylesheet"
	type="text/css">
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
</head>

<%@include file="/WEB-INF/views/menuPart1.jsp"%>

<%
	if (id == null){	//로그인 안된 상태면 로그인 페이지로 이동
		response.sendRedirect("loginPage?mode=nidLogin");
	} else {
%>

<%
	int curPage = Integer.parseInt(request.getParameter("page"));
	int curPage_c = Integer.parseInt(request.getParameter("compage"));
%>

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4" id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">나의 활동</h1>
</div>
<hr>
	
<div class="wrapContents">
	<!-- 나의 게시글 -->
	<div class="content1">
		<h5 class="text1">작성한 게시글</h5>

		<%
			//세션에 등록된 아이디를 이용해 사용자 정보 가져오기
		UserDTO findUser = new UserDTO(null, null, null, null, null, null, null, false, null);
		findUser.setId(id);
		UserDTO loginUser = null;
		if (HomeController.dao.getUserDAO().searchUserById(findUser).size() > 0) {
			loginUser = HomeController.dao.getUserDAO().searchUserById(findUser).get(0);
		}
		%>

		<table class="table table-bordered dataTable table-hover" id="dataTable" role="grid">

			<thead>
				<tr role="row">
					<th tabindex="0" rowspan="1" colspan="1" style="width: 65%">게시글</th>
					<th tabindex="0" rowspan="1" colspan="1" style="width: 15%">날짜</th>
					<th tabindex="0" rowspan="1" colspan="1" style="width: 20%">게시판</th>
				</tr>
			</thead>
			<tbody>
				<%//페이지 따라 출력
					List<PostDTO> posts = HomeController.dao.getPostDAO().searchMyPostsByUserId(id);
				for (int i=(curPage-1)*5; i<(curPage-1)*5+5;i++) {
					if(i==posts.size()){
						break;
					}
					PostDTO post = posts.get(i);
					GroupDTO group = HomeController.dao.getGroupDAO().searchGroupByGroupid(post.getGroupid());
				%>
				<tr style="width: 200px;" >
					<td>
					<%
						if(!(post.getGroupid()>0) && post.is_notice()){
							%>
							<a href="noticeContent?postid=<%=post.getPostid()%>"><%=post.getTitle()%></a>
							<%
						}else if(!(post.getGroupid()>0) && !post.is_notice()){
							%>
							<a href="postContent?postid=<%=post.getPostid()%>"><%=post.getTitle()%></a>
							<%
						}else if((post.getGroupid()>0) && post.is_notice()){
							%>
							<a href="groupNoticeContent?postid=<%=post.getPostid()%>"><%=post.getTitle()%></a>
							<%
						}else if((post.getGroupid()>0) && !post.is_notice()){
							%>
							<a href="groupPostContent?postid=<%=post.getPostid()%>"><%=post.getTitle()%></a>
							<%
						}
					%>
					</td>
					<td><%=post.getPostdate()%></td>
					<td>
					<%
						if(!(post.getGroupid()>0) && post.is_notice()){
							%>
							<a href="/notice">공지사항</a>
							<%
						}else if(!(post.getGroupid()>0) && !post.is_notice()){
							%>
							<a href="/freeBoard">자유게시판</a>
							<%
						}else if((post.getGroupid()>0) && post.is_notice()){
							%>
							<a href="groupnotice?groupid=<%=post.getGroupid()%>"><%=group.getName()%> - 공지사항</a>
							<%
						}else if((post.getGroupid()>0) && !post.is_notice()){
							%>
							<a href="groupQnA?groupid=<%=post.getGroupid()%>"><%=group.getName()%> - QnA</a>
							<%
						}
					
					%>
					</td>
				</tr>
				<%
					}
				%>


			</tbody>
		</table>
		<input type="hidden" id="curPage" value="<%=curPage%>"/>
		<input type="hidden" id="postSize" value="<%=posts.size() %>"/>
		<nav aria-label="Page navigation example">
  			<ul class="pagination justify-content-center" id="list-body">
    			<!-- 페이징 생성 -->
 			</ul>
		</nav>
	</div>

	<hr>

	<!-- 나의 댓글 -->
	<div class="content2">
		<h5 class="text1">작성한 댓글</h5>
				<table class="table table-bordered dataTable table-hover" id="dataTable" role="grid">

			<thead>
				<tr role="row">
					<th tabindex="0" rowspan="1" colspan="1" style="width: 65%">댓글</th>
					<th tabindex="0" rowspan="1" colspan="1" style="width: 15%">날짜</th>
					<th tabindex="0" rowspan="1" colspan="1" style="width: 20%">게시판</th>
				</tr>
			</thead>


			<tbody>


				<%
					List<CommentDTO> comments = HomeController.dao.getCommentDAO().searchMyCommentsByUserId(id);
				for (int i=(curPage_c-1)*5; i<(curPage_c-1)*5+5;i++) {
					//for (int i=(curPage-1)*3; i<(curPage-1)*3+3;i++) {
						//CommentDTO comment : comments for(int i=(page-1)*3; i<(page-1)*3+3;i++) PostDTO post = posts.get(i);
					if(i==comments.size()){
						break;
					}
					CommentDTO comment = comments.get(i);
				%>
				<tr style="width: 200px">
					<td>
						<%
						PostDTO commentpost = null;
						
						if (HomeController.dao.getPostDAO().searchByPostId(comment.getPostid()).size() > 0) {
							commentpost=HomeController.dao.getPostDAO().searchByPostId(comment.getPostid()).get(0);
						}
						GroupDTO group = HomeController.dao.getGroupDAO().searchGroupByGroupid(commentpost.getGroupid());
						
						if(!(commentpost.getGroupid()>0) && commentpost.is_notice()){
							%>
							<a href="noticeContent?postid=<%=commentpost.getPostid()%>"><%=comment.getContent()%></a>
							<%
						}else if(!(commentpost.getGroupid()>0) && !commentpost.is_notice()){
							%>
							<a href="postContent?postid=<%=commentpost.getPostid()%>"><%=comment.getContent()%></a>
							<%
						}else if((commentpost.getGroupid()>0) && commentpost.is_notice()){
							%>
							<a href="groupNoticeContent?postid=<%=commentpost.getPostid()%>"><%=comment.getContent()%></a>
							<%
						}else if((commentpost.getGroupid()>0) && !commentpost.is_notice()){
							%>
							<a href="groupPostContent?postid=<%=commentpost.getPostid()%>"><%=comment.getContent()%></a>
							<%
						}
						%>
					</td>
					<td><%=comment.getCommentdate() %></td>
					<td>
						<%
						if(!(commentpost.getGroupid()>0) && commentpost.is_notice()){
							%>
							<a href="/notice?page=1">공지사항</a>
							<%
						}else if(!(commentpost.getGroupid()>0) && !commentpost.is_notice()){
							%>
							<a href="/freeBoard?page=1">자유게시판</a>
							<%
						}else if((commentpost.getGroupid()>0) && commentpost.is_notice()){
							%>
							<a href="groupnotice?page=1&groupid=<%=commentpost.getGroupid()%>"><%=group.getName()%> - 공지사항</a>
							<%
						}else if((commentpost.getGroupid()>0) && !commentpost.is_notice()){
							%>
							<a href="groupQnA?page=1&groupid=<%=commentpost.getGroupid()%>"><%=group.getName()%> - QnA</a>
							<%
						}
						%>
					</td>
				</tr>
				<%
					}
				%>

			</tbody>
		</table>
		<input type="hidden" id="curPage_c" value="<%=curPage_c%>"/>
		<input type="hidden" id="commentSize" value="<%=comments.size() %>"/>
		<nav aria-label="Page navigation example">
  			<ul class="pagination justify-content-center" id="list-body_c">
    			<!-- 페이징 생성 -->
 			</ul>
		</nav>
	</div>
</div>

<%
	}
%>

<%@include file="/WEB-INF/views/menuPart2.jsp"%>
<script>
	//작성한 글 개수 가져오기
	var postData = document.getElementById("postSize").value;
	var curpage = document.getElementById("curPage").value;
	var commentData = document.getElementById("commentSize").value;
	var curpage_c = document.getElementById("curPage_c").value;
	$(document).ready(function () {
		paging(postData,curpage);//작성글수, 현재페이지 : activity?page=1??? getParameter
		paging_c(commentData,curpage_c)
	});

	function paging(totalData, currentPage){
		
		var dataPerPage = 5; //한 페이지에 보여지는 데이터 수
		var countPage = 5; //한번에 보여지는 페이지 수
		
		//총페이지수
		var totalPage = totalData / dataPerPage;
		if(totalData%dataPerPage>0){
			totalPage++;
		}
		
		//보여지는 페이지번호
		var startPage = Math.floor(((currentPage-1)/countPage))*countPage+1;//이유모르겠는디 오름으로 인식함->floor로 내림을 해줘야함,,,
		var endPage = startPage + countPage-1;
		if(endPage>totalPage){
			endPage = totalPage;
		}
		const prev = startPage-1;
		const next = endPage+1;
		
		$('#list-body').empty();
		if(startPage > countPage){
			$("#list-body").append("<li class='page-item'><a class='page-link' href='activity?page="+prev+ "&compage="+curpage_c+"'"+" aria-label='Next'><span aria-hidden='true'>&laquo;</span></a></li>");	
		}
		for(var j=startPage ; j<=endPage ; j++){
			if(currentPage==(j)){
				$("#list-body").append("<li class='page-item active'><a class='page-link' href='activity?page=" + j + "&compage="+curpage_c+"'>" + j + "</a></li>");
			}else if(j>0){
				$("#list-body").append("<li class='page-item'><a class='page-link' href='activity?page=" + j + "&compage="+curpage_c+ "'>" + j + "</a></li>");		
			}
		}
		if(next > 5 && next < totalPage)
		$("#list-body").append("<li class='page-item'><a class='page-link' href='activity?page="+next+ "&compage="+curpage_c+"'"+" aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>")
	} 
	
	function paging_c(totalData, currentPage){
		
		var dataPerPage = 5; //한 페이지에 보여지는 데이터 수
		var countPage = 5; //한번에 보여지는 페이지 수
		
		//총페이지수
		var totalPage = totalData / dataPerPage;
		if(totalData%dataPerPage>0){
			totalPage++;
		}
		
		//보여지는 페이지번호
		var startPage = Math.floor(((currentPage-1)/countPage))*countPage+1;//이유모르겠는디 오름으로 인식함->floor로 내림을 해줘야함,,,
		var endPage = startPage + countPage-1;
		if(endPage>totalPage){
			endPage = totalPage;
		}
		const prev = startPage-1;
		const next = endPage+1;
		
		$('#list-body_c').empty();
		if(startPage > countPage){
			$("#list-body_c").append("<li class='page-item'><a class='page-link' href='activity?page="+curpage+ "&compage="+prev+"'"+" aria-label='Next'><span aria-hidden='true'>&laquo;</span></a></li>");	
		}
		for(var j=startPage ; j<=endPage ; j++){
			if(currentPage==(j)){
				$("#list-body_c").append("<li class='page-item active'><a class='page-link' href='activity?page=" + curpage + "&compage="+ j +"'>" + j + "</a></li>");
			}else if(j>0){
				$("#list-body_c").append("<li class='page-item'><a class='page-link' href='activity?page=" + curpage + "&compage="+j+ "'>" + j + "</a></li>");		
			}
		}
		if(next > 5 && next < totalPage)
		$("#list-body_c").append("<li class='page-item'><a class='page-link' href='activity?page="+curpage+ "&compage="+next+"'"+" aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>")
	} 
</script>

</html>