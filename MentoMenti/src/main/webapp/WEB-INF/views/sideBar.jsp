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
<body class="sticky-top">
	<input type="checkbox" id="check" checked="true">
	<label for="check"> <i class="fas fa-bars" id="btn"></i> <i
		class="fas fa-times" id="cancel"></i>
	</label>
	<div class="sidebar2">
		<header>MOCO</header>
		<ul class="navbar-nav sidebar accordion" id="accordionSidebar">
			<li><a href="#"><i class="fas fa-qrcode"></i>공지사항</a></li>
			<li><a href="#"><i class="fas fa-qrcode"></i>자유게시판</a></li>
			<li><a href="#"><i class="fas fa-qrcode"></i>그룹</a></li>
			<li><a href="#"><i class="fas fa-qrcode"></i>마이페이지</a></li>

			<li class="nav-item">
			<a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseTwo"
				aria-expanded="true" aria-controls="collapseTwo">
				<i class="fas fa-fw fa-cog"></i> <span>그룹</span>
			</a>
				<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
					data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<a class="collapse-item" href="buttons.html">개설된 그룹</a>
						<a class="collapse-item" href="cards.html">가입한 그룹</a>
					</div>
				</div></li>
		</ul>
	</div>
</body>
</html>