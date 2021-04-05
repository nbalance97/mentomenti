<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>MOCO</title>

    <link href="resources/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    <link href="resources/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<%@include file="menuPart1.jsp" %>

					<div class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">개설된 그룹</h1>						
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
                    <p class="mb-4">스터디에 참여할 그룹을 찾아보세요.</p>
                   
                    
                    <!-- 컴파일러가 C언어, 자바, 파이썬을 지원하므로 해당 언어들과 기타 그룹으로 분류해서 보여줌 (추후 수정 가능성) -->
                    
                    <div class="row">
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                            	<a href="#" style="text-decoration:none;">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">C언어 그룹</div>
                                        </div>
                                        <div class="col-auto">
                                        	<div class="font-weight-bold text-primary mb-1">
                                                (10)</div>
                                        </div>
                                    </div>
                                </div>
                                </a>
                            </div>
                        </div>

                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                            	<a href="#" style="text-decoration:none;">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">JAVA 그룹</div>
                                        </div>
                                        <div class="col-auto">
                                        	<div class="font-weight-bold text-success mb-1">
                                                (5)</div>
                                        </div>
                                    </div>
                                </div>
                                </a>
                            </div>
                        </div>

                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-info shadow h-100 py-2">
                            	<a href="#" style="text-decoration:none;">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">Python 그룹</div>
                                        </div>
                                        <div class="col-auto">
                                        	<div class="font-weight-bold text-info mb-1">(7)
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                </a>
                            </div>
                        </div>

                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-left-warning shadow h-100 py-2">
                            	<a href="#" style="text-decoration:none;">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="h5 mb-0 font-weight-bold text-gray-800">기타 그룹</div>
                                        </div>
                                        <div class="col-auto">
                                            <div class="font-weight-bold text-warning mb-1">
                                                	(3)</div>
                                        </div>
                                    </div>
                                </div>
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
						<h5 class="h5 mb-0 text-gray-800">그룹 목록</h5>
                    </div>
                    
                    <div class="row">
                    	<div class="col-lg-4">
                    		<div class="card shadow mb-4">
                                <div class="card-header py-3">
                                	<!-- 그룹 이름 및 상세 정보 페이지로 넘어가는 버튼 -->
                                    <h5 class="m-0 font-weight-bold text-primary">C언어 기초 스터디
                                    	<!-- 버튼 모양 수정 예정 -->
                                    	<a href="#" class="btn btn-warning btn-circle btn-sm" style="float:right">
                                    	<i class="fas fa-check"></i></a>
                                    </h5>
                                </div>
                                
                                <div class="card-body"> <!-- 간단한 그룹 정보 -->
                                	<p>과목 : C언어
                                	<p>설명 : 병훈짱이 캐리하는 그룹입니다</p>
                                	<p>멘토 : 이병훈</p>
                                	<p>인원 수 : 5/10</p>
                                </div>
                            </div>
                            
                    		<div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h5 class="m-0 font-weight-bold text-primary">자바 GUI 스터디
                                    	<a href="#" class="btn btn-warning btn-circle btn-sm" style="float:right">
                                    	<i class="fas fa-check"></i></a>
                                    </h5>
                                </div>
                                
                                <div class="card-body">
                                	<p>과목 : JAVA
                                	<p>설명 : 병훈짱이 캐리하는 그룹입니다</p>
                                	<p>멘토 : 이병훈</p>
                                	<p>인원 수 : 5/10</p>
                                </div>
                            </div>
                    	</div>
                    	
                    	<div class="col-lg-4">
                    		<div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h5 class="m-0 font-weight-bold text-primary">파이썬 고수만 컴온
                                    	<a href="#" class="btn btn-warning btn-circle btn-sm" style="float:right">
                                    	<i class="fas fa-check"></i></a>
                                    </h5>
                                </div>
                                
                                <div class="card-body">
                                	<p>과목 : 파이썬
                                	<p>설명 : 주 2회 스터디 진행합니다. 열심히 참여하실 분만 들어오세요!!!</p>
                                	<p>멘토 : 이병훈</p>
                                	<p>인원 수 : 5/10</p>
                                </div>
                            </div>
                            
                    		<div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h5 class="m-0 font-weight-bold text-primary">그룹 이름 짓기 귀찮다
                                    	<a href="#" class="btn btn-warning btn-circle btn-sm" style="float:right">
                                    	<i class="fas fa-check"></i></a>
                                    </h5>
                                </div>
                                
                                <div class="card-body">
                                	<p>과목 : ?
                                	<p>설명 : 아무튼 들어오셈 ㅋㅋ</p>
                                	<p>멘토 : 이병훈</p>
                                	<p>인원 수 : 5/10</p>
                                </div>
                            </div>
                    	</div>
                    	
                    	<div class="col-lg-4">
                    		<div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h5 class="m-0 font-weight-bold text-primary">스터디
                                    	<a href="#" class="btn btn-warning btn-circle btn-sm" style="float:right">
                                    	<i class="fas fa-check"></i></a>
                                    </h5>
                                </div>
                                
                                <div class="card-body">
                                	<p>과목 : ?
                                	<p>설명 : 병훈짱이 캐리하는 그룹입니다</p>
                                	<p>멘토 : 이병훈</p>
                                	<p>인원 수 : 5/10</p>
                                </div>
                            </div>
                            
                    		<div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h5 class="m-0 font-weight-bold text-primary">스터디
                                    	<a href="#" class="btn btn-warning btn-circle btn-sm" style="float:right">
                                    	<i class="fas fa-check"></i></a>
                                    </h5>
                                </div>
                                
                                <div class="card-body">
                                	<p>과목 : ?
                                	<p>설명 : 병훈짱이 캐리하는 그룹입니다</p>
                                	<p>멘토 : 이병훈</p>
                                	<p>인원 수 : 5/10</p>
                                </div>
                            </div>
                    	</div>
                    </div>
                    
                    <!-- 그룹 개설 버튼, 화면 고정 -->
                    <a href="#" class="btn btn-success btn-circle"
                    style="position:fixed; right:20px; bottom:20px; width:70px; height:70px; box-shadow:0px 0px 10px rgba(0,0,0,0.3)">
                    	<h1>+</h1></a>

<%@include file="menuPart2.jsp"%>