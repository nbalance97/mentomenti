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
.text1 {
	font-family: 'Nanum Gothic', sans-serif;
	position: relative;
	margin-bottom:20px;
}

.text3 {
	font-family: 'Nanum Gothic', sans-serif;
}

.text4 {
	font-family: 'Nanum Gothic', sans-serif;
}

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
</style>



<title>MOCO</title>

<link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">
<link href="resources/css/sidebar.css" rel="stylesheet" type="text/css">
<link href="resources/css/component.css" rel="stylesheet"
	type="text/css">

</head>

<%@include file="menuPart1.jsp"%>


<%
	//나중에 특정 그룹 정보 불러오는 것으로 바꿀 것
	List<GroupDTO> groupList = HomeController.dao.getGroupDAO().selectGroups();
	GroupDTO group = groupList.get(0);	//임시로 첫번째 그룹으로 해둠
%>

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4" id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800"><%=group.getName() %></h1>
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
					List<GroupmateDTO> groupmateList = HomeController.dao.getGroupmateDAO().selectMentiList(group.getGroupid());
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
		<h4 class="text1">공지사항</h4>
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
					<td><%=gn.getTitle()%></td>
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
			<a href="studyPage/studyPageMentor">
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
		<h4 class="text1">Q & A</h4>
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
					<td><%=gp.getTitle()%></td>
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

<%@include file="menuPart2.jsp"%>
</html>