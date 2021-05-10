<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>MOCO</title>
<link href="resources/css/basic.css" rel="stylesheet" type="text/css">	<!-- 기본 css -->
<link href="resources/css/sidebar.css" rel="stylesheet" type="text/css" media="screen and (min-width:768px)"> <!-- PC 환경 사이드바 css -->
<link href="resources/css/sidebar_phone.css" rel="stylesheet" type="text/css" media="screen and (max-width:767px)">	<!-- 모바일 환경 사이드바 CSS -->
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
</head>

<script>
	window.onload=function(){
		var chkBtn = document.getElementById('check');
		var sideBar = document.getElementsByClassName('sidebar2');
		
		if(matchMedia("screen and (min-width:768px)").matches){	//PC 환경
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
	<label for="check"> <i class="fas fa-bars" id="btn"></i> <!-- 펼치는 버튼 -->
		<i class="fas fa-times" id="cancel"></i> <!-- 접는 버튼 -->
	</label>


	<div class="sidebar2" style="background: #002266">
		<!-- 사이드바 메뉴 -->
		<header class="font-weight-700" style="background: #002266">
			<a href="main" class="sideLogo" style="text-decoration:none;">MOCO</a>
		</header>
		<ul class="navbar-nav sidebar accordion" id="accordionSidebar">
			<li><a href="notice">
				<i class="fas fa-check-circle"></i>
				<span class="sidebar-component">공지사항</span>
			</a></li>
			<li><a href="freeBoard"><i class="fas fa-clipboard-list"></i>
				<span class="sidebar-component">자유게시판</span>
			</a></li>

			<li><a class="collapsed" href="#" data-toggle="collapse"
				data-target="#collapseOne" aria-expanded="true"
				aria-controls="collapseOne"> <i class="fas fa-users"></i><span class="sidebar-component">그룹</span>
			</a>
				<div id="collapseOne" class="collapse" aria-labelledby="headingTwo"
					data-parent="#accordionSidebar">
					<div class="py-2 collapse-inner rounded">
						<a class="collapse-item" id="colItems" href="openedGroups"> <i
							class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>개설된 그룹
						</a> <a class="collapse-item" id="colItems" href="joininggroups"> <i
							class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>가입한 그룹
						</a>
						<a class="collapse-item" id="colItems" href="createGroupPage"> <i
							class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>그룹 개설
						</a>
					</div>
				</div></li>

			<li><a class="collapsed" href="#" data-toggle="collapse"
				data-target="#collapseTwo" aria-expanded="true"
				aria-controls="collapseTwo"> <i class="fas fa-user"></i><span class="sidebar-component">마이페이지</span></a>
				<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
					data-parent="#accordionSidebar">
					<div class="py-2 collapse-inner rounded">
						<a class="collapse-item" id="colItems" href="personalInfoPage">
							<i class="fas fa-user-check fa-sm fa-fw mr-2 text-gray-400"></i>회원 정보
							확인
						</a>
						<a class="collapse-item" id="colItems" href="activity?page=1"> <i
							class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>나의 활동
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