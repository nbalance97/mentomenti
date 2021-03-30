<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="../../bootstrap/css/bootstrap.min.css" rel="stylesheet" />
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	img {
  		width: 100px;
  		height: 100px;
  		object-fit: cover;
	}
	.shadow {
    	box-shadow: 0 .15rem 1.75rem 0 rgba(58,59,69,.15)!important;
	}
	li{
		list-style:none;
	}
	.logo{
		color:white;
	}
	.sidefont{
		font-size:20px;
	}
	.sidebar-heading{
		font-size:25px;
		color:white;
	}
	span[class="sidefont"], a:link{
		color:#fff;
		text-decoration:none;
	}
	.topmenu{
		background-color: #6495ED;
		text-align: center;
	}
	div[class="sidebar"]{
		width:300px;
		height:100%;
		position:fixed;
		top:0;
		background:#000;
		left:-300px;
		z-index:1;
		transition:all .35s;
		opacity: 0.8;
	}
	input[id="menuicon"]:checked +label + div{
		left:0;
	}
	input[id="menuicon"] +label {
		display:block;
		width:30px;
		height:25px;
		top:20px;
		position:fixed;
		left:0;
		transition:all .35s;
		cursor:pointer;
	}
	input[id="menuicon"]:checked +label {
		z-index:2;
		left:300px;
	}
	input[id="menuicon"]{
		display:none;
	}
	input[id="menuicon"]+label span{
		display:block;
		position:absolute;
		width:100%;
		height:5px;
		border-radius:30px;
		background:#888;
		transition:all .35s;
	}
	input[id="menuicon"] + label span:nth-child(1){
		top:0;
	}
	input[id="menuicon"] + label span:nth-child(2){
		top:50%;
		transform:translateY(-50%);
	}
	input[id="menuicon"] + label span:nth-child(3){
		bottom:0;
	}
	input[id="menuicon"]:checked + label span:nth-child(1){
		top:50%;
		transform:translateY(-50%) rotate(45deg);
	}
	input[id="menuicon"]:checked + label span:nth-child(2){
		opacity:0;
	}
	input[id="menuicon"]:checked + label span:nth-child(3){
		bottom:50%;
		transform:translateY(50%) rotate(-45deg);
	}
</style>
</head>
<body>

<input type="checkbox" id="menuicon">
<label for="menuicon">
	<span></span>
	<span></span>
	<span></span>
</label>
<div class="sidebar">
<!-- 왼쪽 메뉴바 -->
	<ul>
			<!-- MOCO클릭시 메인(home)으로이동 -->
            <!-- <a href="#"> -->
            	<br>
            	<!-- <div style="font-size:50px;">MOCO<sup style="font-size:10px;">모두의 코딩</sup></div> -->
                <div style="font-size:30px; color:white;text-align:center;">프로필</div><br>
                <span class="d-none d-lg-block">
                	<img class="img-fluid img-profile rounded-circle mx-auto mb-2 img-circle" src="../../img/logo.png" alt="">
                	<a href="#"><span>로그인이 필요합니다!</span></a>
                </span>
            <!-- </a> -->
            
            <!-- 메뉴분리선 -->
            <br>
            <hr>

            <!-- 공지사항 메뉴 -->
            <li>
                <a class="nav-link" href="#">
                    <span class="sidefont">공지사항</span></a>
            </li>

            <!-- 메뉴분리선 -->
            <hr>

            <!-- 그룹 메뉴 -->
            <div class="sidebar-heading">
                	그룹
            </div>

            <!-- 그룹 세부메뉴 -->
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <span class="sidefont">그룹 개설</span>
                </a>
            </li>

            <!-- 그룹 세부메뉴 -->
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <span class="sidefont">가입 그룹</span>
                </a>
            </li>

            <!-- 메뉴분리선 -->
            <hr>
            
            <!-- 게시판 메뉴 -->
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <span class="sidefont">게시판</span>
                </a>
            </li>
            
            <!-- 메뉴분리선 -->
            <hr>

            <!-- 마이페이지 메뉴 -->
            <li class="nav-item">
                <a class="nav-link" href="#">
                    <span class="sidefont">마이페이지</span></a>
            </li>

            <!-- 메뉴분리선 -->
            <hr>
        </ul>
</div>

<div class="topmenu navbar-inverse shadowy">
	<div class="container">
		<h1 class ="logo display-3">
			MOCO!<sup>모두의 코딩</sup>
		</h1>
	</div>
</div>

</body>
</html>