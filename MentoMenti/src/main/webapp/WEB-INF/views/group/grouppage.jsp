<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupmateDTO, Mento.Menti.Project.dao.GroupmateDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.PostDTO, Mento.Menti.Project.dao.PostDAO"%>
<%@ page import="java.util.List"%>
<head>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<style>
/*수평 정렬*/
.wrapContents{
	overflow:hidden;
}

.content1{
	float:left;
	width:50%;
	margin-bottom:50px;
}

.content2{
	float:right;
	width:50%;
	margin-bottom:50px;
}

.text1{
	font-weight:300;
	margin-bottom:30px;
}

</style>


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
	int groupid = Integer.parseInt(request.getParameter("groupid"));
	GroupDTO group = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid);
	List<GroupmateDTO> groupmateList = HomeController.dao.getGroupmateDAO().selectMentiList(group.getGroupid());	//그룹에 참여한 멘티 목록
	
	//자신이 개설 or 가입한 그룹 페이지에만 접근할 수 있도록
	boolean isMember = false;
	if (group.getMentoid().equals((String)session.getAttribute("userID")))	//개설한 그룹인 경우
		isMember = true;
	for (GroupmateDTO gl: groupmateList){	//가입한 그룹인 경우
		if (gl.getId().equals((String)session.getAttribute("userID")))
			isMember = true;
	}
	if (!isMember){	//해당 그룹의 멤버가 아니라면 접근 거부
		response.sendRedirect("rejectedAccess?type=notMember");
	}
%>


<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4" style="overflow:hidden;" id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800" style="float:left"><%=group.getName() %></h1>
	<%
		if (group.getMentoid().equals(id)){	//멘토는 자신의 그룹을 해체할 수 있음
	%>
	<input type="button" class="btn btn-warning deleteGroup" value="그룹 해체하기"
		style="float:right; font-size:14px; padding:3px; background:#BDBDBD; border:1px solid #BDBDBD"/>
	<%
		} else { //멘티는 그룹에서 탈퇴할 수 있음
	%>
	<input type="button" class="btn btn-warning leaveGroup" value="그룹 탈퇴하기"
		style="float:right; font-size:14px; padding:3px; background:#BDBDBD; border:1px solid #BDBDBD"/>
	<%
		}
	%>
</div>
<hr>

<div class="wrapContents" style="width: 100%">
	<!-- 가입멤버 -->
	<div class="content1">
		<h4 class="text1">가입멤버</h4>
		<table class="table table-bordered" id="dataTable"
			cellspacing="0" role="grid" aria-describedby="dataTable_info"
			style="width: 80%; background: white; text-align: center; margin:0 auto;">
			<thead>
				<tr role="row">
					<th tabindex="0" rowspan="1" colspan="1" style="width: 90px;">역할</th>
					<th tabindex="0" rowspan="1" colspan="1" style="width: 150px;">이름</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>멘토</td>
					<td><%=group.getMentoid()%></td>
				</tr>
				<%
					for(GroupmateDTO gl: groupmateList) {
				%>
					<tr>
					<td>멘티</td>
					<td><%=gl.getId()%></td>
					</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>

	<!-- 공지사항 -->
	<div class="content2">
		<div style="overflow:hidden;">
			<h4 class="text1" style="float:left;">공지사항</h4>
			<span style="float:right;"><a href="groupnotice?groupid=<%=groupid%>" style="text-decoration:none; color:gray">더보기>></a></span>
		</div>
		<table class="table table-bordered" id="dataTable"
			cellspacing="0" role="grid" aria-describedby="dataTable_info"
			style="width: 80%; background: white; text-align: center; margin:0 auto;">
			<thead>
				<tr role="row">
					<th tabindex="0" rowspan="1" colspan="1" style="width:50%">제목</th>
					<th tabindex="0" rowspan="1" colspan="1" style="width:50%">작성일자</th>
				</tr>
			</thead>
			<tbody>
				<%
					List<PostDTO> groupNotices = HomeController.dao.getPostDAO().curGroupNotices(group.getGroupid());
					if (groupNotices.size() > 0) {
						for(PostDTO gn: groupNotices) {
				%>
					<tr>
					<td><a href="groupNoticeContent?postid=<%=gn.getPostid()%>" style="text-decoration:none;"><%=gn.getTitle()%></a></td>
					<td><%=gn.getPostdate()%></td>
					</tr>
				<%
						}
					} else {
				%>
					<tr style="height:100px">
					<td colspan="2">게시물이 아직 없습니다</td>
					</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>
</div>


<div style="width: 100%">
	<div class="content1">
		<h4 class="text1">개설수업</h4>
		<div style="text-align:center; height:200px;">
		
		<form>
			<a href="studyPage/studyPageMentor?groupid=<%=group.getGroupid()%>">
			<input type="button" class="btn btn-primary"
				style="width: 40%; margin-bottom: 10px; margin-top: 20px" value="입장">
			</a>
		</form>
		
		<form>
			<input type="button" class="btn btn-info" style="width: 40%" value="개설">
		</form>
		</div>
	</div>

	<div class="content2">
		<div style="overflow:hidden;">
			<h4 class="text1" style="float:left;">Q & A</h4>
			<span style="float:right;"><a href="groupQnA?groupid=<%=groupid%>" style="text-decoration:none; color:gray">더보기>></a></span>
		</div>
		<table class="table table-bordered" id="dataTable"
			cellspacing="0" role="grid" aria-describedby="dataTable_info"
			style="width: 80%; background: white; text-align: center; margin:0 auto;">
			<thead>
				<tr role="row">
					<th tabindex="0" rowspan="1" colspan="1" style="width:50%">제목</th>
					<th tabindex="0" rowspan="1" colspan="1" style="width:50%">작성일자</th>
				</tr>
			</thead>
			<tbody>
				<%
					List<PostDTO> groupPosts = HomeController.dao.getPostDAO().curGroupPosts(group.getGroupid());
					if (groupPosts.size() > 0){
						for(PostDTO gp: groupPosts) {
				%>
					<tr>
					<td><a href="groupPostContent?postid=<%=gp.getPostid()%>" style="text-decoration:none;"><%=gp.getTitle()%></a></td>
					<td><%=gp.getPostdate()%></td>
					</tr>
				<%
						}
					} else {
				%>
					<tr style="height:100px">
					<td colspan="2">게시물이 아직 없습니다</td>
					</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		$(".deleteGroup").on('click', function(){
		    if (confirm("그룹을 해체하시겠습니까? (해체한 그룹은 되돌릴 수 없습니다.)")) {
		    	//그룹 번호 전달
		    	location.href = "processDeleteGroup?groupid="+<%=group.getGroupid()%>;
		    }
		});
		
		$(".leaveGroup").on('click', function(){
		    if (confirm("그룹에서 탈퇴하시겠습니까?")) {
		    	//그룹 번호 전달
		    	location.href = "processLeaveGroup?groupid="+<%=group.getGroupid()%>;
		    }
		});
	});
</script>

<%@include file="/WEB-INF/views/menuPart2.jsp"%>
</html>