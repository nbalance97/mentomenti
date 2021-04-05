<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>MOCO</title>
    <link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    <link href="resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<%@include file="menuPart1.jsp" %>

<!-- 마이페이지 중 회원 정보 확인 페이지 -->

<div class="d-sm-flex align-items-center justify-content-between mb-4">
	<h1 class="h3 mb-0 text-gray-800">회원 정보 확인</h1>
</div>

<div style="text-align:center">
		<img src="img/undraw_profile_1.svg" style="width:150px; margin-bottom:30px">

	<table class="table" style="width:60%; margin:0 auto;">
		<tr style="width:50px"><td>이름</td><td>정예원</td></tr>
		<tr><td>닉네임</td><td>죠르디는커여워</td></tr> <!-- 닉네임제 유무 고민 -->
		<tr><td>소개글</td><td>컴공 4학년 재학 중</td></tr>
		<tr>
			<td>가입 그룹</td>
			<!-- 그룹 이름 클릭하면 해당 그룹 페이지로 이동할 예정 -->
			<td><a href="#" style="text-decoration:none;">자바를 자바</a>,
			<a href="#" style="text-decoration:none;">C언어 기초</a></td>
		</tr>
		<tr><td></td><td style="text-align:right;"><a href="#" class="btn btn-primary">수정</a></td></tr>
	</table>
</div>

<%@include file="menuPart2.jsp"%>