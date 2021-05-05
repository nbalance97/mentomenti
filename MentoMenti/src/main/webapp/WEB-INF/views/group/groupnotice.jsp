<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.PostDTO, Mento.Menti.Project.dao.PostDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupmateDTO, Mento.Menti.Project.dao.GroupmateDAO"%>
	
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

<%@include file="/WEB-INF/views/menuPart1.jsp"%>

<%
	int groupid = Integer.parseInt(request.getParameter("groupid"));
GroupDTO group = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid);
List<GroupmateDTO> groupmateList = HomeController.dao.getGroupmateDAO().selectMentiList(group.getGroupid());

//자신이 개설 or 가입한 그룹 페이지에만 접근할 수 있도록
boolean isMember = false;
if (group.getMentoid().equals((String) session.getAttribute("userID")))
	isMember = true;
for (GroupmateDTO gl : groupmateList) { //가입한 그룹인 경우
	if (gl.getId().equals((String) session.getAttribute("userID")))
		isMember = true;
}
if (!isMember) { //해당 그룹의 멤버가 아니라면 접근 거부
	response.sendRedirect("rejectedAccess?type=notMember");
}
%>


<!-- 공지사항 페이지 -->

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">그룹 공지사항</h1>
	<ul class="navbar-nav ml-auto">
		<li>
			<form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search"
				action="notice" method="GET">
				<div class="input-group">
					<input type="text" class="form-control border-0 small" name="keyword"
						placeholder="검색" aria-label="Search" aria-describedby="basic-addon2" id="searchText">
					<div class="input-group-append">
						<button class="btn btn-primary" type="submit">
							<i class="fas fa-search fa-sm"></i>
						</button>
					</div>
				</div>
				<!-- 그룹 아이디 넘기기 -->
				<input type="text" name="groupid" value=<%=groupid%> style="display:none;"/>
			</form>
		</li>
	</ul>
</div>
<p class="mb-4"><%=group.getName()%>
	그룹의 공지사항입니다.
</p>


<!-- 리스트 -->
<table class="table table-bordered dataTable" id="dataTable"
	width="100%" cellspacing="0" role="grid"
	aria-describedby="dataTable_info"
	style="width: 100%; background: white; text-align: center;">
	<thead>
		<tr role="row">
			<th tabindex="0" rowspan="1" colspan="1" style="width: 65%">제목</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 10%;">작성자</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 15%;">작성일자</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 10%;">조회수</th>
		</tr>
	</thead>
	
	<tbody>
		<%
			String kwd = request.getParameter("keyword");	//검색 키워드
			List<PostDTO> groupNotices = null;
			if (kwd == null) {	//검색x, 전체 공지
				groupNotices = HomeController.dao.getPostDAO().selectGroupNotices(group.getGroupid());
			} else{	//검색o
				//검색 기능 추가해야
			}
			
			if(groupNotices.size() > 0) {	//결과 있음
				for (PostDTO gn: groupNotices) {
		%>
		<tr role="row" class="odd">
			<td>
				<!-- 제목 -->
				<a href="groupNoticeContent?postid=<%=gn.getPostid()%>" style="text-decoration: none; color: gray"><%=gn.getTitle() %></a>
			</td>
			<td><%=gn.getUserid() %></td> <!-- 작성자 -->
			<td><%=gn.getPostdate()%></td> <!-- 작성일자 -->
			<td><%=gn.getViewcount() %></td> <!-- 조회수 -->
		</tr>
		<%
				}
			} else {	//결과 없음
		%>
		<tr style="height: 200px; line-height:200px;">
			<td colspan="4">게시물이 아직 없습니다</td>
		</tr>
		<%
			}
		%>
	</tbody>
</table>


<!-- 페이지 버튼 -->
<div class="d-flex align-items-center justify-content-between">
	<div style="margin: 0 auto;">
		<a href="#" class="btn-primary"
			style="width: 40px; height: 10px; font-size: 15px; padding: 5px; border-radius: 5px; text-decoration: none">
			<<</a>
		<%
			for (int j = 1; j <= 10; j++) {	//나중에 게시물 수에 따라 표시할 번호 다르게 해야함
		%>
		<a href="#" style="text-decoration: none"> <%
 	out.println(j);
 %>
		</a>
		<%
			}
		%>
		<a href="#" class="btn-primary"
			style="width: 40px; height: 10px; font-size: 15px; padding: 5px; border-radius: 5px; text-decoration: none">
			>></a>
	</div>


	<%
		if (group.getMentoid().equals(id))	//멘토인 경우에만 작성 버튼
	%>
	<div class="d-sm-flex justify-content-between">
		<div style="margin: 0 auto; float: right">
			<a href="writeGroupNoticePage?groupid=<%=groupid%>" class="btn btn-secondary">작성</a>
		</div>
	</div>
	

</div>

<%@include file="/WEB-INF/views/menuPart2.jsp"%>