<!-- 수업 기능메뉴 -->
<!-- 멘토, 멘티따라 다른 기능메뉴 보여주기 & 실제기능추가필요(펜, 지우기, 음성, 화면공유, 실습하기, 나가기) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="resources/css/bootstrap.min.css" rel="stylesheet" />
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	*{
		box-sizing: border-box;
	}
	body{
		padding:10px;
		background:#89a7ff;
	}
	.function{
		width:100%;
		height:100px;
		background:white;
		padding:25px;
		clear: both;
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
</style>
</head>
<body>
	<div class="function img-rounded shadow">
		<ul>					
			<li><a href="#"><i class="fas fa-pencil-alt fa-3x"></i></a></li>
			<li><a href="#"><i class="fas fa-eraser fa-3x"></i></a></li>
			<li><a href="#"><i class="fas fa-microphone fa-3x"></i></a></li>
			<li><a href="#"><i class="fas fa-desktop fa-3x"></i></a></li>
			<li><a href="#"><i class="fas fa-exchange-alt fa-3x"></i></a></li>
			<li class="exit"><a href="#"><i class="fas fa-sign-out-alt fa-2x"></i></a></li>
		</ul>
	</div>
</body>
</html>