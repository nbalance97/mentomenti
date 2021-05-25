<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>
<%@ page
	import="Mento.Menti.Project.dto.NotificationDTO, Mento.Menti.Project.dao.NotificationDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.io.File" %>

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<!-- 파비콘 설정 -->
<link rel="shortcut icon" href="resources/img/logo3.png">
<link rel="icon" href="resources/img/logo3.png">

<style>
	::selection{background:#002266; color:white;}
	
	/*기본 폰트 Noto Sans, font-weight:300, 부분마다 font-weight 바꿔서 사용하면 됨*/
	*{
		font-family: 'Noto Sans KR', sans-serif;
		font-weight: 300;
	}
</style>

<!-- body 여는 태그부터  본문 여는 태그까지 포함-->

<body id="page-top">

	<%
	//세션에서 아이디, 닉네임 받아오기
	String id = (String)session.getAttribute("userID");
	String nickname = (String)session.getAttribute("nickname");
	%>

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<nav
					class="navbar navbar-expand navbar-light topbar mb-4 static-top shadow sticky-top"
					style="position: fixed; width: 100%; background: #002266">

						<!-- Topbar Navbar -->
						<ul class="navbar-nav ml-auto">
						
						<!-- 알림 아이콘 -->
						<%@include file="topbarNotification.jsp"%>
						</ul>

						<!-- 쪽지 아이콘 삭제 -->

						<div class="topbar-divider d-none d-sm-block"></div>
						<%
							
							if (id == null){	//로그인 하지 않은 상태
						%>
							<!-- 클릭 시 로그인 화면으로 이동 -->
							<li class="nav-item dropdown no-arrow">
							<a class="nav-link dropdown-toggle" href="loginPage" id="userDropdown"
							role="button" aria-haspopup="true" aria-expanded="false">
							<span class="mr-2 d-none d-lg-inline small" style="color:white;">로그인</span>
							<img class="img-profile rounded-circle" src="resources/img/user.png">
							</a>
							<%
								}
								else{	//로그인 한 상태
							%>
							
							<!-- 클릭 시 드롭다운 메뉴 나옴 -->
							<li class="nav-item dropdown no-arrow">
							<a class="nav-link dropdown-toggle" href="loginPage" id="userDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false">
							<span class="mr-2 d-none d-lg-inline small" style="color:white;"><%=nickname%>님</span>
							
							
							<!-- 프로필 이미지 -->
							<%
							File pngImg = new File("src/main/resources/static/img/user/"+id+".png");
							File jpgImg = new File("src/main/resources/static/img/user/"+id+".jpg");
							
								if (pngImg.exists()) {
							%>
								<div class="profileImg rounded-circle" style="width:40px; height:40px; float:left; margin-right:10px">
									<img src="resources/img/user/<%=id%>.png" style="width:100%; height:100%; object-fit: cover;">
								</div>
							<%
								} else if (jpgImg.exists()){
							%>
								<div class="profileImg rounded-circle" style="width:40px; height:40px; float:left; margin-right:10px">
									<img src="resources/img/user/<%=id%>.jpg" style="width:100%; height:100%; object-fit: cover;">
								</div>
							<%
								} else {
							%>
								<div class="profileImg rounded-circle" style="width:40px; height:40px; float:left; margin-right:10px">
									<img src="resources/img/user/user.png" style="width:100%; height:100%; object-fit: cover;">
								</div>
							<%
								}
							%>



							
							</a>
							
							<!-- Dropdown - User Information -->
							<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="userDropdown">
								<a class="dropdown-item" href="personalInfoPage">
								<img src="resources/img/menu/user.png" class="sidebar-icon"> 프로필
								</a>
								
								<a class="dropdown-item" href="personalInfoChkPw">
								<img src="resources/img/menu/gear.png" class="sidebar-icon"> 개인 정보 수정
								</a>
								
								<a class="dropdown-item" href="activity?page=1&compage=1">
								<img src="resources/img/menu/list.png" class="sidebar-icon"> 나의 활동
								</a>
								
								<%
								UserDTO user = new UserDTO();
								user.setId(id);
								boolean isAdmin = HomeController.dao.getUserDAO().searchUserById(user).get(0).is_admin();
								
								if (isAdmin){
								%>
								<a class="dropdown-item" href="adminPage"> 
									<img src="resources/img/menu/manage.png" class="sidebar-icon">
									관리자 페이지
								</a>
								<%
								}
								%>
								
								<div class="dropdown-divider"></div>
								
								<!-- logoutModal은 menuPart2.jsp에 -->
								<a class="dropdown-item" href="#" data-toggle="modal"
									data-target="#logoutModal"> <img src="resources/img/menu/exit.png" class="sidebar-icon">
									로그아웃
								</a>
							</div>
							<%
								}
							%>
						</li>

					</ul>

				</nav>
				<!-- End of Topbar -->


				<%@include file="sideBar.jsp"%>
				<!-- 사이드바 -->

				<!-- <section>  -->
				<div id="contentSection">

					<!-- Begin Page Content -->
					<div class="container-fluid">