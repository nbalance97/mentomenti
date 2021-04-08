<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link href="/resources/css/bootstrap.min.css" rel="stylesheet" />
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	html,body{
		width:100%;
		height:100%;
		margin:0;
	}
	.main{
		width:100%;
		height:100%;
		text-align:center;
	}
	.screen{
		float:left;
		width:100%;
		height:90%;
		background:black;
	}
	.function{
		width:100%;
		height:10%;
		background:white;
		padding:20px;
		clear: both;
		background:#white;
	}
	ul{
		text-align:center;
	}
	li{
		margin-left:30px;
		display:inline-block;
	}
	.exit{
		float:right;
	}
	i{
		color:black;
	}
	div[class="sidebar"]{
		width:300px;
		height:100%;
		position:fixed;
		top:0;
		background:#000;
		left:-300px;
		z-index:100;
		transition:all .35s;
		opacity: 0.8;
	}
	input[id="menuicon"]:checked +label + div{
		left:0;
	}
	input[id="menuicon"] +label {
		display:block;
		width:30px;
		height:25px;
		top:20px;
		position:fixed;
		left:0;
		transition:all .35s;
		cursor:pointer;
	}
	input[id="menuicon"]:checked +label {
		z-index:2;
		left:300px;
	}
	input[id="menuicon"]{
		display:none;
	}
	input[id="menuicon"]+label span{
		display:block;
		position:absolute;
		width:100%;
		height:5px;
		border-radius:30px;
		background:#fff;
		transition:all .35s;
	}
	input[id="menuicon"] + label span:nth-child(1){
		top:0;
	}
	input[id="menuicon"] + label span:nth-child(2){
		top:50%;
		transform:translateY(-50%);
	}
	input[id="menuicon"] + label span:nth-child(3){
		bottom:0;
	}
	input[id="menuicon"]:checked + label span:nth-child(1){
		top:50%;
		transform:translateY(-50%) rotate(45deg);
	}
	input[id="menuicon"]:checked + label span:nth-child(2){
		opacity:0;
	}
	input[id="menuicon"]:checked + label span:nth-child(3){
		bottom:50%;
		transform:translateY(50%) rotate(-45deg);
	}
	.content{ 
		color:white;
	}
	.list, .chating{
		overflow:auto;
		height:50vh;
	}
	.list{
		text-align:left;
	}
	.stateIcon{
		color:white;
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