<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet" />
<link href="/resources/css/defaultStudyPractice.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>StudyPage_Mento</title>
<style>
	.screen{
		float:left;
		width:100%;
		height:90%;
		background:black;
	}
</style>
</head>
<body>
	<!-- 사이드바=채팅 & 멘티리스트 -->
	<%@include file="studySidebar.jsp"%>
	
	<div class="main">
		<!-- 화면공유  -->
		<%@include file="studyPageScreen.jsp"%>
		<!-- 수업페이지 기능모음 메뉴 -->
		<%@include file="studyPageFunction.jsp"%>
	</div>
</body>
</html>