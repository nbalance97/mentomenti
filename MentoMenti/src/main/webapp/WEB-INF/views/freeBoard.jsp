<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.PostDTO, Mento.Menti.Project.dao.PostDAO"%>
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

<!-- 자유게시판 -->
<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">게시판</h1>
	<ul class="navbar-nav ml-auto">
		<li>
			<form
				class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
				<div class="input-group">
					<input type="text" class="form-control border-0 small"
						placeholder="검색" aria-label="Search"
						aria-describedby="basic-addon2">
					<div class="input-group-append">
						<button class="btn btn-primary" type="button">
							<i class="fas fa-search fa-sm"></i>
						</button>
					</div>
				</div>
			</form>
		</li>
	</ul>
</div>
<p class="mb-4">자유롭게 글을 작성할 수 있는 게시판입니다.</p>

<!-- 리스트 -->
<table class="table table-bordered dataTable" id="dataTable"
	width="100%" cellspacing="0" role="grid"
	aria-describedby="dataTable_info"
	style="width: 100%; background: white; text-align: center;">
	<thead>
		<tr role="row">
			<th tabindex="0" rowspan="1" colspan="1" style="width: 10%;">No.</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 60%">제목</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 20%;">작성자</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 10%;">조회수</th>
		</tr>
	</thead>
	<tbody>
		<%
			//Post DB에서 내용 가져오기
		List<PostDTO> generalPosts = HomeController.dao.getPostDAO().selectGeneralPosts();
		for (PostDTO gp : generalPosts) {
		%>
		<tr role="row" class="odd">
			<td class=""><%=gp.getPostid()%></td>
			<!-- 게시물 번호 -->
			<td>
				<!-- 제목 --> <a href="#" style="text-decoration: none; color: gray"><%=gp.getTitle()%></a>
			</td>
			<td><%=gp.getUserid()%></td>
			<!-- 작성자, 현재는 id가 출력되도록. 나중에 닉네임으로 바꿀듯 -->
			<td><%=gp.getViewcount()%></td>
			<!-- 조회수 -->
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

	<div class="d-sm-flex justify-content-between">
		<div style="margin: 0 auto; float: right">
			<a href="#" class="btn btn-secondary">작성</a>
		</div>
	</div>
</div>

<%@include file="menuPart2.jsp"%>