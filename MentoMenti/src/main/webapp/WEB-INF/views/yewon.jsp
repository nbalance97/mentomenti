<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>MOCO</title>

<link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">
<link href="resources/css/sidebar.css" rel="stylesheet" type="text/css">

</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<nav
					class="navbar navbar-expand navbar-light topbar mb-4 static-top shadow"
					style="position: fixed; width: 100%; background:black"> <!-- bg-white 지움 -->

					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto" style="z-index:99">

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
								<h6 class="dropdown-header">알림</h6>
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

						<!-- Nav Item - Messages -->
						<li class="nav-item dropdown no-arrow mx-1"><a
							class="nav-link dropdown-toggle" href="#" id="messagesDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <i class="fas fa-envelope fa-fw"></i>
								<!-- Counter - Messages --> <span
								class="badge badge-danger badge-counter">7</span>
						</a> <!-- Dropdown - Messages -->
							<div
								class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="messagesDropdown">
								<h6 class="dropdown-header">메세지</h6>
								<a class="dropdown-item d-flex align-items-center" href="#">
									<div class="dropdown-list-image mr-3">
										<img class="rounded-circle" src="img/undraw_profile_2.svg"
											alt="">
										<div class="status-indicator bg-success"></div>
									</div>
									<div>
										<div class="text-truncate">오늘 3시에 수업 있습니다. 늦지 말고 들어오세요.</div>
										<div class="small text-gray-500">선바(C언어 초보) · 58분전</div>
									</div>
								</a> <a class="dropdown-item d-flex align-items-center" href="#">
									<div class="dropdown-list-image mr-3">
										<img class="rounded-circle" src="img/undraw_profile_3.svg"
											alt="">
										<div class="status-indicator bg-success"></div>
									</div>
									<div>
										<div class="text-truncate">안녕하세요 여러분 오티 자료를 그룹 공지사항에
											올렸으니 확인하시길 바랍니다.</div>
										<div class="small text-gray-500">한서현(자바를 자바) · 1주전</div>
									</div>
								</a> <a class="dropdown-item text-center small text-gray-500"
									href="#">모든 메세지 확인하기</a>
							</div></li>

						<div class="topbar-divider d-none d-sm-block"></div>

						<!-- Nav Item - User Information -->
						<li class="nav-item dropdown no-arrow"><a
							class="nav-link dropdown-toggle" href="#" id="userDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <span
								class="mr-2 d-none d-lg-inline text-gray-600 small">김모코</span> <img
								class="img-profile rounded-circle" src="img/undraw_profile.svg">
						</a> <!-- Dropdown - User Information -->
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
								<a class="dropdown-item" href="#" data-toggle="modal"
									data-target="#logoutModal"> <i
									class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
									로그아웃
								</a>
							</div></li>

					</ul>

				</nav>
				<!-- End of Topbar -->


				<%@include file="sideBar.jsp"%>
				<!-- 사이드바 -->
 
				<!-- <section>  -->
				<div id="tmpSection">

					<!-- Begin Page Content -->
					<div class="container-fluid">

						<!-- 공지사항 페이지 -->

						<!-- Page Heading -->
						<div
							class="d-sm-flex align-items-center justify-content-between mb-4"
							style="padding-top: 100px">
							<h1 class="h3 mb-0 text-gray-800">공지사항</h1>
							<ul class="navbar-nav ml-auto">
								<li>
									<form
										class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search" style="z-index:1">
										<div class="input-group">
											<input type="text" class="form-control border-0 small"
												placeholder="검색" aria-label="Search"
												aria-describedby="basic-addon2">
											<div class="input-group-append">
												<button class="btn btn-primary" type="button">
													<i class="fas fa-search fa-sm"></i>
												</button>
											</div>
										</div>
									</form>
								</li>
							</ul>
						</div>
						<p class="mb-4">모두의 코딩교실의 공지사항입니다.</p>

						<!-- 리스트 -->
						<table class="table table-bordered dataTable" id="dataTable"
							width="100%" cellspacing="0" role="grid"
							aria-describedby="dataTable_info"
							style="width: 100%; background: white; text-align: center;">
							<thead>
								<tr role="row">
									<th tabindex="0" rowspan="1" colspan="1" style="width: 100px;">No.</th>
									<th tabindex="0" rowspan="1" colspan="1" style="width: 61px;">제목</th>
									<th tabindex="0" rowspan="1" colspan="1" style="width: 49px;">작성자</th>
									<th tabindex="0" rowspan="1" colspan="1" style="width: 31px;">조회수</th>
								</tr>
							</thead>
							<tbody>
								<%
									for (int i = 0; i < 15; i++) {
								%>
								<tr role="row" class="odd">
									<td class="">1</td>
									<td>모코 사이트 이용 방법 안내</td>
									<td>정예원</td>
									<td>62</td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>

						<!-- 페이지 버튼 -->
						<div class="d-flex align-items-center justify-content-between">
							<div style="margin: 0 auto;">
								<a href="#" class="btn-primary"
									style="width: 40px; height: 10px; font-size: 15px; padding: 5px; border-radius: 5px; text-decoration: none">
									<<</a>
								<%
									for (int j = 1; j <= 10; j++) {
								%>
								<a href="#" style="text-decoration: none"> <%
 	out.println(j);
 %>
								</a>
								<%
									}
								%>
								<a href="#" class="btn-primary"
									style="width: 40px; height: 10px; font-size: 15px; padding: 5px; border-radius: 5px; text-decoration: none">
									>></a>
							</div>

							<div class="d-sm-flex justify-content-between">
								<div style="margin: 0 auto; float: right">
									<a href="#" class="btn btn-secondary">작성</a>
								</div>
							</div>
						</div>


						<!-- 본문 닫는 태그부터 body 닫는 태그까지 포함-->

					</div>
					<!-- /.container-fluid -->

					<!-- Footer -->
					<footer class="sticky-footer">
						<div class="container my-auto">
							<div class="copyright text-center my-auto">
								<span>Copyright © Your Website 2020</span>
							</div>
						</div>
					</footer>
					<!-- End of Footer -->

				<!-- </section> -->
				</div>


			</div>
			<!-- End of Main Content -->


		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<!-- Logout Modal-->
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">로그아웃</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">로그아웃 하시겠습니까?</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">취소</button>
					<a class="btn btn-primary" href="login.html">로그아웃</a>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin-2.min.js"></script>

</body>
</html>