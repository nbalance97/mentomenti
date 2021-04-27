<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.GroupmateDTO, Mento.Menti.Project.dao.GroupmateDAO"%>
<%@ page import="java.util.List"%>
<head>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap"
	rel="stylesheet">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<style>
.text1 {
	font-family: 'Nanum Gothic', sans-serif;
}

.text3 {
	font-family: 'Nanum Gothic', sans-serif;
}

.text4 {
	font-family: 'Nanum Gothic', sans-serif;
}

h1.text1 {
	font-size: 30px;
	COLOR: #5F5F5F;
	position: relative;
}

h1.text3 {
	font-size: 30px;
	COLOR: #5F5F5F;
}

h1.text4 {
	font-size: 30px;
	COLOR: #5F5F5F;
	position: relative;
	text-align: center;
	left: 100;
	top: -152;
}


/*수평 정렬*/
.wrapContents{
	overflow:hidden;
}

.content1{
	float:left;
	width:50%;
}
.content2{
	float:right;
	width:50%;
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
	<h1>~그룹</h1>
</div>

<div class="wrapContents" style="width: 100%">
	<!-- 가입멤버 -->
	<div class="content1">
		<h1 class="text1">가입멤버</h1>
		<!-- 리스트1 -->
		<table class="table table-bordered" id="dataTable"
			cellspacing="0" role="grid" aria-describedby="dataTable_info"
			style="width: 80%; background: white; text-align: center;">
			<thead>
				<tr role="row">
					<th tabindex="0" rowspan="1" colspan="1" style="width: 90px;">역할</th>
					<th tabindex="0" rowspan="1" colspan="1" style="width: 150px;">이름</th>
				</tr>
			</thead>
			<tbody>
				<tr>
				<%
					List<GroupmateDTO> groupmateList = HomeController.dao.getGroupmateDAO().selectMentiList(group.getGroupid());
					for(GroupmateDTO gl: groupmateList) {
				%>
					<td><%="?"%></td>
					<td></td>
				<%
					}
				%>
				</tr>
			</tbody>
		</table>
	</div>

	<!-- 공지사항 -->
	<div class="content2">
		<h1 class="text1">공지사항</h1>
	</div>
</div>


<div style="width: 100%">
	<div class="content1">
		<h1 class="text1">개설수업</h1>
		<form>
			<button type="submit" class="btn btn-primary"
				style="width: 40%; margin-bottom: 10px; margin-top: 20px">입장</button>
		</form>
		<form>
			<button type="submit" class="btn btn-info" style="width: 40%">개설</button>
		</form>
	</div>

	<div class="content2">
		<h1 class="text1">Q & A</h1>
	</div>
</div>

<%@include file="menuPart2.jsp"%>
</html>