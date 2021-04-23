<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<style>
	::selection{background:#002266; color:white;}
</style>

<!-- body 여는 태그부터  본문 여는 태그까지 포함-->

<body id="page-top">

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

						<!-- Nav Item - Alerts -->
						<li class="nav-item dropdown no-arrow mx-1"><a
							class="nav-link dropdown-toggle" href="#" id="alertsDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <i class="fas fa-bell fa-fw"></i> <!-- Counter - Alerts -->
								<span class="badge badge-danger badge-counter">100</span>
						</a> <!-- Dropdown - Alerts -->
							<div
								class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="alertsDropdown">
								<h6 class="dropdown-header" style="background: black;">알림</h6>
								<a class="dropdown-item d-flex align-items-center" href="#">
									<div class="mr-3">
										<div class="icon-circle bg-primary">
											<i class="fas fa-file-alt text-white"></i>
										</div>
									</div>
									<div>
										<div class="small text-gray-500">2021/03/30 15:19</div>
										<span>"자바를 자바" 그룹의 수업이 시작되었습니다.</span>
									</div>
								</a> <a class="dropdown-item d-flex align-items-center" href="#">
									<div class="mr-3">
										<div class="icon-circle bg-success">
											<i class="fas fa-donate text-white"></i>
										</div>
									</div>
									<div>
										<div class="small text-gray-500">2021/03/27 08:40</div>
										<span>"C언어 초보" 그룹에 새로운 공지가 올라왔습니다.</span>
									</div>
								</a> <a class="dropdown-item d-flex align-items-center" href="#">
									<div class="mr-3">
										<div class="icon-circle bg-warning">
											<i class="fas fa-exclamation-triangle text-white"></i>
										</div>
									</div>
									<div>
										<div class="small text-gray-500">2021/03/25 11:30</div>
										"웹 개발 스터디" 그룹의 인원이 마감되었습니다.
									</div>
								</a> <a class="dropdown-item text-center small text-gray-500"
									href="#">모든 알림 보기</a>
							</div></li>

						<!-- 쪽지 아이콘 삭제 -->

						<div class="topbar-divider d-none d-sm-block"></div>
						<%
							String id = (String)session.getAttribute("userID");	//세션에서 아이디 받아오기
							
							if (id == null){	//로그인 하지 않은 상태
						%>
							<!-- 클릭 시 로그인 화면으로 이동 -->
							<li class="nav-item dropdown no-arrow">
							<a class="nav-link dropdown-toggle" href="loginPage" id="userDropdown"
							role="button" aria-haspopup="true" aria-expanded="false">
							<span class="mr-2 d-none d-lg-inline text-gray-600 small">로그인</span>
							<img class="img-profile rounded-circle" src="/resources/img/undraw_profile_1.svg">
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
							<span class="mr-2 d-none d-lg-inline text-gray-600 small"><%=id%></span> <!-- 아이디 -->
							<img class="img-profile rounded-circle" src="/resources/img/undraw_profile_1.svg">
							</a>
							
							<!-- Dropdown - User Information -->
							<div
								class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="userDropdown">
								<a class="dropdown-item" href="#"> <i
									class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> 프로필
								</a> <a class="dropdown-item" href="#"> <i
									class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i> 개인 정보
									수정
								</a> <a class="dropdown-item" href="#"> <i
									class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i> 나의 활동
								</a>
								<div class="dropdown-divider"></div>
								
								<!-- logoutModal은 menuPart2.jsp에 -->
								<a class="dropdown-item" href="#" data-toggle="modal"
									data-target="#logoutModal"> <i
									class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
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