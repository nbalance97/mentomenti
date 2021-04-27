<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
<%@ page import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO" %>
<%@ page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<style>
.text1{ font-family: 'Source Code Pro', monospace;}
.text2{ font-family: 'Source Code Pro', monospace;}

h1.text1{
font-size:30px;
COLOR : #000000;
left : 200;
margin-bottom : 30;
position : relative;
text-align: center;
}

h1.text2{
font-size:30px;
COLOR : #000000;
left : 700;
top : -603;
margin-bottom : 30;
position : relative;
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
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>
</head>

<%@include file="menuPart1.jsp"%>




<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="text1">Mento Groups</h1>
</div>

<img src="resources/img/mento.png"
style = "display : block; margin-left : 160px; width : 250px;
height : 250px; position : relative;">

<%
	//세션에 등록된 아이디를 이용해 사용자 정보 가져오기
		UserDTO findUser = new UserDTO(null, null, null, null, null, null, null, false, null);
		findUser.setId(id);
		UserDTO loginUser = null;
		if (HomeController.dao.getUserDAO().searchUserById(findUser).size()>0){
			loginUser = HomeController.dao.getUserDAO().searchUserById(findUser).get(0);
		}
%>

<%
	//세션에 등록된 그룹을 이용해 사용자 정보 가져오기
		GroupDTO findGroup = new GroupDTO(0, null, null, 0, null, null);
		findGroup.setMaxperson(0);
		GroupDTO loginGroup = null;
		if (HomeController.dao.getGroupDAO().selectGroups().size()>0){
			loginGroup = HomeController.dao.getGroupDAO().selectGroups().get(0);
		}
%>
<table class="table table-bordered dataTable" id="dataTable"
	width="100%" cellspacing="0" role="grid"
	aria-describedby="dataTable_info"
	style="width: 350; background: white; position : relative; margin-top : 50px; margin-left : 55;text-align : center;">
	
		<thead>
		<tr role="row">
			<th tabindex="0" rowspan="1" colspan="1" style="width: 50%">그룹이름</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 50%;">멤버 수</th>

		</tr>
	</thead>
	
	
	<thead>

		<tr style="width: 200px">
			
			<%
			List<GroupDTO> mentoGroups = HomeController.dao.getGroupDAO().searchMentoGroupsByUserId(id);
			for(GroupDTO mg1: mentoGroups){
			%>
				<td>
				<a href="#" style="text-decoration: none;"><%=mg1.getName()%></a><br></td>
				<td>현재멤버수 / <%=loginGroup.getMaxperson() %></td>
			<%
				}
			%>
		
		</tr>

	</thead>
	
</table>


 <div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="text2">Menti Groups</h1>
</div>

<img src="resources/img/menti.png"
style = "display : block; margin-left :670px; width : 250px;
height : 250px; top : -600px; position : relative;">

<table class="table table-bordered dataTable" id="dataTable"
	width="100%" cellspacing="0" role="grid"
	aria-describedby="dataTable_info"
	style="width: 350; background: white; position : relative; top : -552; left : 610; text-align : center;">
	
		<thead>
		<tr role="row">
			<th tabindex="0" rowspan="1" colspan="1" style="width: 50%">그룹이름</th>
			<th tabindex="0" rowspan="1" colspan="1" style="width: 50%;">멘토 이름</th>

		</tr>
	</thead>
	
	
	<thead>

		<tr style="width: 200px">
<%
			List<GroupDTO> mentoGroups2 = HomeController.dao.getGroupmateDAO().searchMentoGroupsByUserId(id);
			for(GroupDTO mg2: mentoGroups2){
			%>
				<td>
				<a href="#" style="text-decoration: none;"><%=mg2.getId()%></a><br></td>
				<td>현재멤버수 / <%=loginGroup.getMaxperson() %></td>
			<%
				}
			%>
		</tr>

	</thead>
	
</table>




<%@include file="menuPart2.jsp"%>
</html>