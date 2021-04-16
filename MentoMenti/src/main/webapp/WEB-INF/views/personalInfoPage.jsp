<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
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

<!-- 마이페이지 중 회원 정보 확인 페이지 -->

<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">회원 정보 확인</h1>
</div>

<div style="text-align: center">
	<img src="resources/img/undraw_profile_1.svg"
		style="width: 150px; margin-bottom: 30px">

	<%
		//추후에 로그인 기능이 완성되면 해당 계정 정보를 불러오는 것으로 수정할 것
		UserDTO user = HomeController.dao.getUserDAO().selectUsers().get(0);
	%>

	<table class="table" style="width: 60%; margin: 0 auto;">
		<tr style="width: 50px">
			<td>이름</td>
			<td><%=user.getName() %></td>
		</tr>
		<tr style="width: 50px">
			<td>아이디</td>
			<td><%=user.getId() %></td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td><%=user.getNickname() %></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><%=user.getEmail() %></td>
		</tr>
		<tr>
			<td>생일</td>
			<td><%=user.getBirth() %></td>
		</tr>
		<tr>
			<td>소개글</td>
			<td><%=user.getIntro() %></td>
		</tr>
		<tr>
			<td>가입 일자</td>
			<td><%=user.getJoindate() %></td>
		</tr>
		<tr>
			<!-- 나중에 user, group DB 연결해서 가져올 것 -->
			<td>가입 그룹</td>
			<!-- 그룹 이름 클릭하면 해당 그룹 페이지로 이동할 예정 -->
			<td><a href="#" style="text-decoration: none;">가입 그룹은</a>, <a
				href="#" style="text-decoration: none;">아직 DB 연결 안함</a></td>
		</tr>
		<tr>
			<td></td>
			<td style="text-align: right;"><a href="#"
				class="btn btn-primary">수정</a></td>
		</tr>
	</table>
</div>

<%@include file="menuPart2.jsp"%>