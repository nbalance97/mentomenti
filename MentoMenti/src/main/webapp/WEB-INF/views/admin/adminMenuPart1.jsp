<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="Mento.Menti.Project.controller.HomeController"%>
<%@ page
	import="Mento.Menti.Project.dto.UserDTO, Mento.Menti.Project.dao.UserDAO"%>

<%@ page import="java.util.List"%>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>MOCO ADMIN</title>
<link href="resources/css/basic.css" rel="stylesheet" type="text/css">
<!-- 기본 css -->
<link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">
</head>

<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">


<style>
::selection {
	background: #002266;
	color: white;
}

.menuComponent{
	margin:0 15px;
	font-weight:400;
	color:white;
}

</style>

<body id="page-top" style="background-color:#f8f9fc;">

	<%
		//세션에서 아이디, 닉네임 받아오기
	String id = (String) session.getAttribute("userID");
	String nickname = (String) session.getAttribute("nickname");
	
	if (id == null){	//로그인 X 상태
		response.sendRedirect("loginPage?mode=nidLogin");
	}
	
	UserDTO user = new UserDTO();
	user.setId(id);
	boolean isAdmin = HomeController.dao.getUserDAO().searchUserById(user).get(0).is_admin();
	
	if (!isAdmin){
		response.sendRedirect("rejectedAccess?type=notAdmin");
	}
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
					style="position: fixed; width: 100%; background: #002266;">
					
					<!-- 메인 이동 -->
					<div>
						<a href="main" class="font-weight-400" style="color:white; text-decoration:none;">
						메인으로
						</a>
					</div>
				
					<!-- 관리 메뉴 -->
					<div style="margin:0 auto; width:400px; text-align:center;">
						<a href="adminUserPage"><span class="menuComponent">사용자</span></a>
						<a href="adminPostPage"><span class="menuComponent">게시물</span></a>
						<a href="adminCommentPage"><span class="menuComponent">댓글</span></a>
						<a href="adminGroupPage"><span class="menuComponent">그룹</span></a>
					</div>
					
				</nav>
				<!-- End of Topbar -->

				<!-- <section>  -->
				<div id="contentSection">

					<!-- Begin Page Content -->
					<div class="container-fluid">