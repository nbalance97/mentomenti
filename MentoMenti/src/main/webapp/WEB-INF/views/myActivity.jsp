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
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap"
	rel="stylesheet">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<style>
.text1 {
	font-family: 'Nanum Gothic', sans-serif;
}

.wrapContents {
	width:100%;
	overflow: hidden;
}

.content1 {
	margin-bottom: 50px;
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
					<th tabindex="0" rowspan="1" colspan="1" style="width: 85%">게시글 제목</th>
					<th tabindex="0" rowspan="1" colspan="1" style="width: 15%">이동</th>
				</tr>
			</thead>
			<thead>
				<%
					List<PostDTO> posts = HomeController.dao.getPostDAO().searchMyPostsByUserId(id);
				for (PostDTO post : posts) {
				%>
				<tr style="width: 200px">
					<td><%=post.getTitle()%></td>
					<td>
					<%
						if(!(post.getGroupid()>0) && post.is_notice()){
							%>
							<a href="noticeContent?postid=<%=post.getPostid()%>">이동</a>
							<%
						}else if(!(post.getGroupid()>0) && !post.is_notice()){
							%>
							<a href="postContent?postid=<%=post.getPostid()%>">이동</a>
							<%
						}//나중에 group대한 공지사항, QnA대한 내용 추가필요
					%>
					</td>
				</tr>
				<%
					}
				%>


			</thead>

		</table>
	</div>

	<hr>

	<!-- 나의 댓글 -->
	<div class="content2">
		<h4 class="text1">My comments</h4>
				<table class="table table-bordered dataTable" id="dataTable" role="grid">

			<thead>
				<tr role="row">
					<th tabindex="0" rowspan="1" colspan="1" style="width: 85%">댓글 내용</th>
					<th tabindex="0" rowspan="1" colspan="1" style="width: 15%">이동</th>
				</tr>
			</thead>


			<thead>


				<%
					List<CommentDTO> comments = HomeController.dao.getCommentDAO().searchMyCommentsByUserId(id);
				for (CommentDTO comment : comments) {
				%>
				<tr style="width: 200px">
					<td><%=comment.getContent()%><br></td>
					<td>
						<%
						PostDTO commentpost = null;
						List<PostDTO> commentposts = HomeController.dao.getPostDAO().searchByPostId(comment.getPostid());
						commentpost=commentposts.get(0);
						if(!(commentpost.getGroupid()>0) && commentpost.is_notice()){
							%>
							<a href="noticeContent?postid=<%=commentpost.getPostid()%>">이동</a>
							<%
						}else if(!(commentpost.getGroupid()>0) && !commentpost.is_notice()){
							%>
							<a href="postContent?postid=<%=commentpost.getPostid()%>">이동</a>
							<%
						}//나중에 group대한 공지사항, QnA대한 내용 추가필요
						%>
					</td>
				</tr>
				<%
					}
				%>

			</thead>
		</table>

	</div>
</div>

<%
	}
%>

<%@include file="menuPart2.jsp"%>
</html>