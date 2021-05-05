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

<%@include file="menuPart1.jsp"%>

<%
	int groupid = Integer.parseInt(request.getParameter("groupid"));
	GroupDTO group = HomeController.dao.getGroupDAO().searchGroupByGroupid(groupid);
	List<GroupmateDTO> groupmateList = HomeController.dao.getGroupmateDAO().selectMentiList(group.getGroupid());
	
	//자신이 개설 or 가입한 그룹 페이지에만 접근할 수 있도록
	boolean isMember = false;
	if (group.getMentoid().equals((String)session.getAttribute("userID")))	
		isMember = true;
	for (GroupmateDTO gl: groupmateList){	//가입한 그룹인 경우
		if (gl.getId().equals((String)session.getAttribute("userID")))
			isMember = true;
	}
	if (!isMember){	//해당 그룹의 멤버가 아니라면 접근 거부
		response.sendRedirect("rejectedAccess?type=notMember");
	}
%>


<!-- 자유게시판 -->
<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">게시판</h1>
	<ul class="navbar-nav ml-auto">
		<li>
			<form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search"
				action="freeBoard" method="GET">
				<div class="input-group">
					<input type="text" class="form-control border-0 small" name="keyword"
						placeholder="검색" aria-label="Search" aria-describedby="basic-addon2">
					<div class="input-group-append">
						<button class="btn btn-primary" type="submit">
							<i class="fas fa-search fa-sm"></i>
						</button>
					</div>
				</div>
			</form>
		</li>
	</ul>
</div>



	<div class="content2">
		<h4 class="text1">Q & A</h4>
		<table class="table table-bordered" id="dataTable"
			cellspacing="0" role="grid" aria-describedby="dataTable_info"
			style="width: 80%; background: white; text-align: center; margin:0 auto;">
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
					List<PostDTO> groupPosts = HomeController.dao.getPostDAO().curGroupPosts(group.getGroupid());
					if (groupPosts.size() > 0){
						for(PostDTO gp: groupPosts) {
				%>
					<tr>
							<td>
				<!-- 제목 -->
				<a href="postContent?postid=<%=gp.getPostid()%>" style="text-decoration: none; color: gray"><%=gp.getTitle() %></a>
			</td>
					<td><%=gp.getUserid()%></td>
					<td><%=gp.getPostdate()%></td>
					<td><%=gp.getViewcount() %></td> <!-- 조회수 -->
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












<!-- 페이지 버튼 -->
<div class="d-flex align-items-center justify-content-between">
	<div style="margin: 0 auto;">
		<a href="#" class="btn-primary"
			style="width: 40px; height: 10px; font-size: 15px; padding: 5px; border-radius: 5px; text-decoration: none">
			<<</a>
		<%
			for (int j = 1; j <= 10; j++) {
		%>
		<a href="#" style="text-decoration: none"> <%
 	out.println(j);
 %></a>
		<%
			}
		%>
		<a href="#" class="btn-primary"
			style="width: 40px; height: 10px; font-size: 15px; padding: 5px; border-radius: 5px; text-decoration: none">
			>></a>
	</div>
	
	<%
		if (id != null){	//로그인 상태일 때
	%>

	<div class="d-sm-flex justify-content-between">
		<div style="margin: 0 auto; float: right">
			<a href="writePostPage" class="btn btn-secondary">작성</a>
		</div>
	</div>
	
	<%
		}
	%>
</div>

<%@include file="menuPart2.jsp"%>