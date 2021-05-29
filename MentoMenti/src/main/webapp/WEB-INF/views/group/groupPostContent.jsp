<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page import="Mento.Menti.Project.dto.PostDTO, Mento.Menti.Project.dao.PostDAO"%>
<%@ page import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page import="Mento.Menti.Project.dto.CommentDTO, Mento.Menti.Project.dao.CommentDAO"%>
<%@ page import="Mento.Menti.Project.dto.GroupmateDTO, Mento.Menti.Project.dao.GroupmateDAO"%>
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

<!-- Q&A 내용 페이지 -->

<%

	int postid = Integer.parseInt(request.getParameter("postid"));
	if (id != null){	//로그인 상태에서 게시물 조회 -> 조회수 증가
		HomeController.dao.getPostDAO().updateViewcount(postid);
	}
	List<PostDTO> postList = HomeController.dao.getPostDAO().searchByPostId(postid);	//게시물 번호로 찾은 게시물
	PostDTO post = postList.get(0);
	String pWriterNick = HomeController.dao.getUserDAO().selectNicknameById(post.getUserid());	//작성자 아이디
	int cntComment = HomeController.dao.getCommentDAO().countComment(post.getPostid());

	int groupid = post.getGroupid();
	GroupDTO group = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid);
	String groupname = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid).getName();
	List<GroupmateDTO> groupmateList = HomeController.dao.getGroupmateDAO().selectMentiList(group.getGroupid());	//그룹에 참여한 멘티 목록
	
	
	UserDTO user = new UserDTO();
	user.setId(id);
	boolean isAdmin = HomeController.dao.getUserDAO().searchUserById(user).get(0).is_admin();
	
	//자신이 개설 or 가입한 그룹 페이지에만 접근할 수 있도록
	boolean isMember = false;
	if (group.getMentoid().equals((String)session.getAttribute("userID")))	//개설한 그룹인 경우
		isMember = true;
	for (GroupmateDTO gl: groupmateList){	//가입한 그룹인 경우
		if (gl.getId().equals((String)session.getAttribute("userID")))
			isMember = true;
	}
	if (!isMember && !isAdmin){	//관리자x && 해당 그룹의 멤버가 아니라면 접근 거부
		response.sendRedirect("rejectedAccess?type=notMember");
	}
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
			<td tabindex="0" rowspan="1" colspan="1" style="width: 35%"><b>작성자</b><%=pWriterNick%></td>
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
	<h5 style="margin-bottom:20px">
		답변
		<%
			if(cntComment > 0){
		%>
		<span class="font-weight-500" style="color:#3162C7; margin:0px 3px"><%=cntComment%></span>
		<%
			}
		%>
	</h5>
	
	<!-- 댓글 입력 부분 -->
	<div id="comment-box">
		<form action="processAddComment?postid=<%=postid%>" method="post" name="commentForm">
			<textarea id="comment-input" name="comment" placeholder="댓글을 작성해주세요"></textarea>
			<div id="comment-bottom">
				<input type="button" value="등록" id="comment-button" onclick="addComment()"/>
				<div style="float:right; line-height:40px; margin-right:10px">(<strong id="comment-len">0</strong><span>/200자</span>)</div>
			</div>
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
					File pngImg = new File("/root/user/"+commentId+".png");
					File jpgImg = new File("/root/user/"+commentId+".jpg");
						
						if (pngImg.exists()) {
					%>
						<div class="profileImg rounded-circle" style="width:30px; height:30px; float:left; margin-right:10px">
							<img src="https://kgu.mentomenti.kro.kr/upload/<%=commentId%>.png" style="width:100%; height:100%; object-fit: cover;">
						</div>
					<%
						} else if (jpgImg.exists()){
					%>
						<div class="profileImg rounded-circle" style="width:30px; height:30px; float:left; margin-right:10px">
							<img src="https://kgu.mentomenti.kro.kr/upload/<%=commentId%>.jpg" style="width:100%; height:100%; object-fit: cover;">
						</div>
					<%
						} else {
					%>
						<div class="profileImg rounded-circle" style="width:30px; height:30px; float:left; margin-right:10px">
							<img src="resources/img/user/user.png" style="width:100%; height:100%; object-fit: cover;">
						</div>
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
						<div class="profileImg rounded-circle" style="width:120px; height:120px;">
							<img src="https://kgu.mentomenti.kro.kr/upload/<%=commentId%>.png" style="width:100%; height:100%; object-fit: cover;">
						</div>
					<%
						} else if (jpgImg.exists()){
					%>
						<div class="profileImg rounded-circle" style="width:120px; height:120px;">
							<img src="https://kgu.mentomenti.kro.kr/upload/<%=commentId%>.jpg" style="width:100%; height:100%; object-fit: cover;">
						</div>
					<%
						} else {
					%>
						<div class="profileImg rounded-circle" style="width:120px; height:120px;">
							<img src="resources/img/user/user.png" style="width:100%; height:100%; object-fit: cover;">
						</div>
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
	function addComment(){
		var form = document.commentForm;
		var content = document.getElementById("comment-input").value;
		
		if(content.length == 0){
			alert("댓글 내용을 작성해주세요");
			return;
		}
		
		if(content.length > 200){
			alert("댓글은 200자 이하로 작성해주세요");
			return;
		}
		
		if(content.indexOf('\n') != -1){
			alert("댓글에 엔터를 입력할 수 없습니다.");
			return;
		}
		
		form.submit();
	}

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
	
	//댓글 입력할 때마다 글자 수 실시간 반영
    (function (window, $, undefined) {
    	//글자수 셀 대상, 글자수 표시 text
        var $comment_text = $('#comment-input'), $comment_len = $('#comment-len');

      	//실시간 글자수 세기
        $comment_text.keyup(function () {
            chkIntroLength(this);
        });
      
        function chkIntroLength(objMsg) { //소개글 길이 계산
            var pattern = /\r\n/gm;
            var vacuum_text;
            var vacuum_length;

            vacuum_text = $(objMsg).val();
            vacuum_length = lengthMsg($(objMsg).val());
            vacuum_text = vacuum_text.replace(pattern, '\n');
            $comment_len.html(vacuum_text.length);//현재 글자수 반영
        }
        
        //텍스트 길이 계산
        function lengthMsg(obj_msg) {
            var nbytes = 0;
            var i;
            for (i = 0; i < obj_msg.length; i++) {
                var ch = obj_msg.charAt(i);
                if (encodeURIComponent(ch).length > 4) { // 한글일 경우
                    nbytes += 2;
                } else if (ch === '\n') { // 줄바꿈일 경우
                    if (obj_msg.charAt(i - 1) !== '\r') { // 하지만 밀려서 줄이 바뀐경우가 아닐때
                        nbytes += 1;
                    }
                } else { //나머지는 모두 1byte
                    nbytes += 1;
                }
            }
            return nbytes;
        }
    })(window, jQuery, undefined);
</script>


<%@include file="/WEB-INF/views/menuPart2.jsp"%>