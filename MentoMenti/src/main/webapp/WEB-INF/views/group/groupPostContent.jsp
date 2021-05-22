<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page import="Mento.Menti.Project.dto.PostDTO, Mento.Menti.Project.dao.PostDAO"%>
<%@ page import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
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
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

</head>

<style>
	b{
		margin-right:5px
	}
	
	.comment_component{
		padding:5px 0px;
	}
</style>

<%@include file="/WEB-INF/views/menuPart1.jsp"%>

<% 
	pageContext.setAttribute("br", "<br/>");
	pageContext.setAttribute("cn", "\n");
%>

<!-- 공지사항 내용 페이지 -->

<%

	int postid = Integer.parseInt(request.getParameter("postid"));
	if (id != null){	//로그인 상태에서 게시물 조회 -> 조회수 증가
		HomeController.dao.getPostDAO().updateViewcount(postid);
	}
	List<PostDTO> postList = HomeController.dao.getPostDAO().searchByPostId(postid);	//게시물 번호로 찾은 게시물
	PostDTO post = postList.get(0);
	
	int groupid = post.getGroupid();
	String groupname = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid).getName();
%>

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4" id="pageHeading">
	<p><a href="main" style="text-decoration : none; color:gray">Home</a>
	> <a href="joininggroups" style="text-decoration : none; color:gray">가입한 그룹</a>
	> <a href="group?groupid=<%=groupid%>" style="text-decoration : none; color:gray"><%=groupname%></a>
	> <a href="groupQnA?groupid=<%=groupid%>" style="text-decoration : none; color:gray">그룹 Q&A</a></p>
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
			<td colspan="3" style="padding:70px 20px">
				<c:set var="content" value="<%=post.getContent()%>"/>
				${fn:replace(fn:escapeXml(content), cn, br)}
			</td>
		</tr>
	</tbody>
</table>


<!-- 자신이 작성한 글에는 삭제 버튼 있음 -->
<div style="text-align:right;">
<%
	if(post.getUserid().equals(id)){
%>
	<input type="button" class="btn btn-success modifyPost" value="수정"/>
	<input type="button" class="btn btn-danger deletePost" value="삭제"/>
<%
	}
%>
<input type="button" onclick="location.href='groupQnA?page=1&groupid=<%=groupid%>'" class="btn btn-info" value="목록"/>
</div>
	
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
			String commentId = c.getWriterid();
			String commentNick = HomeController.dao.getUserDAO().selectNicknameById(c.getWriterid());
			String userIntro = HomeController.dao.getUserDAO().selectIntroById(commentId);
	%>
	<div>
		<div class="comment_component nickname-tooltip">
				<!-- 댓글 프로필 이미지 -->
					<%
						File pngImg = new File("src/main/resources/static/img/user/"+commentId+".png");
						File jpgImg = new File("src/main/resources/static/img/user/"+commentId+".jpg");
						
						if (pngImg.exists()) {
					%>
						<img src="resources/img/user/<%=commentId%>.png" class="rounded-circle"
							style="width:30px; height:30px"/>
					<%
						} else if (jpgImg.exists()){
					%>
						<img src="resources/img/user/<%=commentId%>.jpg" class="rounded-circle"
							style="width:30px; height:30px"/>
					<%
						} else {
					%>
						<img src="resources/img/user/user.png" class="rounded-circle"
							style="width:30px; height:30px"/>
					<%
						}
					%>
					
					
				<!-- 댓글 작성자 아이디 -->
				<b><%=commentNick%></b>
				
				<!-- 댓글 작성자 프로필 (마우스 hover시 보임) -->
				<div class="tooltip-content">
					<div style="float:left;">
					<%
						if (pngImg.exists()) {
					%>
						<img src="resources/img/user/<%=commentId%>.png" class="rounded-circle"
							style="width:120px; height:120px"/>
					<%
						} else if (jpgImg.exists()){
					%>
						<img src="resources/img/user/<%=commentId%>.jpg" class="rounded-circle"
							style="width:120px; height:120px"/>
					<%
						} else {
					%>
						<img src="resources/img/user/user.png" class="rounded-circle"
							style="width:120px; height:120px"/>
					<%
						}
					%>
					</div>
					<div style="float:right; padding-top:10px">
					<p><b><%=commentNick%></b> (<%=commentId%>)</p>
					<p style="width:200px;"><%=userIntro%></p>
					</div>
				</div>
		</div>
		<div class="comment_component">
				<c:set var="comment" value="<%=c.getContent()%>"/>
				${fn:replace(fn:escapeXml(comment), cn, br)}
		</div>
		<div class="comment_component" style="font-size:0.8em; overflow:hidden;">
			<div style="float:left;"><%=c.getCommentdate()%></div>
			<% 
				if(c.getWriterid().equals(id)){	//자신이 작성한 댓글에는 삭제 버튼 표시
			%>
			<div style="text-align:right; float:right;">
				<input type="button" class="btn btn-danger deleteComment" value="삭제" id=<%=c.getCommentid()%>
					style="width:40px; height:30px; padding:0px; font-size:0.9em"/>
			</div>
			<%} %>
		</div>
		<hr>
	</div>
	<%
		}
	%>
</div>



<script type="text/javascript">
	$(document).ready(function(){
		$(".deletePost").on('click', function(){
		    if (confirm("게시물을 삭제하시겠습니까?")) {
		    	//댓글 번호, 게시물 번호 전달 (삭제 버튼 id가 댓글 번호로 설정되어 있음)
		    	location.href = "processDeletePost?postid="+<%=post.getPostid()%>;
		    }
		});
		
		$(".deleteComment").on('click', function(){
		    if (confirm("댓글을 삭제하시겠습니까?")) {
		    	//댓글 번호, 게시물 번호 전달 (삭제 버튼 id가 댓글 번호로 설정되어 있음)
		    	location.href = "processDeleteComment?commentid="+$(this).attr('id')+"&postid="+<%=post.getPostid()%>;
		    }
		});
		
		$(".modifyPost").on('click', function(){
		    location.href = "modifyGroupPostPage?postid="+<%=post.getPostid()%>;
		});
	});
</script>


<%@include file="/WEB-INF/views/menuPart2.jsp"%>