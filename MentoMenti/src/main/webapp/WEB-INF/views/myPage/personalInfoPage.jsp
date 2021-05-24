<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
<%@ page import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="org.springframework.core.io.ClassPathResource" %>
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
<script src="https://code.jquery.com/jquery-3.1.1.js"></script>

<style>
#personalInfoTable {
	width:60%;
}

@media screen and (max-width:970px){
	#personalInfoTable{
		width:90%;
	}
}
</style>

</head>

<%@include file="/WEB-INF/views/menuPart1.jsp"%>


<%
	if (id == null){	//로그인 안된 상태면 로그인 페이지로 이동
		response.sendRedirect("loginPage?mode=nidLogin");
	} else {
%>

<!-- 마이페이지 중 회원 정보 확인 페이지 -->

<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">회원 정보 확인</h1>
</div>

<div style="text-align: center">



	<!-- 프로필 이미지 -->
	<%
	//File pngImg = new File("src/main/resources/static/img/user/"+id+".png");
	//File jpgImg = new File("src/main/resources/static/img/user/"+id+".jpg");
	String uploadPath = new ClassPathResource("/static/img/user").getFile().getAbsolutePath();
	String pngImgPath = uploadPath + "\\" + id + ".png";
	String jpgImgPath = uploadPath + "\\" + id + ".jpg";
	File pngImg = new File(pngImgPath);
	File jpgImg = new File(jpgImgPath);
	
	if (pngImg.exists()) {
	%>
		<div class="profileImg rounded-circle" style="width:200px; height:200px; margin-bottom:30px;">
			<img src="resources/img/user/<%=id%>.png" style="width:100%; height:100%; object-fit: cover;">
		</div>
	<%
	} else if (jpgImg.exists()){
	%>
		<div class="profileImg rounded-circle" style="width:200px; height:200px; margin-bottom:30px;">
			<img src="resources/img/user/<%=id%>.jpg" style="width:100%; height:100%; object-fit: cover;">
		</div>
	<%
	} else {	//기본 이미지
	%>
		<div class="profileImg rounded-circle" style="width:200px; height:200px; margin-bottom:30px;">
			<img src="resources/img/user/user.png" style="width:100%; height:100%; object-fit: cover;">
		</div>
	<%
		}
	
		//세션에 등록된 아이디를 이용해 사용자 정보 가져오기
		UserDTO findUser = new UserDTO(null, null, null, null, null, null, null, false, null);
		findUser.setId(id);
		UserDTO loginUser = null;
		if (HomeController.dao.getUserDAO().searchUserById(findUser).size()>0){
			loginUser = HomeController.dao.getUserDAO().searchUserById(findUser).get(0);
		}
	%>

	<table class="table" id="personalInfoTable" style="margin: 0 auto;">
		<tr>
			<td style="width: 150px">이름</td>
			<td style="text-align:center;"><%=loginUser.getName() %></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td style="text-align:center;"><%=loginUser.getId() %></td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td style="text-align:center;"><%=loginUser.getNickname() %></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td style="text-align:center;"><%=loginUser.getEmail() %></td>
		</tr>
		<tr>
			<td>생일</td>
			<td style="text-align:center;"><%=loginUser.getBirth() %></td>
		</tr>
		<tr>
			<td>소개글</td>
			<td style="text-align:center;"><%=loginUser.getIntro() %></td>
		</tr>
		<tr>
			<td>가입 일자</td>
			<td style="text-align:center;"><%=loginUser.getJoindate() %></td>
		</tr>
		<tr>
			<td style="text-align: left;"><a href="javascript:void(0);" onclick="withdrawUser('<%=loginUser.getId()%>')" class="btn btn-danger">회원 탈퇴</a></td>
			<td style="text-align: right;"><a href="personalInfoChkPw" class="btn btn-primary">수정</a></td>
		</tr>
	</table>
</div>

<c:set var="cur_pw" value="<%=loginUser.getPw()%>"></c:set>

<%
	}
%>

<%@include file="/WEB-INF/views/menuPart2.jsp"%>

<script>
	function withdrawUser(userid){
		if (confirm("정말 탈퇴하시겠습니까?")){
			location.href="processDeleteUser?userid="+userid;
		}
	}
</script>