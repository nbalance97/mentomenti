<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.NotificationDTO, Mento.Menti.Project.dao.NotificationDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.io.*"%>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="javax.imageio.ImageIO" %>

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">


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

						<!-- 알림 아이콘 -->
						<%@include file="topbarNotification.jsp"%>

						<!-- 쪽지 아이콘 삭제 -->

						<div class="topbar-divider d-none d-sm-block"></div>
						<%
							
							if (id == null){	//로그인 하지 않은 상태
						%>
							<!-- 클릭 시 로그인 화면으로 이동 -->
							<li class="nav-item dropdown no-arrow">
							<a class="nav-link dropdown-toggle" href="loginPage" id="userDropdown"
							role="button" aria-haspopup="true" aria-expanded="false">
							<span class="mr-2 d-none d-lg-inline small">로그인</span>
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
							<span class="mr-2 d-none d-lg-inline small" ><%=nickname%>님</span>
							
							
							<!-- 프로필 이미지 -->							
							<%
								File pngImg = new File("src/main/resources/static/img/user/"+id+".png");
								File jpgImg = new File("src/main/resources/static/img/user/"+id+".jpg");
								
								if (pngImg.exists()) {
							%>
								<div class="pngProfile profileImg rounded-circle"
									style="width: 40px; height:40px; background-image:url('resources/img/user/<%=id%>.png')"></div>
							<%
								} else if (jpgImg.exists()){
							%>
								<div class="jpgProfile profileImg rounded-circle"
									style="width: 40px; height:40px; background-image:url('resources/img/user/<%=id%>.jpg')"></div>
							<%
								} else {
							%>
								<div class="defaultProfile profileImg rounded-circle"
									style="width: 40px; height:40px; background-image:url('resources/img/user/user.png')"></div>
							<%
								}
							%>
							
							</a>
							
							<!-- Dropdown - User Information -->
							<div
								class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="userDropdown">
								<a class="dropdown-item" href="personalInfoPage"> <i
									class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> 프로필
								</a> <a class="dropdown-item" href="personalInfoChange"> <i
									class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i> 개인 정보
									수정
								</a> <a class="dropdown-item" href="activity?page=1"> <i
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