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
	var isPwChecked = false;

	function changeImage() {
		alert("프로필 이미지 변경");
		//이미지 불러오기
	}

	//비밀번호 확인
	function chkPw() {
		var pw1 = document.getElementById("new_pw_text").value;
		var pw2 = document.getElementById("new_pw_chk_text").value;

		//나중에 유효성 검사 추가할 것 (영어, 숫자, 특수기호);
		if (pw1.length < 7)
			alert("비밀번호는 7글자 이상 작성해주세요");

		if (pw1 != pw2)
			alert("비밀번호를 다시 확인해주세요");
		else {
			alert("비밀번호 확인 완료");
			isPwChecked = true;
		}
	}

	//모든 조건을 만족했는지 확인 후 수정 완료
	function chkForm() {
		
		var form = document.changeForm;
		var nickname = document.getElementById("nickname_text").value; //닉네임
		var email = document.getElementById("email_text").value; //이메일

		if (isPwChecked == false) {
			alert("비밀번호 확인을 해주세요");
			return;
		}

		// var regExpNickname 닉네임 유효성 검사 추가할 것 (한글, 영어, 숫자 섞어서 2글자 이상)
		if (nickname.length < 2) {
			alert("닉네임은 2글자 이상 입력해주세요");
			return;
		}

		var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		if (!regExpEmail.test(email)) {
			alert("이메일 형식을 확인해주세요");
			return;
		}

		form.submit();
	}
</script>

</head>

<%@include file="menuPart1.jsp"%>

<%
	if (id == null) { //로그인 안된 상태면 로그인 페이지로 이동
	response.sendRedirect("loginPage?mode=nidLogin");
} else {
%>

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
		//세션에 등록된 아이디를 이용해 사용자 정보 가져오기
	UserDTO findUser = new UserDTO(null, null, null, null, null, null, null, false, null);
	findUser.setId(id);
	UserDTO loginUser = null;
	if (HomeController.dao.getUserDAO().searchUserById(findUser).size() > 0) {
		loginUser = HomeController.dao.getUserDAO().searchUserById(findUser).get(0);
	}
	%>

	<form action="processPersonalInfoChange" method="post" name="changeForm">
		<table class="table" style="width: 80%; margin: 0 auto;">
			<tr style="width: 50px">
				<td>이름</td>
				<td><input type="text" id="name_text"
					value=<%=loginUser.getName()%> disabled="true" style="width: 60%" /></td>
			</tr>
			<tr>
				<td>아이디</td>
				<td><input type="text" id="id_text" value="askges20"
					style="width: 60%" disabled="true" />
			</tr>
			<tr>
				<td>닉네임</td>
				<td><input type="text" id="nickname_text" name="new_nickname"
					value=<%=loginUser.getNickname()%> style="width: 60%" /></td>
			</tr>
			<tr>
				<td>변경할 비밀번호</td>
				<td><input type="password" id="new_pw_text" name="new_pw"
					style="width: 60%" /></td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td><input type="password" id="new_pw_chk_text"
					style="width: 60%" /> <input type="button" onClick="chkPw()"
					value="확인" class="btn btn-warning btn-sm" style="margin-left: 10px"></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" id="email_text" name="new_email"
					value=<%=loginUser.getEmail()%> style="width: 60%" />
			</tr>
			<tr>
				<td>소개글</td>
				<td><textarea id="intro_text" name="new_intro" rows="4"
						style="width: 80%"><%=loginUser.getIntro()%></textarea></td>
			</tr>
			<tr>
				<td></td>
				<td style="text-align: right;"><input type="button"
					onclick="chkForm()" value="완료" class="btn btn-primary"></td>
			</tr>
		</table>
	</form>
</div>

<%
	}
%>


<%@include file="menuPart2.jsp"%>