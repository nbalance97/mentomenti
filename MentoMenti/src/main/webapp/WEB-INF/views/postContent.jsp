<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page import="Mento.Menti.Project.dto.PostDTO, Mento.Menti.Project.dao.PostDAO"%>
<%@ page import="Mento.Menti.Project.dto.CommentDTO, Mento.Menti.Project.dao.CommentDAO"%>
<%@ page import="java.util.List"%>

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>MOCO</title>

<link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<style>
	b{
		margin-right:5px
	}
	
	.comment_component{
		padding:5px 0px;
	}
</style>

<%@include file="menuPart1.jsp"%>

<!-- 공지사항 내용 페이지 -->

<%

	int postid = Integer.parseInt(request.getParameter("postid"));
	if (id != null){	//로그인 상태에서 게시물 조회 -> 조회수 증가
		HomeController.dao.getPostDAO().updateViewcount(postid);
	}
	List<PostDTO> postList = HomeController.dao.getPostDAO().searchByPostId(postid);	//게시물 번호로 찾은 게시물
	PostDTO post = postList.get(0);

%>

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4" id="pageHeading">
	<p><a href="main" style="text-decoration : none; color:gray">Home</a>
	> <a href="freeBoard" style="text-decoration : none; color:gray">자유게시판</a></p>
</div>



<table class="table table-bordered dataTable" width="100%"
	aria-describedby="dataTable_info" style="width: 100%; background: white;">
	<tbody>
		<tr>
			<th colspan="3" style="text-align:center;" id="title"><h4 style="padding:5px 0px"><%=post.getTitle()%></h4></th>
		</tr>
		<tr role="row">
			<td tabindex="0" rowspan="1" colspan="1" style="width: 35%"><b>작성자</b><%=post.getUserid()%></td>
			<td tabindex="0" rowspan="1" colspan="1" style="width: 45%;"><b>작성일자</b><%=post.getPostdate()%></td>
			<td tabindex="0" rowspan="1" colspan="1" style="width: 20%;"><b>조회수</b><%=post.getViewcount()%></td>
		</tr>
		<tr>
			<td colspan="3" style="padding:70px 20px"><%=post.getContent()%></td>
		</tr>
	</tbody>
</table>
	
<!-- 댓글 영역 -->
<div>
	<h5 style="margin-bottom:20px">댓글</h5>
	<div style="margin-bottom:20px">
		<form action="processAddComment?postid=<%=postid%>" method="post">
			<input type="text" style="width:90%; height:50px" name="comment" placeholder="댓글을 작성해주세요">
			<input type="submit" value="등록" class="btn btn-primary"/>
		</form>
	</div>
	<%
		List<CommentDTO> comments = HomeController.dao.getCommentDAO().selectComments(postid);
		for (CommentDTO c: comments){
	%>
	<div>
		<div class="comment_component">
			<img src="resources/img/user.png" style="width:20px; height:20px"/>
			<%=c.getWriterid()%>
		</div>
		<div class="comment_component"><%=c.getContent()%></div>
		<div class="comment_component" style="font-size:0.8em"><%=c.getCommentdate()%></div>
		<hr>
	</div>
	<%
		}
	%>
</div>


<%@include file="menuPart2.jsp"%>