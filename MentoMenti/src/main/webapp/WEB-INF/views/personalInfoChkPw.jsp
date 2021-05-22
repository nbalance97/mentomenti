<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
<%@ page import="Mento.Menti.Project.dto.GroupDTO, Mento.Menti.Project.dao.GroupDAO"%>
<%@ page import="java.util.List"%>
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

</head>

<%@include file="menuPart1.jsp"%>

<%
	String isPwChecked = (String) session.getAttribute("pwChk");
	if (id == null){	//로그인 안된 상태면 로그인 페이지로 이동
		response.sendRedirect("loginPage?mode=nidLogin");
	} else if (isPwChecked != null) {
		if (isPwChecked.equals("true"))	//이미 비밀번호 인증을 한 경우 -> 바로 수정 페이지로 이동
			response.sendRedirect("personalInfoChange");
	}
	else {
%>

<!-- 회원 정보 수정 페이지 이동 전 비밀번호 확인 페이지 -->

<div class="d-sm-flex align-items-center justify-content-between mb-4"
	id="pageHeading">
	<h1 class="h3 mb-0 text-gray-800">회원 정보 확인</h1>
</div>

<div style="text-align: center">
	<div style="width:80%; border:1px solid #e3e6f0; padding:50px; margin:0 auto;
			background-color:white; border-radius:15px">
		<h5 style="margin-bottom:30px; color:#858796">비밀번호 입력</h5>
		<form action="processChkPw" method="post">
			<p style="margin-bottom:30px;"><input type="password" id="input_pw" name="input_pw">
			<p><input type="submit" class="btn btn-warning" value="확인">
		</form>
	</div>
</div>
<%
	}
%>
<%@include file="menuPart2.jsp"%>