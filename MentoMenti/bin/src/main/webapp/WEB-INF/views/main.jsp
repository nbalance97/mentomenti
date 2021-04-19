<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Source+Code+Pro:wght@300&display=swap" rel="stylesheet">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<style>
.left1{ font-family: 'Source Code Pro', monospace;}
.center{ font-family: 'Source Code Pro', monospace;}
.right{ font-family: 'Source Code Pro', monospace;}
.left2{ font-family: 'Nanum Gothic', sans-serif;}


p.left1{
font-size:30px;
COLOR : BLACK;
position : relative;

top : 0;
margin-top : 50px;
}



p.left2{
font-size:20px;
COLOR : BLACK;
position : relative;
top : 0;
margin-bottom :100px;
}

p.center{
font-size:30px;
COLOR : BLACK;
position : relative;
left:620;
top: -210;
}
p.right{
font-size:30px;
COLOR : BLACK;
position : relative;
left:1240;
top: -294;
}


hr.hr1{
position : relative;
left:0;
}

hr.hr2{
position : relative;
left:620;
top:-208;
}

hr.hr3{
position : relative;
left:1240;
top:-292;
}

</style>
<link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">
<link href="resources/css/sidebar.css" rel="stylesheet" type="text/css">
<link href="resources/css/component.css" rel="stylesheet" type="text/css">

</head>
<%@include file="menuPart1.jsp"%>

<section></section>

<body>
	<div>
		<p class="left1">about MOCO</p>
			<hr class="hr1" width = "400px" color = "#D3D3D3">
		<p class="left2">프로그래밍 학습을 목표로 하는 웹 사이트 입니다.</p>
		</div>
	<div>
		<p class="left1">Notice</p>
			<hr class="hr1" width = "400px" color = "#D3D3D3">
		<p class="left2">db에서 받아와야됨</p>

		<p class="center">Board</p>
			<hr class="hr2" width = "400px" color = "#D3D3D3">
	</div>
	<div>
			<p class="right">Groups</p>
			<hr class="hr3" width = "400px" color = "#D3D3D3">
	
	</div>


<%@include file="menuPart2.jsp"%>
</body>
</html>