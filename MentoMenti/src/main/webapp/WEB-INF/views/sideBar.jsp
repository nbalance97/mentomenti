<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>MOCO</title>
<link href="resources/css/basic.css" rel="stylesheet" type="text/css">	<!-- 기본 css -->
<link href="resources/css/comment.css" rel="stylesheet" type="text/css">	<!-- 댓글 css -->
<link href="resources/css/profile-tooltip.css" rel="stylesheet" type="text/css">
<link href="resources/css/sidebar.css" rel="stylesheet" type="text/css" media="screen and (min-width:1000px)"> <!-- PC 환경 사이드바 css -->
<link href="resources/css/sidebar_phone.css" rel="stylesheet" type="text/css" media="screen and (max-width:999px)">	<!-- 모바일 환경 사이드바 CSS -->
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
</head>

<style>
	.sidebar-icon{
		width:15px;
		margin-right:8px;
	}
</style>

<script>
	window.onload=function(){
		var chkBtn = document.getElementById('check');
		var sideBar = document.getElementsByClassName('sidebar2');
		
		if(matchMedia("screen and (min-width:1000px)").matches){	//PC 환경
			chkBtn.checked = true;
			sideBar.display='block';
		} else {	//모바일, 태블릿
			chkBtn.checked = false;
			sideBar.display='none';
		}
	};
</script>

<body>

	<input type="checkbox" id="check" checked>
	<label for="check">
		<i id="btn"><img src="resources/img/menu/menu_show_btn.png" width="35px"></i> <!-- 펼치는 버튼 -->
		<i id="cancel"><img src="resources/img/menu/menu_close_btn.png" width="30px"></i> <!-- 접는 버튼 -->
	</label>


	<div class="sidebar2" style="background: #002266">
		<!-- 사이드바 메뉴 -->
		<header class="font-weight-700" style="background: #002266">
			<a href="main" class="sideLogo" style="text-decoration:none;">MOCO</a>
		</header>
		<ul class="navbar-nav sidebar accordion" id="accordionSidebar">
			<li>
				<a href="notice">
					<img src="resources/img/menu/공지.png" class="sidebar-icon">
					<span class="sidebar-component">공지사항</span>
				</a>
			</li>
			<li>
				<a href="freeBoard">
					<img src="resources/img/menu/자유게시판.png" class="sidebar-icon">
					<span class="sidebar-component">자유게시판</span>
				</a>
			</li>

			<li>
				<a class="collapsed" href="#" data-toggle="collapse"
					data-target="#collapseOne" aria-expanded="true"
					aria-controls="collapseOne">
					<img src="resources/img/그룹.png" class="sidebar-icon">
					<span class="sidebar-component">그룹</span>
				</a>
				<div id="collapseOne" class="collapse" aria-labelledby="headingTwo"
					data-parent="#accordionSidebar">
					<div class="py-2 collapse-inner rounded">
						<a class="collapse-item" id="colItems" href="openedGroups">
							<img src="resources/img/menu/리스트.png" class="sidebar-icon">개설된 그룹
						</a>
						<a class="collapse-item" id="colItems" href="joininggroups"> 
							<img src="resources/img/menu/리스트.png" class="sidebar-icon">가입한 그룹
						</a>
						<a class="collapse-item" id="colItems" href="createGroupPage">
							<img src="resources/img/menu/리스트.png" class="sidebar-icon">그룹 개설
						</a>
					</div>
				</div>
			</li>

			<li>
				<a class="collapsed" href="#" data-toggle="collapse"
				data-target="#collapseTwo" aria-expanded="true"
				aria-controls="collapseTwo">
				<img src="resources/img/menu/마이페이지.png" class="sidebar-icon">
			<span class="sidebar-component">마이페이지</span></a>
				<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
					data-parent="#accordionSidebar">
					<div class="py-2 collapse-inner rounded">
						<a class="collapse-item" id="colItems" href="personalInfoPage">
							<img src="resources/img/menu/회원정보확인.png" class="sidebar-icon">회원 정보 확인
						</a>
						<a class="collapse-item" id="colItems" href="personalInfoChkPw">
							<img src="resources/img/menu/회원정보확인.png" class="sidebar-icon">회원 정보 수정
						</a>
						<a class="collapse-item" id="colItems"
							href="activity?page=1&compage=1&userid=<%=session.getAttribute("userID")%>">
							<img src="resources/img/menu/리스트.png" class="sidebar-icon">나의 활동
						</a>
					</div>
				</div>
			</li>
			
			<!-- 임시로 넣은 사이드바 하단 요소 -->
			<li id="sidebar-bottom">
				<div>
					<img src="resources/img/logo3.png" style="width:200px">
					<p class="font-weight-500">모두의 코딩교실</p>
				</div>
			</li>
		</ul>
	</div>
</body>
</html>