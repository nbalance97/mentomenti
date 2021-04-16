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

<!-- 회원 정보 수정 페이지 -->

<script type="text/javascript">
	function changeImage() {
		alert("프로필 이미지 변경");
		//이미지 불러오기
	}

	function chkNickname() {
		alert("닉네임 체크!");
		//닉네임 중복 체크 + 조건에 맞는지 확인
	}

	function chkPW() {
		alert("현재 비밀번호 체크!");
		//현재 비밀번호와 일치해야 수정 가능
	}

	function chkInput() {
		alert("회원 정보 수정!");
		//모든 조건을 만족했는지 확인 후 수정 완료
	}
</script>

</head>

<%@include file="menuPart1.jsp"%>

<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">회원 정보 수정</h1>
</div>

<div style="text-align: center">
	<p>
		<img src="resources/img/undraw_profile_1.svg" style="width: 150px;">
	</p>
	<p>
		<!-- 프로필 사진 업로드 버튼 -->
		<a href="#" onClick="changeImage()" class="btn btn-success"
			style="margin-bottom: 20px;">프로필 수정</a>
	</p>
	
	
	<%
		//추후에 로그인 기능이 완성되면 해당 계정 정보를 불러오는 것으로 수정할 것
		UserDTO user = HomeController.dao.getUserDAO().selectUsers().get(0);
	%>

	<table class="table" style="width: 80%; margin: 0 auto;">
		<tr style="width: 50px">
			<td>이름</td>
			<td><input type="text" id="name_text" value=<%=user.getName() %>
				disabled="true" style="width: 60%" /></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><input type="text" id="id_text" value="askges20"
				style="width: 60%" disabled="true" />
		</tr>
		<tr>
			<td>닉네임</td>
			<td><input type="text" id="nickname_text" value=<%=user.getNickname() %>
				style="width: 60%" /> <a href="#" onClick="chkNickname()"
				class="btn btn-danger btn-sm" id="nickname_btn"
				style="margin-left: 10px">중복 확인</a></td>
		</tr>
		<tr>
			<td>현재 비밀번호</td>
			<td><input type="password" id="pw_current_text"
				style="width: 60%" /> <a href="#" onClick="chkPW()"
				class="btn btn-warning btn-sm" style="margin-left: 10px">확인</a></td>
		</tr>
		<tr>
			<td>변경 비밀번호</td>
			<td><input type="password" id="pw_new_text" style="width: 60%" /></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><input type="text" id="email_text" value=<%=user.getEmail() %>
				style="width: 60%" />
		</tr>
		<tr>
			<td>소개글</td>
			<td><textarea id="intro_text" rows="4" style="width: 80%"><%=user.getIntro() %></textarea></td>
		</tr>
		<tr>
			<td></td>
			<td style="text-align: right;"><a href="#" onClick="chkInput()"
				class="btn btn-primary">완료</a></td>
		</tr>
	</table>
</div>

<%@include file="menuPart2.jsp"%>