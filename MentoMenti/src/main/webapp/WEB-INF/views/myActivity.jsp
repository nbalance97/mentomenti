<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.PostDTO, Mento.Menti.Project.dao.PostDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.CommentDTO, Mento.Menti.Project.dao.CommentDAO"%>
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
	font-weight:700;
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

#wrapper{
	height:100%;
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

<%@include file="menuPart1.jsp"%>

<%
	if (id == null){	//로그인 안된 상태면 로그인 페이지로 이동
		response.sendRedirect("loginPage?mode=nidLogin");
	} else {
%>


<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4" id="pageHeading">
</div>
	
<div class="wrapContents">

	<!-- 나의 게시글 -->
	<div class="content1">
		<h4 class="text1">My Posts</h4>

		<%
			//세션에 등록된 아이디를 이용해 사용자 정보 가져오기
		UserDTO findUser = new UserDTO(null, null, null, null, null, null, null, false, null);
		findUser.setId(id);
		UserDTO loginUser = null;
		if (HomeController.dao.getUserDAO().searchUserById(findUser).size() > 0) {
			loginUser = HomeController.dao.getUserDAO().searchUserById(findUser).get(0);
		}
		%>

		<table class="table table-bordered dataTable" id="dataTable" role="grid">

			<thead>
				<tr role="row">
					<th tabindex="0" rowspan="1" colspan="1" style="width: 65%">게시글</th>
					<th tabindex="0" rowspan="1" colspan="1" style="width: 15%">날짜</th>
					<th tabindex="0" rowspan="1" colspan="1" style="width: 20%">게시판</th>
				</tr>
			</thead>
			<tbody>
				<%
					List<PostDTO> posts = HomeController.dao.getPostDAO().searchMyPostsByUserId(id);
				for (PostDTO post : posts) {
				%>
				<tr style="width: 200px">
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
						}//나중에 group대한 공지사항, QnA대한 내용 추가필요
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
						}//나중에 group대한 공지사항, QnA대한 내용 추가필요
					%>
					</td>
				</tr>
				<%
					}
				%>


			</tbody>

		</table>
		<nav aria-label="Page navigation example">
			<!--js이용필요
  			<ul class="pagination justify-content-center">
   			 	<li class="page-item disabled">
      				<a class="page-link" href="#" aria-label="Next">
        				<span aria-hidden="true">&laquo;</span>
      				</a>
    		 	</li>
    		 	
    			<li class="page-item"><a class="page-link" href="#">1</a></li>
    			<li class="page-item"><a class="page-link" href="#">2</a></li>
    			<li class="page-item"><a class="page-link" href="#">3</a></li>
    			
    			<li class="page-item">
     			    <a class="page-link" href="#" aria-label="Next">
        				<span aria-hidden="true">&raquo;</span>
      				</a>
    			</li>
 			</ul>
 			-->
		</nav>
	</div>

	<hr>

	<!-- 나의 댓글 -->
	<div class="content2">
		<h4 class="text1">My comments</h4>
				<table class="table table-bordered dataTable" id="dataTable" role="grid">

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
				for (CommentDTO comment : comments) {
				%>
				<tr style="width: 200px">
					<td>
						<%
						PostDTO commentpost = null;
						
						if (HomeController.dao.getPostDAO().searchByPostId(comment.getPostid()).size() > 0) {
							commentpost=HomeController.dao.getPostDAO().searchByPostId(comment.getPostid()).get(0);
						}
						
						if(!(commentpost.getGroupid()>0) && commentpost.is_notice()){
							%>
							<a href="noticeContent?postid=<%=commentpost.getPostid()%>"><%=comment.getContent()%></a>
							<%
						}else if(!(commentpost.getGroupid()>0) && !commentpost.is_notice()){
							%>
							<a href="postContent?postid=<%=commentpost.getPostid()%>"><%=comment.getContent()%></a>
							<%
						}//나중에 group대한 공지사항, QnA대한 내용 추가필요
						%>
					</td>
					<td><%=comment.getCommentdate() %></td>
					<td>
						<%
						if(!(commentpost.getGroupid()>0) && commentpost.is_notice()){
							%>
							<a href="/notice">공지사항</a>
							<%
						}else if(!(commentpost.getGroupid()>0) && !commentpost.is_notice()){
							%>
							<a href="/freeBoard">자유게시판</a>
							<%
						}//나중에 group대한 공지사항, QnA대한 내용 추가필요
						%>
					</td>
				</tr>
				<%
					}
				%>

			</tbody>
		</table>
	</div>
</div>

<%
	}
%>

<%@include file="menuPart2.jsp"%>
<script>
	function paging(totalData, currentPage){
		
		var dataPerPage = 3;
		var countPage = 5;
		
		//총페이지수
		var totalPage = totalData/dataPerPage;
		if(totalData%dataPerPage>0){
			totalPage++;
		}
		
		//보여지는 페이지번호
		var startPage = ((currentPage-1)/5)*5+1;
		var endPage = startPage + countPage-1;
		if(endPage>totalPage){
			endPage = totalPage;
		}
		
	}
</script>

</html>