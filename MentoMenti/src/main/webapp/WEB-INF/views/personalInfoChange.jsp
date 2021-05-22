<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

<script type="text/javascript">
	var isPwChecked = false;
	
	//비밀번호 확인
	function inputPwCheck(){
		isPwChecked = false;
	}
	
	function chkPw() {
		var pw1 = document.getElementById("new_pw_text").value;
		var pw2 = document.getElementById("pw_chk_text").value;
		var regPw = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{7,20}$/;
		
		if (pw1.length > 0) {	//비밀번호 변경 O
			if (pw1.length < 7 || pw1.length > 20)
				alert("비밀번호는 7~20글자 이내로 입력해주세요");
			else if(!regPw.test(pw1)){
				alert("비밀번호는 영문, 숫자, 특수문자의 조합이여야합니다.");
			}
			else if (pw1 != pw2)
				alert("변경할 비밀번호와 다릅니다. 다시 확인해주세요");
			else {
				alert("비밀번호 확인 완료");
				isPwChecked = true;
			}
		}
		//변경 안하는 경우에 alert 띄워야 할까..?	
	}

	//모든 조건을 만족했는지 확인 후 수정 완료
	function chkForm() {
		var pw1 = document.getElementById("new_pw_text").value;
		var pw2 = document.getElementById("pw_chk_text").value;
		
		var form = document.changeForm;
		var nickname = document.getElementById("nickname_text").value; //닉네임
		var email = document.getElementById("email_text").value; //이메일
		var origin = document.getElementById("originNickUser").value;

		if(nickname!=origin){
			if(form.NickDuplication.value != "NickCheck"){
				alert("닉네임 중복체크를 해주세요.");
				return false;
			}
		}
		
		if (pw1.length>0 || pw2.length>0){	//비번 변경 시
			if(isPwChecked == false) {
				alert("비밀번호 확인을 해주세요");
				return;
			}
		} else {	//비번 변경 x
			isPwChecked == true
		}

		var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		if (!regExpEmail.test(email)) {
			alert("이메일 형식을 확인해주세요");
			return;
		}

		form.submit();
	}
	
	function inputNickCheck(){
		var nickChk = document.getElementById('NickDuplication');
		nickChk.value = "NickUncheck";
	}
	
	function confirmNick(){
		var nick = document.getElementById('nickname_text');
		var originNick = document.getElementById('originNickUser');
		if(nick.value==""){
			alert("닉네임을 입력해주세요.");
			return false;
		}
		else if(nick.value.length>20 || nick.value.length < 2){
			alert("닉네임은 2~20글자 이내로 입력해주세요.");
			return false;
		}
		url = "confirmNick_ch?nickname="+nick.value+"&origin="+originNick.value;
		open(url,"confirm",
		"left=500, top=200, toolbar=no, location=no, status=no, menubar=no, scrollbars=no,resizable=no, width=300, height=200");
	}
</script>

<%@include file="menuPart1.jsp"%>

<%
	String isPwChecked = (String) session.getAttribute("pwChk");

	if (id == null) { //로그인 안된 상태면 로그인 페이지로 이동
	response.sendRedirect("loginPage?mode=nidLogin");
	} else if (isPwChecked == null) {	//비밀번호 확인울 거치지 않고 접근 (url 수정을 통해 접근한 경우)
		response.sendRedirect("rejectedAccess?type=pwNotChecked");
	}
	else {
%>

<!-- 회원 정보 수정 페이지 -->
<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">회원 정보 수정</h1>
</div>

<div style="text-align: center">


	<!-- 프로필 이미지 -->
	<%
	
	File pngImg = new File("src/main/resources/static/img/user/"+id+".png");
	File jpgImg = new File("src/main/resources/static/img/user/"+id+".jpg");
	
	if (pngImg.exists()) {
	%>
		<div class="profileImg rounded-circle"
		style="width: 200px; height:200px; margin:0 auto; margin-bottom: 30px;
		background-image:url('resources/img/user/<%=id%>.png')"></div>
	<%
	} else if (jpgImg.exists()){
	%>
		<div class="profileImg rounded-circle"
		style="width: 200px; height:200px; margin:0 auto; margin-bottom: 30px;
		background-image:url('resources/img/user/<%=id%>.jpg')"></div>
	<%
	} else {	//기본 이미지
	%>
		<div class="profileImg rounded-circle"
		style="width: 200px; height:200px; margin:0 auto; margin-bottom: 30px;
		background-image:url('resources/img/user/user.png')"></div>
	<%
		}
	%>
	
	
	
	<form action="processPersonalInfoChange?userid=<%=id%>" method="post" enctype="multipart/form-data" name="changeForm">
	<div style="margin-bottom:20px;">
		<!-- 프로필 사진 업로드 버튼 -->
		<label for="file" class="btn btn-success">프로필 등록</label>
		<input type="file" id="file" name="profileImg" style="display:none;">
		<p style="font-size:14px">※정사각형 이미지 권장
	</div>


	<%
		//세션에 등록된 아이디를 이용해 사용자 정보 가져오기
	UserDTO findUser = new UserDTO(null, null, null, null, null, null, null, false, null);
	findUser.setId(id);
	UserDTO loginUser = null;
	if (HomeController.dao.getUserDAO().searchUserById(findUser).size() > 0) {
		loginUser = HomeController.dao.getUserDAO().searchUserById(findUser).get(0);
	}
	%>
	
	
		<table class="table" style="width: 80%; margin: 0 auto;">
			<tr style="width: 50px">
				<td>이름</td>
				<td><input type="text" id="name_text"
					value=<%=loginUser.getName()%> disabled style="width: 60%" /></td>
			</tr>
			<tr>
				<td>아이디</td>
				<td><input type="text" id="id_text" value=<%=loginUser.getId() %>
					style="width: 60%" disabled />
			</tr>
			<tr>
				<td>닉네임</td>
				<td><input type="text" id="nickname_text" name="new_nickname" onkeydown="inputNickCheck()"
					value=<%=loginUser.getNickname()%> style="width: 60%" />
					<input type="button" onclick="confirmNick()"
					value="확인" class="btn btn-warning btn-sm" style="margin-left: 10px">
					<input type="hidden" id="NickDuplication" name="NickDuplication" value="NickUncheck">
					<%
						String searchNick = loginUser.getId();
						UserDTO user = new UserDTO(null, null, null, null, null, null, null, false, null);
						user.setId(searchNick);
						List<UserDTO> userAccount = HomeController.dao.getUserDAO().searchUserById(user);
						String originNick = userAccount.get(0).getNickname();
					%>
					<input type="hidden" id="originNickUser" name="originNickUser" value=<%=originNick%>>
					</td>
			</tr>
			<tr>
				<td>변경할 비밀번호</td>
				<td><input type="password" id="new_pw_text" name="new_pw" onkeydown="inputPwCheck()"
					style="width: 60%" /></td>
			</tr>
			<tr>
				<td>변경할 비밀번호 확인</td>
				<td><input type="password" id="pw_chk_text" onkeydown="inputPwCheck()"
					style="width: 60%" /> <input type="button" onClick="chkPw()"
					value="확인" class="btn btn-warning btn-sm" style="margin-left: 10px">
				</td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" id="email_text" name="new_email"
					value=<%=loginUser.getEmail()%> style="width: 60%" /></td>
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

<c:set var="cur_pw" value="<%=userAccount.get(0).getPw()%>"></c:set>

<%
	}
%>

<%@include file="menuPart2.jsp"%>