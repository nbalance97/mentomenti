<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>MOCO</title>

<link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">
<link href="resources/css/sidebar.css" rel="stylesheet" type="text/css">
<link href="resources/css/component.css" rel="stylesheet" type="text/css">

</head>

<%@include file="menuPart1.jsp"%>

<!-- 공지사항 페이지 -->

<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4" id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">공지사항</h1>
	<ul class="navbar-nav ml-auto">
		<li>
			<form>
				<div class="input-group" style="z-index: 0">
					<input type="text" class="form-control border-0 small"
						placeholder="검색" aria-label="Search"
						aria-describedby="basic-addon2">
					<div class="input-group-append">
						<button class="btn" type="button" style="background: black">
							<i class="fas fa-search fa-sm"></i>
						</button>
					</div>
				</div>
			</form>
		</li>
	</ul>
</div>
<p class="mb-4">모두의 코딩교실의 공지사항입니다.</p>

<!-- 리스트 -->
<table class="table table-bordered dataTable" id="dataTable"
	width="100%" cellspacing="0" role="grid"
	aria-describedby="dataTable_info"
	style="width: 100%; background: white; text-align: center;">
	<thead>
		<tr role="row">
			<th tabindex="0" rowspan="1" colspan="1" style="width: 100px;">No.</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 61px;">제목</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 49px;">작성자</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 31px;">조회수</th>
		</tr>
	</thead>
	<tbody>
		<%
			for (int i = 0; i < 15; i++) {
		%>
		<tr role="row" class="odd">
			<td class="">1</td>
			<td>모코 사이트 이용 방법 안내</td>
			<td>정예원</td>
			<td>62</td>
		</tr>
		<%
			}
		%>
	</tbody>
</table>

<!-- 페이지 버튼 -->
<div class="d-flex align-items-center justify-content-between">
	<div style="margin: 0 auto;">
		<a href="#" class="btn-primary pageButton">
		<<</a>
		<%
			for (int j = 1; j <= 10; j++) {
		%>
		<a href="#" style="text-decoration: none; color:gray"> <%
 	out.println(j);
 %>
		</a>
		<%
			}
		%>
		<a href="#" class="btn-primary pageButton">
		>></a>
	</div>

	<div class="d-sm-flex justify-content-between">
		<div style="margin: 0 auto; float: right">
			<a href="#" class="btn btn-primary">작성</a>
		</div>
	</div>
</div>
<%@include file="menuPart2.jsp"%>
</html>