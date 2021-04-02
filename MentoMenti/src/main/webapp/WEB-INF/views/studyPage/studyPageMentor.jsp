<!-- 수업페이지-멘토 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="/resources/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<meta charset="UTF-8">
<title>MOCO-공부하기</title>
<style>
	*{
		box-sizing: border-box;
	}
	body{
		padding:10px;
		background:#89a7ff;
	}
	.shadow {
    	box-shadow: 0 .15rem 1.75rem 0 rgba(58,59,69,.15)!important;
	}
</style>
</head>
<body>
	<div>
	<!-- 화면공유  -->
	<%@ include file="studyPageScreen.jsp" %>
	<!-- 참여자 리스트 메뉴 -->
	<%@ include file="studyPageMenteeList.jsp" %>
	<!-- 채팅 기능 -->
	<%@ include file="studyPageChat.jsp" %>
	<!-- 수업페이지 기능모음 메뉴 -->
	<%@ include file="studyPageFunction.jsp" %>
	</div>
</body>
</html>