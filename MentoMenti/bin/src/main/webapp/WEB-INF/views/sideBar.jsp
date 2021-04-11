<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>MOCO</title>
<link href="resources/css/sidebar.css" rel="stylesheet" type="text/css">
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
</head>
<body>

	<input type="checkbox" id="check" checked="true"> <!-- 펼쳐진 상태가 디폴트 -->
	<label for="check">
		<i class="fas fa-bars" id="btn"></i> <!-- 펼치는 버튼 -->
		<i class="fas fa-times" id="cancel"></i> <!-- 접는 버튼 -->
	</label>
	
	
	<div class="sidebar2"> <!-- 사이드바 메뉴 -->
		<header>MOCO</header>
		<ul class="navbar-nav sidebar accordion" id="accordionSidebar">
			<li><a href="notice"><i class="fas fa-qrcode"></i>공지사항</a></li>
			<li><a href="freeBoard"><i class="fas fa-qrcode"></i>자유게시판</a></li>
			
			<li>
			<a class="collapsed" href="#"
				data-toggle="collapse" data-target="#collapseOne"
				aria-expanded="true" aria-controls="collapseOne">
				<i class="fas fa-qrcode"></i><span>그룹</span>
			</a>
				<div id="collapseOne" class="collapse" aria-labelledby="headingTwo"
					data-parent="#accordionSidebar">
					<div class="py-2 collapse-inner rounded">
						<a class="collapse-item" id="colItems" href="openedGroups">
						<i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>개설된 그룹</a>
						<a class="collapse-item" id="colItems" href="#">
						<i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>가입한 그룹</a>
					</div>
				</div></li>
		
			<li>
			<a class="collapsed" href="#"
				data-toggle="collapse" data-target="#collapseTwo"
				aria-expanded="true" aria-controls="collapseTwo">
				<i class="fas fa-qrcode"></i><span>마이페이지</span>
			</a>
				<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
					data-parent="#accordionSidebar">
					<div class="py-2 collapse-inner rounded">
						<a class="collapse-item" id="colItems" href="personalInfoPage">
						<i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>회원 정보 확인</a>
						<a class="collapse-item" id="colItems" href="personalInfoChange">
						<i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>회원 정보 수정</a>
					</div>
				</div></li>
		</ul>
	</div>
</body>
</html>