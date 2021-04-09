<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html lang="en"><head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>MOCO</title>

    <!-- Custom fonts for this template-->
    <link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="resources/css/sb-admin-2.min.css" rel="stylesheet">
    <link href="resources/css/sidebar.css" rel="stylesheet" type="text/css">

</head>

<body id="page-top">

	<%@include file="sideBar.jsp" %>

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="main.jsp">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">MOCO</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item">
                <a class="nav-link" href="index.html">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>공지사항</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                	수업
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fas fa-fw fa-cog"></i>
                    <span>그룹</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="#">개설된 그룹</a>
                        <a class="collapse-item" href="#">가입한 그룹</a>
                    </div>
                </div>
            </li>

            <!-- Nav Item - Dashboard -->
            <li class="nav-item">
                <a class="nav-link" href="index.html">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>게시판</span></a>
            </li>
            
            <!-- Divider -->
            <hr class="sidebar-divider">

            <div class="sidebar-heading">
                	계정 관리
            </div>
            <!-- Nav Item - Charts -->
            <li class="nav-item">
                <a class="nav-link" href="charts.html">
                    <i class="fas fa-fw fa-chart-area"></i>
                    <span>마이페이지</span></a>
            </li>
            
            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->

                <!-- End of Topbar -->
                
                <%@include file="sideBar.jsp" %>

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
					<div class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">공지사항</h1>						
						<ul class="navbar-nav ml-auto">
							<li>
								<form class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                        			<div class="input-group">
                            			<input type="text" class="form-control border-0 small" placeholder="검색" aria-label="Search" aria-describedby="basic-addon2">
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
					<table class="table table-bordered dataTable" id="dataTable" width="100%" cellspacing="0" role="grid" aria-describedby="dataTable_info" style="width: 100%; background:white; text-align:center;">
                    	<thead>
                        	<tr role="row">
	                        	<th tabindex="0" rowspan="1" colspan="1" style="width: 100px;">No.</th>
	                        	<th tabindex="0" rowspan="1" colspan="1" style="width: 61px;">제목</th>
	                        	<th tabindex="0" rowspan="1" colspan="1" style="width: 49px;">작성자</th>
	                        	<th tabindex="0" rowspan="1" colspan="1" style="width: 31px;">조회수</th>
                        	</tr>
                        </thead>
                        <tbody>
                        <% for (int i=0;i<7;i++ ){ %>
                            <tr role="row" class="odd">
                            	<td class="">1</td>
                            	<td>모코 사이트 이용 방법 안내</td>
                            	<td>정예원</td>
                            	<td>62</td>
                            </tr>
                        <%} %>
                       </tbody>
                   </table>
                   
                   <!-- 페이지 버튼 -->
                   <div class="d-flex align-items-center justify-content-between">
                   		<div style="margin:0 auto;">
                   			<a href="#" class="btn-primary" style="width:40px; height:10px; font-size:15px; padding:5px; border-radius:5px; text-decoration:none">
                   			<<</a>
                   			<%
                   				for(int j=1; j<=10; j++){
                   			%>
                   			<a href="#" style="text-decoration:none">
                   					<%out.println(j);%>
                   			</a>
                   			<%
                   				}
                   			%>
                   			<a href="#" class="btn-primary" style="width:40px; height:10px; font-size:15px; padding:5px; border-radius:5px; text-decoration:none">
                   			>></a>
                   		</div>
                   		
                   		<div class="d-sm-flex justify-content-between">
                   			<div style="margin:0 auto; float:right">
                   				<a href="#" class="btn btn-secondary">작성</a>
                   			</div>
                   		</div>
                   </div>

                                   </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright © Your Website 2020</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">로그아웃</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">로그아웃 하시겠습니까?</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
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



</body></html>